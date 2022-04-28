//
//  DraftInventoryItem.swift
//  VODI
//
//  Created by Matthew Christopher Albert on 28/04/22.
//

import Foundation

public struct DraftInventoryItem {
    public let id: String
    public let name: String
    public let price: Int
    public let image: String?
    
    public init(name: String,
                price: Int,
                image: String?) {
        self.id = ""
        self.name = name
        self.price = price
        self.image = image
    }
    
    public init(id: String,
                name: String,
                price: Int,
                image: String?) {
        self.id = id
        self.name = name
        self.price = price
        self.image = image
    }
}

extension DraftInventoryItem: Equatable {
    public static func == (lhs: DraftInventoryItem, rhs: DraftInventoryItem) -> Bool {
        return lhs.name == rhs.name &&
            lhs.price == rhs.price &&
            lhs.image == rhs.image
    }
}
