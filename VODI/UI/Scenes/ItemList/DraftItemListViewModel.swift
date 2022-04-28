//
//  DraftItemListViewModel.swift
//  VODI
//
//  Created by Matthew Christopher Albert on 28/04/22.
//

import SwiftUI

class DraftItemListViewModel {
    let service = DraftInventoryItemRepository()
    @State var items: [DraftInventoryItem]
    
    init() {
        items = []
    }
}
