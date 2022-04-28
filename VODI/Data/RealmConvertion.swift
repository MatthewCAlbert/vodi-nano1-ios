//
//  RealmConvertion.swift
//  VODI
//
//  Created by Matthew Christopher Albert on 28/04/22.
//

import Foundation

protocol DomainConvertibleType {
    associatedtype DomainType

    func asDomain() -> DomainType
}

protocol RealmRepresentable {
    associatedtype RealmType: DomainConvertibleType

    var id: String {get}

    func asRealm() -> RealmType
}

extension Sequence where Iterator.Element: DomainConvertibleType {
    typealias Element = Iterator.Element
    func mapToDomain() -> [Element.DomainType] {
        return map {
            return $0.asDomain()
        }
    }
}
