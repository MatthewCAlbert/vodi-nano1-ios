//
//  DraftItemListView.swift
//  VODI
//
//  Created by Matthew Christopher Albert on 27/04/22.
//

import SwiftUI

struct DraftItemListView: View {
    let model = DraftItemListViewModel()
    
    var body: some View {
        VStack {
            Text("Inventory Item List")
            GeometryReader { metrics in
                List {
                    ForEach(model.items, id: \.id) { item in
                        HStack {
                            Image(uiImage: UIImage(named: "ExampleShirt")!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70, alignment: .center)
                            Text(item.name)
                        }
                        .swipeActions(edge: .leading) {
                            Button("Edit") {
                                print("Edit")
                            }
                            .tint(.blue)
                        }
                        .swipeActions(edge: .trailing) {
                            Button("Delete", role: .destructive) {
                                print("Delete")
                            }
                        }
                    }
                }
                .onAppear {
                    // Set the default to clear
                    UITableView.appearance().backgroundColor = .clear
                }
                .listStyle(GroupedListStyle())
            }
        }
    }
}

struct DraftItemListView_Previews: PreviewProvider {
    static var previews: some View {
        DraftItemListView()
    }
}
