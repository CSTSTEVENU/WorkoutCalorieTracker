//
//  WorkoutCalorieTrackerApp.swift
//  WorkoutCalorieTracker
//
//  Created by Steven uhm on 2022-12-07.
//

import SwiftUI

@main
struct WorkoutCalorieTrackerApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
