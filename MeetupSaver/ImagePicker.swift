//
//  ImagePicker.swift
//  MeetupSaver
//
//  Created by Yash Poojary on 30/11/21.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage]  as? UIImage {
                parent.image = image
                parent.presentationMode.wrappedValue.dismiss()
            }
            
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
