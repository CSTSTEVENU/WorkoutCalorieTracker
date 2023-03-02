//
//  AddFoodView.swift
//  WorkoutCalorieTracker
//
//  Created by Steven uhm on 2022-12-07.
//

import SwiftUI

struct AddFoodView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    // variables
    @State private var name = ""
    @State private var foodNotes = ""
    @State private var calories: Double = 0
    @State private var protein: Double = 0
    @State private var carbohydrates: Double = 0
    @State private var fats: Double = 0
    
    var body: some View {
        
        // Form for properties
        Form {
            Section {
                TextField("Food name", text: $name)
                
                TextField("Notes? Recipes?", text: $foodNotes)
                
                VStack {
                    
                    Spacer()
                    
                    Text("Protein: \(Int(protein))G")
                    Slider(value: $protein, in: 0...1000,step: 1)
                    
                    Text("Carbohydrates: \(Int(carbohydrates))G")
                    Slider(value: $carbohydrates, in: 0...1000, step: 1)
                    
                    Text("Fats: \(Int(fats))G")
                    Slider(value: $fats, in: 0...1000, step: 1)
                    
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 1)
                }
                .padding()
                
                // Submit button to update propties for item
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().addFood(name: name, foodNotes: foodNotes, protein: protein, carbohydrates: carbohydrates, fats: fats, calories: calories, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
    
    struct AddFoodView_Previews: PreviewProvider {
        static var previews: some View {
            AddFoodView()
        }
    }
}
