//
//  DrawingView.swift
//  DrawingApp
//
//  Created by David Post on 2021-10-22.
//

import Foundation
import SwiftUI
import PencilKit

struct DrawingView: View {
    @Environment(\.undoManager) private var undoManager
    @State private var canvasView = PKCanvasView()
    @State private var drawing: Drawing? = nil
    @State private var deleteAlert = false
    
    
    var body: some View {
        NavigationView {
            CanvasView(canvasView: $canvasView, onSaved: saveDrawing)
                .toolbar {
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
                }
        }
    }
    private func deleteDrawing() {
        canvasView.drawing = PKDrawing()
    }
    private func saveDrawing() {
        let image = canvasView.drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
        let drawing = Drawing(title: "Best Drawing", drawing: canvasView.drawing, image: image)
        self.drawing = drawing
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView()
    }
}
