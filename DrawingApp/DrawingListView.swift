//
//  DrawingListView.swift
//  DrawingApp
//
//  Created by David Post on 2021-10-22.
//

import SwiftUI

struct DrawingListView: View {
    private var placeholder = ["Hello", "World"]
    var body: some View {
        NavigationView {
            VStack {
            List(placeholder, id: \.self) { drawing in
                Text(drawing)
            }
            NavigationLink(destination: {DrawingView()}, label: {
                Image(systemName: "plus").font(.largeTitle)
                
            })
            }
                .navigationTitle("Drawings")
        }
    }
}

struct DrawingListView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingListView()
    }
}
