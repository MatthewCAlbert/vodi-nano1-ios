//
//  DraftInventoryItem.swift
//  VODI
//
//  Created by Matthew Christopher Albert on 27/04/22.
//

import Foundation
import RealmSwift

class DraftInventoryItem: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name = ""
    @Persisted var price = 0
    @Persisted var image: String? = nil
}
