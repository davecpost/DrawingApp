//
//  DrawingDetailView.swift
//  DrawingApp
//
//  Created by David Post on 2021-10-29.
//

import SwiftUI

struct DrawingDetailView: View {
    var drawingEntity: DrawingEntity
    var body: some View {
        VStack() {
            Image(uiImage: ((drawingEntity.image as? UIImage) ?? UIImage(systemName: "x.square"))!)
                .resizable()
                .scaledToFit()
            Text(drawingEntity.dateString() ?? "")
            HStack {
                Button("Edit") {
                    
                }
                Spacer()
                Button("Delete") {
                    
                }
                .foregroundColor(.red)
            }
            .padding()
            Spacer()
        }
        .navigationTitle(Text(drawingEntity.name ?? ""))
    }
}

struct DrawingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let context = CoreDataStack.preview.managedObjectContext
        DrawingDetailView(drawingEntity: DrawingEntity.preview(in: context))
            .environment(\.managedObjectContext, context)
    }
}
