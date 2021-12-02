//
//  AddUserName.swift
//  MeetupSaver
//
//  Created by Yash Poojary on 30/11/21.
//

import SwiftUI

struct AddUserName: View {
    
//    var friend: Friend
    @Binding var name: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter your name", text: $name)
            }
            .navigationTitle("User Details")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        
    }
}

//struct AddUserName_Previews: PreviewProvider {
//    static var previews: some View {
//        AddUserName()
//    }
//}
