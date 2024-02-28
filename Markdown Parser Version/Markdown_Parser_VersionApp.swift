//
//  Markdown_Parser_VersionApp.swift
//  Markdown Parser Version
//
//  Created by JXMUNOZ on 1/24/24.
//

import SwiftUI

@main
struct Markdown_Parser_VersionApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
}
