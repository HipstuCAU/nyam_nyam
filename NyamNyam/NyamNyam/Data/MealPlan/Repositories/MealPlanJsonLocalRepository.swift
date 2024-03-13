//
//  MealPlanLocalRepository.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/09.
//

import Foundation
import RxSwift
import Firebase

protocol MealPlanJsonLocalRepository {
    func fetchMealPlanJsonString() -> Single<String>
    func createMealPlanJsonFileWith(jsonString: String) throws
}

final class MealPlanJsonLocalRepositoryImpl: MealPlanJsonLocalRepository {
    private let localFileName: String
    
    init(localFileName: String) {
        self.localFileName = localFileName
    }
    
    func fetchMealPlanJsonString() -> Single<String> {
        return Single<String>.create { [weak self] single in
            
            guard let self
            else {
                single(.failure(FileError.unknownError))
                return Disposables.create()
            }
            
            guard let filename = self.getDocumentsDirectory()?
                .appendingPathComponent(
                    localFileName + ".json"
                )
            else {
                single(.failure(FileError.fileNotFound(localFileName + ".json")))
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
    
    func createMealPlanJsonFileWith(jsonString: String) throws {
        
        guard let filename = getDocumentsDirectory()?
            .appendingPathComponent(
                localFileName + ".json"
            )
        else {
            throw FileError.fileNotFound(localFileName + ".json")
        }
        
        try jsonString.write(
            to: filename,
            atomically: true,
            encoding: String.Encoding.utf8
        )
        
        UserDefaults().lastUpdate = Date().toStringWithTime()
    }
}

extension MealPlanJsonLocalRepositoryImpl {
    private func getDocumentsDirectory() -> URL? {
        let paths = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )
        return paths.first
    }
}
