//
//  RootState.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/08.
//

import Foundation
import ReactorKit

struct RootPresentableState {
    @Pulse var isLoading = false
    @Pulse var alertMessage: String = ""
}
