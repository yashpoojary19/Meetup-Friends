//
//  MKPointAnnotationCodable.swift
//  MeetupSaver
//
//  Created by Yash Poojary on 30/11/21.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            title ?? "Unkown title"
        }
        
        set {
            title = newValue
        }
    }
    
    public var wrappedSubTitle: String {
        get {
            subtitle ?? "Unkown title"
        }
        
        set {
            subtitle = newValue
        }
    }
}
