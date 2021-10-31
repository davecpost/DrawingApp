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
    var drawing: Drawing? = nil
    
    @Environment(\.undoManager) private var undoManager
    @State private var canvasView = PKCanvasView()
    @State private var deleteAlert = false
    @State private var saveAlert = false
    @State private var titleText = ""
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        CanvasView(canvasView: $canvasView, drawing: drawing)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        if !canvasView.drawing.bounds.isEmpty {
                            saveAlert = true
                        } else {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        HStack {
                            Image(systemName: "arrow.left.circle")
                            Text("Save")
                        }
                    }
                    .popover(isPresented: $saveAlert) {
                        
                        Form {
                            Text("Save Drawing").font(.title)
                            TextField("Title", text: $titleText)
                            Button("Save") {
                                if !titleText.isEmpty {
                                    saveDrawing()
                                    saveAlert = false
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }
                            
                            Button("Cancel") {
                                saveAlert = false
                            }
                            .foregroundColor(.red)
                        }.padding()
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
                                self.presentationMode.wrappedValue.dismiss()
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
    private func saveDrawing() {
        let image = canvasView.drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
        let drawing = Drawing(title: titleText, drawing: canvasView.drawing, image: image)
        DrawingEntity.insert(in: managedObjectContext, drawing: drawing)
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView()
    }
}
