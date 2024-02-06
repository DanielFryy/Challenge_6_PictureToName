//
//  ContentView.swift
//  Challenge_6_PictureToName
//
//  Created by Daniel Freire on 2/5/24.
//

import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingNameSheet = false
    @State private var name = ""
    @State private var photos = [PictureName]()
    @State private var photo: Data?
    
    var body: some View {
        NavigationStack {
            VStack {
                if photos.count != 0 {
                    List(photos.sorted()) { photo in
                        if let inputImage = UIImage(data: photo.photo) {
                            HStack {
                                Text(photo.name)
                                Spacer()
                                Image(uiImage: inputImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 80)
                                    .scaledToFit()
                            }
                        } else {
                            Text("Unavailable")
                        }
                    }
                } else {
                    ContentUnavailableView("No Photos", systemImage: "photo", description: Text("There's no photos yet"))
                }
            }
            .navigationTitle("Picture to name")
            .toolbar {
                PhotosPicker(selection: $selectedItem) {
                    Text("New")
                }
                .onChange(of: selectedItem, loadImage)
            }
            .sheet(isPresented: $showingNameSheet, onDismiss: {
                if name == "" {
                    selectedItem = nil
                    photo = nil
                    return
                }
                guard let photo = photo else { return }
                let newPicture = PictureName(name: name, photo: photo)
                photos.append(newPicture)
                name = ""
                selectedItem = nil
            }) {
                AddNameView(name: $name)
            }
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            photo = imageData
            showingNameSheet = true
        }
    }
}

#Preview {
    ContentView()
}
