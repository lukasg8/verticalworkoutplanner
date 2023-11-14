//
//  ContentView.swift
//  PJFClone
//
//  Created by Lukas on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var manager:WorkoutsManager
    @State var workouts:[Workout] = []
    
    init(manager: WorkoutsManager) {
        self.manager = manager
    }
    
    var body: some View {
        VStack {
            Text("Workouts!")
                .bold()
            ForEach(workouts, id:\.title) { workout in
                Text(workout.title)
                HStack {
                    ForEach(workout.categories, id:\.self) { category in
                        Text(category)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            Task {
                do {
                    workouts = try await manager.initializeWorkouts()
                } catch {
                    print("Error initializing workouts.")
                }
            }
        }
    }
}

#Preview {
    ContentView(manager: WorkoutsManager())
}
