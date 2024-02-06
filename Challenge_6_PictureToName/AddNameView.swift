//
//  AddNameView.swift
//  Challenge_6_PictureToName
//
//  Created by Daniel Freire on 2/6/24.
//

import SwiftUI

struct AddNameView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var name: String
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
            }
            .navigationTitle("Add name")
            .navigationBarBackButtonHidden()
            .toolbar {
                Button("Save") {
                    dismiss()
                }
            }
        }
    }
}

//#Preview {
//    
//    AddNameView(name: "")
//}
