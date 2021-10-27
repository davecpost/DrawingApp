//
//  DrawingEntityExtension.swift
//  DrawingApp
//
//  Created by David Post on 2021-10-27.
//

import Foundation
import CoreData

extension DrawingEntity {
    static func insert(in context: NSManagedObjectContext, drawing: Drawing) {
        let record = DrawingEntity(context: context)
        record.name = drawing.title
        record.id = drawing.id
        record.date = Date()
        record.drawing = drawing.drawing.dataRepresentation()
        record.image = drawing.image
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
