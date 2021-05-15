//
//  ImagePickerView.swift
//  FruitMart
//
//  Created by lee on 2021/05/15.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var pickedImage: Image

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        imagePickerController.allowsEditing = true
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { /* no-op */ }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    final class Coordinator: NSObject {
        
        let parent: ImagePickerView
        
        init(_ view: ImagePickerView) {
            self.parent = view
        }
    }
}


extension ImagePickerView.Coordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let originalImage = info[.originalImage] as! UIImage
        let edittedImage = info[.editedImage] as? UIImage

        parent.pickedImage = Image(uiImage: edittedImage ?? originalImage)
        picker.dismiss(animated: true)
    }
}
