//
//  FileError.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/09.
//

import Foundation

enum FileError: Error {
    case fileNotFound
    
    case noData
    
    case invalidData
    
    case unknownError
    
    case parsingError(Error)
    
    case fileSaveError(Error)
    
    var localizedDescription: String {
        switch self {
        case .noData:
            return "No data available"
        case .invalidData:
            return "Invalid data format"
        case .unknownError:
            return "An unknown error occurred"
        case .fileNotFound:
            return "File not found"
        case let .parsingError(error):
            return "Parsing error: \(error.localizedDescription)"
        case let .fileSaveError(error):
            return "file save error: \(error.localizedDescription)"
        }
    }
}
