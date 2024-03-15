//
//  LoggingService.swift
//  NyamNyam
//
//  Created by 박준홍 on 3/14/24.
//

import Foundation
import Logging

protocol LoggingServiceProtocol {
    func log(level: Logger.Level, message: Logger.Message, metadata: Logger.Metadata?, file: String, function: String, line: UInt)
}

class LoggingService: LoggingServiceProtocol {
    private let logger: Logger

    init(label: String) {
        self.logger = Logger(label: label)
    }

    func log(
        level: Logger.Level,
        message: Logger.Message,
        metadata: Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        logger.log(
            level: level,
            message,
            metadata: metadata,
            source: "",
            file: file,
            function: function,
            line: line
        )
    }
}
