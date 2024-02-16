//
//  MockMealPlanJsonRemoteRepository.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/11.
//

import Foundation
import RxSwift

final class MockMealPlanJsonRemoteRepositoryImpl: MealPlanJsonRemoteRepository {
    func fetchMealPlanJsonString(
        collection: String,
        document: String
    ) -> Single<String> {
        
        return Single<String>.create { single in
            guard let path = Bundle.main.path(
                forResource: "MealPlanMockData",
                ofType: "json"
            ) else {
                single(.failure(FileError.fileNotFound("Bundle")))
                return Disposables.create()
            }
            
            do {
                let data = try Data(
                    contentsOf: URL(fileURLWithPath: path),
                    options: .mappedIfSafe
                )
                if let jsonString = String(
                    data: data,
                    encoding: .utf8
                ) {
                    single(.success(jsonString))
                } else {
                    single(.failure(FileError.noData))
                }
            } catch {
                single(.failure(FileError.invalidData))
            }
            
            return Disposables.create()
        }
    }
}

