//
//  DraftInventoryItemService.swift
//  VODI
//
//  Created by Matthew Christopher Albert on 27/04/22.
//

import Foundation
import RealmSwift
import SwiftUI

protocol RealmServiceProtocol {
    var localRealm: Realm? { get }
}

protocol DraftInventoryItemServiceProtocol {
    
}

struct DraftInventoryItemService: RealmServiceProtocol {
    private(set) var localRealm: Realm?
    
    init() {
        localRealm = RealmManager.openRealm()
    }
    
    func getAll() -> [DraftInventoryItem] {
        if let localRealm = localRealm {
            
            // Getting all objects from localRealm and sorting them by completed state
            let fetchedRows = localRealm.objects(DraftInventoryItem.self).sorted(byKeyPath: "completed")
            
            // Append each task to the tasks array
            var draftItems: [DraftInventoryItem] = []
            fetchedRows.forEach { row in
                draftItems.append(row)
            }
            
            return draftItems
        }
        return []
    }
}

struct StubDraftInventoryItemService {
    
}
