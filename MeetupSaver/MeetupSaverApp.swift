//
//  MeetupSaverApp.swift
//  MeetupSaver
//
//  Created by Yash Poojary on 30/11/21.
//

import SwiftUI

@main
struct MeetupSaverApp: App {
    
    @StateObject private var dataController = DataController()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
