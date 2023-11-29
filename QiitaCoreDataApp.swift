//
//  QiitaCoreDataApp.swift
//  QiitaCoreData
//
//  Created by 澤木柊斗 on 2023/11/29.
//

import SwiftUI

@main
struct QiitaCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
