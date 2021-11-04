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
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var canvasView = PKCanvasView()
    @State private var deleteAlert = false
    @State private var saveAlert = false
    @State private var titleText = ""
    
    var drawingEntity: DrawingEntity?
    
    init(drawingEntity: DrawingEntity?) {
        self.drawingEntity = drawingEntity
        if let drawingEntity = drawingEntity,
           let data = drawingEntity.drawing {
            do {
                let drawing = try PKDrawing(data: data)
                canvasView.drawing = drawing
            } catch {
                print(error)
            }
        }
    }
    var body: some View {
        CanvasView(canvasView: $canvasView)
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
        if let drawingEntity = drawingEntity {
            drawingEntity.drawing = self.canvasView.drawing.dataRepresentation()
            drawingEntity.image = self.canvasView.drawing.image(from: self.canvasView.drawing.bounds, scale: 1)
        } else {
            DrawingEntity.insert(in: managedObjectContext, name: self.titleText, drawing: self.canvasView.drawing)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView(drawingEntity: nil)
    }
}
