//
//  FBManger.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/27.
//

import Foundation
import Firebase

protocol MealPlanRepository {
    func getMealJson(completion: @escaping () -> Void )
}

final class MealPlanRepositoryImpl {
    static let shared = MealPlanRepositoryImpl()
    
    private init() { }
    
    func getMealJson(completion: @escaping () -> Void) {
        let collection = "CAU_Haksik"
        let document = "CAU_Cafeteria_Menu"
        let db = FirebaseFirestore.Firestore.firestore()
        let docRef = db.collection(collection).document(document)
        
        docRef.getDocument() { (document, error) in
            guard let document = document,
                  document.exists,
                  let dataDescription = document.data()
            else { return }
            
            do {
                let jsonData = try JSONSerialization.data(
                    withJSONObject: dataDescription,
                    options: .sortedKeys
                )
                
                guard let strData = String(
                    data: jsonData,
                    encoding: .utf8
                )
                else { return }
                
                if strData != JsonManager.shared.jsonToString() {
                    JsonManager.shared.saveJson(strData)
                    completion()
                } else {
                    completion()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
