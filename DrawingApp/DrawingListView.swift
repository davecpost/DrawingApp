//
//  DrawingListView.swift
//  DrawingApp
//
//  Created by David Post on 2021-10-22.
//

import SwiftUI

struct DrawingListView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \DrawingEntity.date, ascending: true)])
    private var drawingEntities: FetchedResults<DrawingEntity>
    var body: some View {
        NavigationView {
            List(drawingEntities, id: \.self) { drawing in
                HStack {
                    Text(drawing.name ?? "")
                    Text(drawing.dateString() ?? "")
                }
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
