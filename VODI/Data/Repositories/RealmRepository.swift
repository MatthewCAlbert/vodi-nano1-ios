//
//  RealmRepository.swift
//  VODI
//
//  Created by Matthew Christopher Albert on 28/04/22.
//

import Foundation
import RealmSwift
import Realm
import Combine
import SwiftUI

protocol AbstractRealmRepository: ObservableObject {
    associatedtype T
    func queryAll() -> AnyPublisher<[T], Error>
    func query(with predicate: NSPredicate,
               sortDescriptors: [NSSortDescriptor]) -> AnyPublisher<[T], Error>
    func delete(entity: T) -> AnyPublisher<T, Error>
}

enum RealmError: Error {
    case error(_ reason: String)
    case notFound
}

class RealmRepository<T: RealmRepresentable>: AbstractRealmRepository where T == T.RealmType.DomainType, T.RealmType : Object {
    private let configuration: Realm.Configuration
    @Published var rows: [T] = []
    
    private var realm: Realm {
        return try! Realm(configuration: self.configuration)
    }
    
    convenience init () {
        // Setting the schema version
        let configuration = Realm.Configuration(schemaVersion: 1)
        self.init(configuration: configuration)
    }
    
    init (configuration: Realm.Configuration) {
        // Letting Realm know we want the defaultConfiguration to be the config variable
        Realm.Configuration.defaultConfiguration = configuration

        // Trying to open a Realm and saving it into the localRealm variable
        self.configuration = configuration
        print("File 📁 url: \(RLMRealmPathForFile("default.realm"))")
    }
    
    func queryAll() -> AnyPublisher<[T], Error> {
        let realm = self.realm
        let objects = realm.objects(T.RealmType.self)
        let rows = objects.mapToDomain()
        self.rows = rows
        
        return Result.Publisher(rows).eraseToAnyPublisher()
    }
    
    func query(with predicate: NSPredicate,
               sortDescriptors: [NSSortDescriptor] = []) -> AnyPublisher<[T], Error> {
        let realm = self.realm
        let objects = realm.objects(T.RealmType.self)
                        .filter(predicate)
                        .sorted(by: sortDescriptors.map(SortDescriptor.init))
        let rows = objects.mapToDomain()
        self.rows = rows
        
        return Result.Publisher(rows).eraseToAnyPublisher()
    }
    
    func queryOne(_ query: (Query<T.RealmType>) -> Query<Bool>) -> AnyPublisher<T, Error> {
        let realm = self.realm
        let objects = realm.objects(T.RealmType.self).where(query)
        if objects.isEmpty {
            return Result.Publisher(RealmError.notFound).eraseToAnyPublisher()
        }
        let rows = objects.mapToDomain()
        
        return Result.Publisher(rows[0]).eraseToAnyPublisher()
    }

    func save(entity: T, _ updateFunction: (T.RealmType) -> Void) -> AnyPublisher<T, Error> {
        do {
            if entity.id == "" {
                // Insert
                let newItem = entity.asRealm()
                try realm.write {
                    realm.add(newItem)
                }
                
                return Result.Publisher(newItem.asDomain()).eraseToAnyPublisher()
            } else {
                // Update
                let id = try ObjectId(string: entity.id)
                let itemsToBeUpdated = realm.objects(T.RealmType.self).filter(NSPredicate(format: "id == %@", id))
                try realm.write {
                    updateFunction(itemsToBeUpdated[0])
                }
                
                return Result.Publisher(itemsToBeUpdated[0].asDomain()).eraseToAnyPublisher()
            }
        } catch {
            return Result.Publisher(RealmError.error(error.localizedDescription)).eraseToAnyPublisher()
        }
    }

    func delete(entity: T) -> AnyPublisher<T, Error> {
        do {
            if entity.id == "" {
                return Result.Publisher(RealmError.notFound).eraseToAnyPublisher()
            }
            let itemToBeDeleted = realm.objects(T.RealmType.self).filter(NSPredicate(format: "id == %@", entity.id))
            guard !itemToBeDeleted.isEmpty else {
                return Result.Publisher(RealmError.notFound).eraseToAnyPublisher()
            }

            // Trying to write to the localRealm
            try realm.write {
                realm.delete(itemToBeDeleted)
            }
            
            return Result.Publisher(entity).eraseToAnyPublisher()
        } catch {
            return Result.Publisher(RealmError.error(error.localizedDescription)).eraseToAnyPublisher()
        }
    }
    
}
