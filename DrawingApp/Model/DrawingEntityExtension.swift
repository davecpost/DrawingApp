//
//  DrawingEntityExtension.swift
//  DrawingApp
//
//  Created by David Post on 2021-10-27.
//

import Foundation
import CoreData
import PencilKit

extension DrawingEntity {
    static func insert(in context: NSManagedObjectContext, name: String, drawing: PKDrawing) {
        let record = DrawingEntity(context: context)
        record.name = name
        record.id = UUID()
        record.date = Date()
        record.drawing = drawing.dataRepresentation()
        record.image = drawing.image(from: drawing.bounds, scale: 1)
    }
    
    static func preview(in context: NSManagedObjectContext) -> DrawingEntity {
        let record = DrawingEntity(context: context)
        record.drawing = PKDrawing().dataRepresentation()
        record.image = UIImage(named: "previewPNG")
        record.date = Date()
        record.id = UUID()
        record.name = "preview"
        return record
    }
    
    func dateString() -> String? {
        guard let date = self.date else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter.string(from: date)
    }
}
