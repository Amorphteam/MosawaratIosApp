//
//  HajariAlmustafaProjectApp.swift
//  HajariAlmustafaProject
//
//  Created by Samano on 4/12/22.
//

import SwiftUI
import Firebase


@main
struct HajariAlmustafaProjectApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
