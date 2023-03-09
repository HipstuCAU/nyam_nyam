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
        let url = Bundle.main.url(forResource: "Dummy", withExtension: "json")
        if let url {
            do {
                let stringData = try String(contentsOf: url, encoding: String.Encoding.utf8)
                return stringData
            } catch {
                fatalError("Failed to load \(url) from bundle.")
            }
        }
        return ""
    }
    //TODO: 받아온 Json을 로컬로 저장하는 메소드
}
