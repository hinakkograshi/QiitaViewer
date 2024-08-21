//
//  ArticleAPIClient.swift
//  QiitaViewer
//
//  Created by Hina on 2024/08/19.
//

import Foundation

struct ArticleAPIClient {
    let urlSession: any URLSessionProtocol
    func fetchArticles(query: String) async throws -> [Article] {
        let components = Self.createArticleURLComponents(query: query)
        let articles = try await fetchData(components: components, responseType: [Article].self)
        return articles
    }

    private func fetchData<T: Decodable>(components: URLComponents, responseType: T.Type) async throws -> T {
        guard let url = components.url else { throw ArticleAPIClientError.invalidURL  }
        let urlRequest = URLRequest(url: url)
        let data: Data
        let statusCode: Int
        do {
            (data, statusCode) = try await urlSession.data(for: urlRequest)
        } catch {
            throw ArticleAPIClientError.networkError
        }

        switch statusCode {
        case 100 ... 199:
            throw ArticleAPIClientError.networkError
        case 200 ... 299:
            let articleArray = try JSONDecoder().decode(T.self, from: data)
            return articleArray
        case 300 ... 399:
            throw ArticleAPIClientError.networkError
        case 400 ... 499:
            throw ArticleAPIClientError.networkError
        case 500 ... 599:
            throw ArticleAPIClientError.serverError
        default:
            throw ArticleAPIClientError.networkError
        }
    }

    private static func createArticleURLComponents(query: String) -> (URLComponents) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "qiita.com"
        components.path = "/api/v2/items"
        let queryItems = [
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "per_page", value: "20"),
            URLQueryItem(name: "query", value: query)
        ]
        components.queryItems = queryItems
        return components
    }
}
