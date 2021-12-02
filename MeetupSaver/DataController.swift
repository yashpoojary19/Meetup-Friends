//
//  DataController.swift
//  MeetupSaver
//
//  Created by Yash Poojary on 30/11/21.
//

import CoreData
import Foundation


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Meetup")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
