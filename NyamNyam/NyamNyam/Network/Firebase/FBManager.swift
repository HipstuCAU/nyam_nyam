//
//  FBManger.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/27.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class FBManager {
    static let shared = FBManager()
    
    private init() { }
    
    func getMealJson() -> String {
        let db = FirebaseFirestore.Firestore.firestore()
        let docRef = db.collection("CAU_Haksik").document("CAU_Cafeteria_Menu")
        var dataDescription = ""
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                dataDescription = document.data().map(String.init(describing:)) ?? "nil"
            } else {
                fatalError()
            }
        }
        return dataDescription
    }
}
