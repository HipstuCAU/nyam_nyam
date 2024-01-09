//
//  JsonManager.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/09.
//

import Foundation

final class JsonManager {
    static let shared = JsonManager()
    private init() {}
    
    func jsonToString() -> String? {
        guard let filename = getDocumentsDirectory()?.appendingPathComponent("CAUMeals.json")
        else { return nil }
        
        do {
            let stringData = try String(contentsOf: filename, encoding: String.Encoding.utf8)
            return stringData
        } catch {
            return nil
        }
    }
    
    func saveJson(_ strData: String) {
        guard let filename = getDocumentsDirectory()?
            .appendingPathComponent("CAUMeals.json")
        else { return }
        
        do {
            try strData.write(
                to: filename,
                atomically: true,
                encoding: String.Encoding.utf8
            )
        } catch {
            fatalError()
        }
    }
    
    private func getDocumentsDirectory() -> URL? {
        guard let paths = FileManager.default.urls(
            for: FileManager.SearchPathDirectory.applicationSupportDirectory,
            in: FileManager.SearchPathDomainMask.userDomainMask
        ).first
        else { return nil }
        return paths
    }
}
