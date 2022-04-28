//
//  DraftInventoryItemRepository.swift
//  VODI
//
//  Created by Matthew Christopher Albert on 27/04/22.
//

import Foundation
import RealmSwift
import Combine

protocol DraftInventoryItemRepositoryProtocol {
    var realmRepository: RealmRepository<DraftInventoryItem> {get}
    
    func getAll() -> AnyPublisher<[DraftInventoryItem], Error>
    func getOne(predicate: NSPredicate) -> AnyPublisher<DraftInventoryItem, Error>
    func save(_ item: DraftInventoryItem) -> AnyPublisher<DraftInventoryItem, Error>
    func deleteOne(_ item: DraftInventoryItem) -> AnyPublisher<DraftInventoryItem, Error>
}

class DraftInventoryItemRepository {
    private let realmRepository: RealmRepository<DraftInventoryItem>
    
    convenience init () {
        self.init(configuration: nil)
    }
    
    init (configuration: Realm.Configuration?) {
        if let configuration = configuration {
            realmRepository = RealmRepository<DraftInventoryItem>(configuration: configuration)
        } else {
            realmRepository = RealmRepository<DraftInventoryItem>()
        }
    }
    
    // MARK: Methods here
    
    func getAll() -> AnyPublisher<[DraftInventoryItem], Error> {
        return realmRepository.queryAll()
    }
    
    func getOneById(_ id: String) -> AnyPublisher<DraftInventoryItem, Error> {
        do {
            let idO = try ObjectId(string: id)
            return realmRepository.queryOne() {
                $0.id == idO
            }
        } catch {
            return Result.Publisher(RealmError.error(error.localizedDescription)).eraseToAnyPublisher()
        }
    }
    
    func save(_ item: DraftInventoryItem) -> AnyPublisher<DraftInventoryItem, Error> {
        return realmRepository.save(entity: item) { entity in
            entity.name = item.name
            entity.price = item.price
            entity.image = item.image
        }
    }
    
    func deleteOne(_ item: DraftInventoryItem) -> AnyPublisher<DraftInventoryItem, Error> {
        return realmRepository.delete(entity: item)
    }
}
