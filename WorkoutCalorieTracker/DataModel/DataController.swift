//
//  DataController.swift
//  WorkoutCalorieTracker
//
//  Created by Steven uhm on 2022-12-07.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "FoodModel")
    // intializing coredata properties and validating
    init() {
        container.loadPersistentStores{ desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    // function to save with validation
    func save(context:NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved!")
        } catch {
            print("Data not saved!")
        }
    }
    // function to add
    func addFood(name: String,foodNotes: String,protein: Double, carbohydrates: Double, fats: Double,  calories: Double, context: NSManagedObjectContext) {
        let food = Food(context: context)
        food.id = UUID()
        food.date = Date()
        food.name = name
        food.foodNotes = foodNotes
        food.protein = protein
        food.carbohydrates = carbohydrates
        food.fats = fats
        food.calories = calories
        
        save(context: context)
        
    }
    // function to edit
    func editFood(food: Food, name: String,foodNotes: String,protein: Double, carbohydrates: Double, fats: Double, calories: Double, context: NSManagedObjectContext) {
        food.date = Date()
        food.name = name
        food.foodNotes = foodNotes
        food.protein = protein
        food.carbohydrates = carbohydrates
        food.fats = fats
        food.calories = calories
        
        save(context: context)
    }
}
    
    
