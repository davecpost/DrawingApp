//
//  CanvasView.swift
//  DrawingApp
//
//  Created by David Post on 2021-10-22.
//

import Foundation

import SwiftUI
import PencilKit

struct CanvasView {
    @Binding var canvasView: PKCanvasView
    @State var toolPicker = PKToolPicker()
}

extension CanvasView: UIViewRepresentable {
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.tool = PKInkingTool(.pen, color: .gray, width: 10)
        canvasView.drawingPolicy = .anyInput
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
        return canvasView
    }
}
