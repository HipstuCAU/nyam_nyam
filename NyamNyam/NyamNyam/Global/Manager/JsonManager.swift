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
    
    func jsonToString() -> String {
        let filename = getDocumentsDirectory().appendingPathComponent("Dummy.json")
            do {
                let stringData = try String(contentsOf: filename, encoding: String.Encoding.utf8)
                return stringData
            } catch {
                fatalError("Failed to load \(filename) from bundle.")
            }
    }
    func saveJson(_ strData: String) {
        let filename = getDocumentsDirectory().appendingPathComponent("Dummy.json")
        do {
            try strData.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            fatalError()
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: FileManager.SearchPathDirectory.applicationSupportDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)[0]
        return paths
    }
}
