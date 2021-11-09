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
                    Button("Save") {
                        if drawingEntity != nil {
                            saveDrawing()
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            saveAlert = true
                        }
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
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
            .popover(isPresented: $saveAlert) {
                
                Form {
                    Text("Save Drawing").font(.title)
                    TextField("Title", text: $titleText)
                    Button("Save") {
                        saveDrawing()
                        saveAlert = false
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(titleText.isEmpty)
                    
                    Button("Cancel") {
                        saveAlert = false
                    }
                    Button("Discard") {
                        saveAlert = false
                        canvasView.drawing = PKDrawing()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.red)
                }.padding()
            }
    }
    private func saveDrawing() {
        if let drawingEntity = drawingEntity {
            drawingEntity.drawing = self.canvasView.drawing.dataRepresentation()
            drawingEntity.image = self.canvasView.drawing.image(from: self.canvasView.drawing.bounds, scale: 1)
        } else {
            DrawingEntity.insert(in: managedObjectContext, name: self.titleText, drawing: self.canvasView.drawing)
        }
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView(drawingEntity: nil)
    }
}
