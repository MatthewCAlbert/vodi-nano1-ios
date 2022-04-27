//
//  RealmManager.swift
//  VODI
//
//  Created by Matthew Christopher Albert on 27/04/22.
//

import Foundation
import RealmSwift

class RealmManager {
    static func openRealm() -> Realm? {
        do {
            // Setting the schema version
            let config = Realm.Configuration(schemaVersion: 1)

            // Letting Realm know we want the defaultConfiguration to be the config variable
            Realm.Configuration.defaultConfiguration = config

            // Trying to open a Realm and saving it into the localRealm variable
            return try Realm()
        } catch {
            print("Error opening Realm", error)
            return nil
        }
    }
}
