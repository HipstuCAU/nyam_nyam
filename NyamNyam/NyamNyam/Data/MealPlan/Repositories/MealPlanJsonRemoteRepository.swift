//
//  MealPlanRemoteRepository.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/27.
//

import Foundation
import RxSwift
import Firebase

protocol MealPlanJsonRemoteRepository {
    func fetchMealPlanJsonString(collection: String, document: String) -> Single<String>
}

final class MealPlanJsonRemoteRepositoryImpl: MealPlanJsonRemoteRepository {
    
    func fetchMealPlanJsonString(
        collection: String,
        document: String
    ) -> Single<String> {
        
        return Single<String>.create { single in
            let db = Firestore.firestore()
            let docRef = db.collection(collection).document(document)

            docRef.getDocument { (document, error) in
                if let error = error {
                    single(.failure(NetworkError.firestoreError(error)))
                    return
                }

                guard let dataDescription = document?.data(),
                      document?.exists == true
                else {
                    single(.failure(NetworkError.noData))
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
                        single(.failure(NetworkError.invalidData))
                    }
                } catch {
                    single(.failure(NetworkError.parsingError(error)))
                }
            }

            return Disposables.create()
        }
    }
}
