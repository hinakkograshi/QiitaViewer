//
//  MockURLSession.swift
//  QiitaViewer
//
//  Created by Hina on 2024/08/21.
//

import Foundation

struct MockURLSession: URLSessionProtocol {
    let statusCode: Int
    let jsonString: String

    func data(for request: URLRequest) async throws -> (Data, Int) {
        let data = jsonString.data(using: .utf8)!
        return (data, statusCode)
    }
}
