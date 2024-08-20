//
//  RealURLSession.swift
//  QiitaViewer
//
//  Created by Hina on 2024/08/21.
//

import Foundation

struct RealURLSession: URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, Int) {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpURLResponse = response as? HTTPURLResponse else { throw ArticleAPIClientError.unexpectedResponse }
        let code = httpURLResponse.statusCode
        return (data, code)
    }
}
