//
//  CustomError.swift
//  Yugioh
//
//  Created by Xavier Sotomayor on 27/2/24.
//

import Foundation
enum CustomError {
    case noConnection, noData
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noData: return "No data"
        case .noConnection: return "No Internet Connection"
        }
    }
}
