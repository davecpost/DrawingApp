//
//  DrawingView.swift
//  DrawingApp
//
//  Created by David Post on 2021-10-22.
//

import Foundation
import SwiftUI
import PencilKit
import CoreData

struct DrawingView: View {
    @Environment(\.undoManager) private var undoManager
    @State private var canvasView = PKCanvasView()
    @State private var drawing: Drawing? = nil
    @State private var deleteAlert = false
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        CanvasView(canvasView: $canvasView, onSaved: saveDrawing)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "arrow.left.circle")
                            Text("Go Back")
                        }
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.deleteAlert = true
                    }, label: {
                        Image(systemName: "trash")
                    })
                        .alert(isPresented: $deleteAlert) {
                            Alert(title: Text("Are you sure you want to delete?"),
                                  message: nil,
                                  primaryButton: .destructive(Text("Delete")) {
                                deleteDrawing()
                            }
                                  , secondaryButton: .cancel())
                        }
                    Button(action: {
                        undoManager?.undo()
                    }, label: {
                        Image(systemName: "arrow.uturn.backward.circle")
                    })
                    Button(action: {
                        undoManager?.redo()
                    }, label: {
                        Image(systemName: "arrow.uturn.forward.circle")
                    })
                }
            }.navigationBarBackButtonHidden(true)
    }
    private func deleteDrawing() {
        canvasView.drawing = PKDrawing()
    }
    private func saveDrawing() {
        let image = canvasView.drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
        let drawing = Drawing(title: "Best Drawing", drawing: canvasView.drawing, image: image)
        DrawingEntity.insert(in: managedObjectContext, drawing: drawing)
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView()
    }
}
