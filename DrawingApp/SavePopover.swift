//
//  SavePopover.swift
//  DrawingApp
//
//  Created by David Post on 2021-10-27.
//

import SwiftUI

struct SavePopover: View {
    @State private var titleText = ""
    var body: some View {
        VStack {
            Text("Save Drawing").font(.title)
            TextField("Title", text: $titleText)
            Button("Save") {
                
            }
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Button("Cancel") {
                
            }
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundColor(.red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }.padding()
    }
}

struct SavePopover_Previews: PreviewProvider {
    static var previews: some View {
        SavePopover()
    }
}
