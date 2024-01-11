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
    func fetchMealPlanJsonString(fileName: String) -> Single<String>
    func createMealPlanJsonFileWith(jsonString: String, fileName name: String) throws
}

final class MealPlanJsonLocalRepositoryImpl: MealPlanJsonLocalRepository {
    func fetchMealPlanJsonString(fileName: String) -> Single<String> {
        return Single<String>.create { single in
            
            guard let filename = self.getDocumentsDirectory()?
                .appendingPathComponent(
                    fileName + ".json"
                )
            else {
                single(.failure(FileError.fileNotFound))
                return Disposables.create()
            }
            
            do {
                let jsonString = try String(
                    contentsOf: filename,
                    encoding: String.Encoding.utf8
                )
                
                single(.success(jsonString))
                
            } catch {
                single(.failure(FileError.parsingError(error)))
            }
            
            return Disposables.create()
        }
    }
    
    func createMealPlanJsonFileWith(
        jsonString: String,
        fileName name: String
    ) throws {
        
        guard let filename = getDocumentsDirectory()?
            .appendingPathComponent(
                name + ".json"
            )
        else {
            throw FileError.fileNotFound
        }
        
        try jsonString.write(
            to: filename,
            atomically: true,
            encoding: String.Encoding.utf8
        )
    }
}

extension MealPlanJsonLocalRepositoryImpl {
    private func getDocumentsDirectory() -> URL? {
        guard let paths = FileManager.default.urls(
            for: FileManager.SearchPathDirectory.applicationSupportDirectory,
            in: FileManager.SearchPathDomainMask.userDomainMask
        ).first
        else { return nil }
        
        return paths
    }
}
