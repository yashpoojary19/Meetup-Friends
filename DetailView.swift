import SwiftUI
import CoreData
import MapKit

struct DetailView: View {
    var friend: Friend
    
    var centerCoordinate: CLLocationCoordinate2D {
        let latitude = friend.latitude as CLLocationDegrees
        let longitude = friend.longitude as CLLocationDegrees
        
        let centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        return centerCoordinate
    }
    
    var annotation: MKAnnotation {
        let newLocation = MKPointAnnotationCodable()
        newLocation.coordinate = centerCoordinate
        newLocation.title = "Example location"
        
        return newLocation
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(friend.wrappedName)
                .font(.largeTitle)
                .padding()
            
            getPhotoFrom(uuid: friend.wrappedphotoID)
                .resizable()
                .scaledToFit()
                .padding()
            
            MapView(centerCoordinate: centerCoordinate, annotation: annotation)
            
            Spacer()
        }
    }
    
    func getPhotoFrom(uuid: UUID) -> Image {
        let uuidString = uuid.uuidString
        guard let data = try? Data(contentsOf: getDocumentsDirectory().appendingPathComponent(uuidString)) else { return Image(systemName: "person.crop.circle.badge.questionmark") }
        guard let uiImage = UIImage(data: data, scale: 1.0) else { return Image(systemName: "person.crop.circle.badge.questionmark") }
        return Image(uiImage: uiImage)
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}
