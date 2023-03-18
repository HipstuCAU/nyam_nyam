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
    
    func getMealJson(completion: @escaping () -> Void ) {
        let db = FirebaseFirestore.Firestore.firestore()
        let docRef = db.collection("CAU_Haksik").document("CAU_Cafeteria_Menu")
        docRef.getDocument() { (document, error) in
            if let document = document, document.exists {
                guard let dataDescription = document.data() else { return }
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: dataDescription, options: .sortedKeys)
                    guard let strData = String(data: jsonData, encoding: .utf8) else { return }
                    if strData != JsonManager.shared.jsonToString() {
                        JsonManager.shared.saveJson(strData)
                        completion()
                    } else { completion() }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                return
            }
        }
    }
}
