//
//  DrawingListView.swift
//  DrawingApp
//
//  Created by David Post on 2021-10-22.
//

import SwiftUI

struct DrawingListView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \DrawingEntity.date, ascending: false)])
    private var drawingEntities: FetchedResults<DrawingEntity>
    var body: some View {
        NavigationView {
            List(drawingEntities, id: \.self) { drawing in
                NavigationLink(destination: DrawingDetailView(drawingEntity: drawing)){
                    VStack {
                        Image(uiImage: (drawing.image as? UIImage ?? UIImage(systemName: "x.square")!))
                            .resizable()
                            .scaledToFit()
                        Text(drawing.name ?? "")
                        Text(drawing.dateString() ?? "")
                    }
                }
            }
            .navigationTitle("Drawings")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: {DrawingView(drawingEntity: nil)}, label: {
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
        DrawingListView().environment(\.managedObjectContext, CoreDataStack.preview.managedObjectContext)
    }
}
