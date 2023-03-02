//
//  EditViewView.swift
//  WorkoutCalorieTracker
//
//  Created by Steven uhm on 2022-12-07.
//

import SwiftUI

struct EditFoodView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var food: FetchedResults<Food>.Element
    
    
    // variables
    @State private var name = ""
    @State private var foodNotes = ""
    @State private var calories: Double = 0
    @State private var protein: Double = 0
    @State private var carbohydrates: Double = 0
    @State private var fats: Double = 0
    
    var body: some View {
        // Form for edited food calorie items
        Form {
            Section {
                TextField("\(food.name!)", text: $name)
                TextField("\(food.foodNotes!)", text: $foodNotes)
                    .onAppear {
                        name = food.name!
                        foodNotes = food.foodNotes!
                        protein = food.protein
                        carbohydrates = food.carbohydrates
                        fats = food.fats
                    }
                VStack {
                    Text("Protein: \(Int(protein))G")
                    Slider(value: $protein, in: 0...1000,step: 10)
                    
                    Text("Carbohydrates: \(Int(carbohydrates))G")
                    Slider(value: $carbohydrates, in: 0...1000, step: 10)
                    
                    Text("Fats: \(Int(fats))G")
                    Slider(value: $fats, in: 0...1000, step: 10)
                    
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 10)
                }
                .padding()
                
                // Submit button to update editted items in CoreData
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().editFood(food: food, name: name, foodNotes: foodNotes, protein: protein, carbohydrates: carbohydrates, fats: fats, calories: calories, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
                
            }
        }
    }
}
