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
            List(placeholder, id: \.self) { drawing in
                Text(drawing)
            }
            .navigationTitle("Drawings")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                NavigationLink(destination: {DrawingView()}, label: {
                    Image(systemName: "plus")
                    
                })
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct DrawingListView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingListView()
    }
}
