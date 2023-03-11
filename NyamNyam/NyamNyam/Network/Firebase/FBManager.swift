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
    
    var dataDescription: String = ""
    
    func getMealJson() {
        let db = FirebaseFirestore.Firestore.firestore()
        let docRef = db.collection("CAU_Haksik").document("CAU_Cafeteria_Menu")
        
        docRef.getDocument(source: .cache) { (document, error) in
            if let document = document {
                guard let dataDescription = document.data() else { return }
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: dataDescription, options: .sortedKeys)
                    guard let decoded = String(data: jsonData, encoding: .utf8) else { return }
                    JsonManager.shared.saveJson(decoded)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                return
            }
        }
    }
    
}
