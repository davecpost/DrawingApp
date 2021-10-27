//
//  DrawingAppApp.swift
//  DrawingApp
//
//  Created by David Post on 2021-10-22.
//

import SwiftUI

@main
struct DrawingAppApp: App {
    private let coreDataStack = CoreDataStack()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    coreDataStack.save()
                }
                .environment(\.managedObjectContext, coreDataStack.managedObjectContext)
        }
    }
}
