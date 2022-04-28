//
//  RMDraftInventoryItem.swift
//  VODI
//
//  Created by Matthew Christopher Albert on 27/04/22.
//

import Foundation
import RealmSwift

class RMDraftInventoryItem: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name = ""
    @Persisted var price = 0
    @Persisted var image: String? = nil
}

extension RMDraftInventoryItem: DomainConvertibleType {
    func asDomain() -> DraftInventoryItem {
        return DraftInventoryItem(
            id: id.stringValue,
            name: name,
            price: price,
            image: image
        )
    }
}

extension DraftInventoryItem: RealmRepresentable {
    func asRealm() -> RMDraftInventoryItem {
        return RMDraftInventoryItem.build { object in
            object.name = name
            object.price = price
            object.image = image
        }
    }
}
