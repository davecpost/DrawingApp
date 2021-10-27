//
//  Drawing.swift
//  DrawingApp
//
//  Created by David Post on 2021-10-22.
//

import Foundation
import PencilKit

struct Drawing: Identifiable {
    let id = UUID()
    let title: String
    let drawing: PKDrawing
    let image: UIImage
}
