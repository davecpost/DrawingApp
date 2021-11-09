//
//  UIImageValueTransformer.swift
//  DrawingApp
//
//  Created by David Post on 2021-11-09.
//

import Foundation
import UIKit

@objc(UIImageValueTransformer)
final class UIImageValueTransformer: NSSecureUnarchiveFromDataTransformer {

    /// The name of the transformer. This is the name used to register the transformer using `ValueTransformer.setValueTrandformer(_"forName:)`.
    static let name = NSValueTransformerName(rawValue: String(describing: UIImageValueTransformer.self))

    // 2. Make sure `UIColor` is in the allowed class list.
    override static var allowedTopLevelClasses: [AnyClass] {
        return [UIImage.self]
    }

    /// Registers the transformer.
    public static func register() {
        let transformer = UIImageValueTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
