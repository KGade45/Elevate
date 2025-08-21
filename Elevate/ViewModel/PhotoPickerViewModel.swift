//
//  PhotoPickerViewModel.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 21/08/25.
//

import SwiftUI
import PhotosUI

final class PhotoPickerViewModel: ObservableObject {
    @Published private(set) var selectedImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            loadImage(from: imageSelection)
        }
    }
    
    private func loadImage(from selection: PhotosPickerItem?) {
        guard let selection = selection else {
            return
        }

        Task {
            if let data = try? await selection.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                selectedImage = image
                return
            }
        }
        
    }
}
