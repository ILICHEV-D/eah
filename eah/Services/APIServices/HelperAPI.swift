//
//  HelperAPI.swift
//  eah
//
//  Created by Danil Ilichev on 02.07.2022.
//

import Foundation

// MARK: - MyError

enum MyError: Error {
    case format
    case decode
    case invalidURL
}

extension MyError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .format:
            return "Received neither error nor data"
        case .decode:
            return "Got data in unexpected format, it might be error description"
        case .invalidURL:
            return "URL is incorrect :("
        }
    }
}
