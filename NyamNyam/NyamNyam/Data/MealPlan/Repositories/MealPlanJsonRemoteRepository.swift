//
//  MealPlanRemoteRepository.swift
//  NyamNyam
//
//  Created by 박준홍 on 2023/02/27.
//

import Foundation
import RxSwift
import Firebase

protocol MealPlanJsonRemoteRepository {
    func fetchMealPlanJsonString() -> Single<String>
}

final class MealPlanJsonRemoteRepositoryImpl: MealPlanJsonRemoteRepository {
    
    private let collection: String
    
    private let document: String
    
    init(
        collection: String,
        document: String
    ) {
        self.collection = collection
        self.document = document
    }
    
    
    func fetchMealPlanJsonString() -> Single<String> {
        
        return Single<String>.create { [weak self] single in
            
            guard let self 
            else {
                single(.failure(FirebaseDataError.unknownError))
                return Disposables.create()
            }
            
            let db = Firestore.firestore()
            let docRef = db.collection(collection).document(document)

            docRef.getDocument { (document, error) in
                if let error = error {
                    single(.failure(FirebaseDataError.firestoreError(error)))
                    return
                }

                guard let dataDescription = document?.data(),
                      document?.exists == true
                else {
                    single(.failure(FirebaseDataError.noData))
                    return
                }

                do {
                    let jsonData = try JSONSerialization.data(
                        withJSONObject: dataDescription,
                        options: .sortedKeys
                    )
                    
                    if let jsonString = String(
                        data: jsonData,
                        encoding: .utf8
                    ) {
                        single(.success(jsonString))
                    } else {
                        single(.failure(FirebaseDataError.invalidData))
                    }
                } catch {
                    single(.failure(FirebaseDataError.parsingError(error)))
                }
            }

            return Disposables.create()
        }
    }
}
