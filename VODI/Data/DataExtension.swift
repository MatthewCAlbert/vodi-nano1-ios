//
//  DataExtension.swift
//  VODI
//
//  Created by Matthew Christopher Albert on 28/04/22.
//

import Foundation
import RealmSwift

extension Object {
    static func build<O: Object>(_ builder: (O) -> () ) -> O {
        let object = O()
        builder(object)
        return object
    }
}

extension RealmSwift.SortDescriptor {
    init(sortDescriptor: NSSortDescriptor) {
        self.init(keyPath: sortDescriptor.key ?? "", ascending: sortDescriptor.ascending)
    }
}
