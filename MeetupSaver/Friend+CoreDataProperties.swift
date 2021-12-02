//
//  Friend+CoreDataProperties.swift
//  MeetupSaver
//
//  Created by Yash Poojary on 30/11/21.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var name: String?
    @NSManaged public var details: String?
    @NSManaged public var photoID: UUID?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    
    public var wrappedName: String {
        name ?? "Na"
    }
    
    public var wrappedDetails: String {
        details ?? "Na"
    }
    
    public var wrappedphotoID: UUID {
        photoID ?? UUID()
    }

}

extension Friend : Identifiable {

}
