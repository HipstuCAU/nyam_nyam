//
//  MealPlanLocalRepository.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/09.
//

import Foundation
import RxSwift
import Firebase

protocol MealPlanJsonLocalRepository {
    func fetchMealPlanJsonString() -> Single<String>
    func createMealPlanJsonFileWith(jsonString: String)
}

final class MealPlanJsonLocalRepositoryImpl: MealPlanJsonLocalRepository {
    
    func fetchMealPlanJsonString() -> Single<String> {
        return Single<String>.create { single in
            guard let path = Bundle.main.path(
                forResource: "CAUMeals",
                ofType: "json"
            ) else {
                single(.failure(FileError.fileNotFound))
                return Disposables.create()
            }
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                guard let jsonString = String(data: data, encoding: .utf8)
                else {
                    single(.failure(FileError.fileNotFound))
                    return Disposables.create()
                }
                
                // MARK: Success
                single(.success(jsonString))
                
            } catch {
                single(.failure(FileError.parsingError(error)))
            }
            
            return Disposables.create()
        }
    }
    
    func createMealPlanJsonFileWith(jsonString: String) {
        
    }
}
