//
//  WorkoutsManager.swift
//  PJFClone
//
//  Created by Lukas on 11/10/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Workout:Decodable {
    let title:String
    let day:Int
    let categories:[String]
}

class WorkoutsManager: ObservableObject {
    
    private func workoutsCollection() throws -> CollectionReference {
        Firestore.firestore().collection("workouts")
    }
    
    func initializeWorkouts() async throws -> [Workout] {
        let snapshot = try await workoutsCollection().document("phase2").collection("week1").getDocuments()
        let workouts = try snapshot.documents.map { document in
            try document.data(as: Workout.self)
        }
        return workouts
    }
    
}

