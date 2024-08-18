//
//  ArticleAPIClientError.swift
//  QiitaViewer
//
//  Created by Hina on 2024/08/19.
//

import Foundation

enum ArticleAPIClientError: LocalizedError {
    case invalidURL
    case unexpectedResponse
    case networkError
    case serverError

    /// The error message returned from errorDescription
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "invalid URL error happened"
        case .unexpectedResponse:
            "unexpected response error happened"
        case .networkError:
            "network error happened"
        case .serverError:
            "server error happened"
        }
    }
}
