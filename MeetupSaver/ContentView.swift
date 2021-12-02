//
//  ContentView.swift
//  MeetupSaver
//
//  Created by Yash Poojary on 30/11/21.
//
import MapKit
import SwiftUI

struct ContentView: View {
    
    @FetchRequest(sortDescriptors: []) var friends: FetchedResults<Friend>
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var showNamePicker = false
    @State private var name = ""
    let locationFetcher = LocationFetcher()
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(friends) { friend in
                        NavigationLink(destination: DetailView(friend: friend)) {
                            HStack {
                                getPhotoFromUUID(uuid: friend.wrappedphotoID)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                
                                Text(friend.wrappedName)
                                    .font(.headline)
                            }
                        }
                        
                    }
                    .onDelete(perform: delete)
                }
            
            }
            .navigationTitle("Image Saver")
            .sheet(isPresented: $showImagePicker, onDismiss: showNamePickerAction) {
                ImagePicker(image: $selectedImage)
            }
            .sheet(isPresented: $showNamePicker, onDismiss: saveData) {
                AddUserName(name: $name)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showImagePicker = true
                    }) {
                        HStack {
                            Text("Add User")
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
    
    func showNamePickerAction() {
        showNamePicker = true
        locationFetcher.start()
    }
    
    func getPhotoFromUUID(uuid: UUID) -> Image {
        let uuidString = uuid.uuidString
        
        guard let data = try? Data(contentsOf: getDocumentsDirectory().appendingPathComponent(uuidString)) else {
            return Image(systemName: "fill")
        }
        
        guard let uiImage = UIImage(data: data) else{
            return Image(systemName: "fill")
        }
        
        return Image(uiImage: uiImage)
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    func saveData() {
        let newFriend = Friend(context: moc)
        
        let uuid = UUID()
        
        
        var latitude = 0.00
        var longitude = 0.00


        
        if let location = locationFetcher.lastKnownLocation {
            latitude = location.latitude as Double
            longitude = location.longitude as Double
            print("Your location is \(location)")
                } else {
                print("Your location is unkown")
          
        }
        
        
        
        newFriend.name = name
        newFriend.details = ""
        newFriend.photoID = uuid
        
        newFriend.latitude = latitude
        newFriend.longitude = longitude
    
        do {
            if let jpegData = selectedImage!.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: getDocumentsDirectory().appendingPathComponent(uuid.uuidString), options: [.atomicWrite, .completeFileProtection])
            }
            
            try moc.save()

        } catch {
            print(error.localizedDescription)
        }
        
       
        
    }
    
    func delete(at offsets: IndexSet) {
        for offset in offsets {
            let friend = friends[offset]
            moc.delete(friend)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
