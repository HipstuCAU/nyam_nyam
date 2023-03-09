//
//  DataManager.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/09.
//

import Foundation

final class DataManager {
    func stringToDict(_ strData: String) -> [String: Any]? {
        if let strData = strData.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: strData, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

private extension DataManager {
    
}
