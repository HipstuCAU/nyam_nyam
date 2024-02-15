//
//  FirebaseDataError.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/09.
//

import Foundation

enum FirebaseDataError: Error {
    case firestoreError(Error)
    
    case parsingError(Error)
    
    case noData
    
    case invalidData
    
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case let .firestoreError(error):
            return "Firestore error: \(error.localizedDescription)"
        case .parsingError(let error):
            return "Parsing error: \(error.localizedDescription)"
        case .noData:
            return "No data available"
        case .invalidData:
            return "Invalid data format"
        case .unknownError:
            return "An unknown error occurred"
        }
    }
}
