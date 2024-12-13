//
//  TVSearchApp.swift
//  TVSearch
//
//  Created by Tony Ayoub on 11-12-2024.
//

import SwiftUI

@main
struct TVSearchApp: App {
    let persistenceController = PersistenceController.shared
    let service = MazeShowService()
    
    var body: some Scene {
        WindowGroup {
            HomeView(service: service)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
