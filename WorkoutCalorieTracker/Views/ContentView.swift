//
//  ContentView.swift
//  WorkoutCalorieTracker
//
//  Created by Steven uhm on 2022-12-07.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // Takes coredata model and fetches results
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            // Navigation view in VStack to show total calories added together
            VStack(alignment: .leading) {
                Text("\(Int(totalCaloriesToday())) Kcal (Today)")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                // List for each caloric tracking item
                List {
                    ForEach(food) { food in
                        NavigationLink(destination: EditFoodView(food: food)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(food.name!)
                                        .bold()
                                    
                                    Text(food.foodNotes!)
                                        .bold()
                                    
                                    Text("Protein: \(Int(food.protein)) G")
                                        
                                    Text("Carbohydrates: \(Int(food.carbohydrates)) G")
                                        
                                    Text("Fats: \(Int(food.fats)) G")
                                    
                                    Text("Calories: \(Int(food.calories)) ") + Text("calories").foregroundColor(.red)
                                }
                                Spacer()
                                Text(calcTimeSince(date:food.date!))
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }
                    }
                    // deletes entries of calorie items
                    .onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
                
            }
            .navigationTitle("CalTake")
            .toolbar {
                // Add button for new entries
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Food", systemImage: "plus.circle")
                    }
                }
                // Edit button for editing entries
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddFoodView()
            }
        }
        .navigationViewStyle(.stack)
    }
    // function for deleting and resetting food calorie entries in array
    private func deleteFood(offsets: IndexSet) {
        withAnimation {
            offsets.map { food[$0] }.forEach(managedObjContext.delete)
            
            // saving updated entry in CoreData
            DataController().save(context: managedObjContext)
        }
    }
    // function to update data entry time for calories
    private func totalCaloriesToday() -> Double {
        var caloriesToday: Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!) {
                caloriesToday += item.calories
            }
         }
            return caloriesToday
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
