//
//  QiitaSearchViewModel.swift
//  QiitaViewer
//
//  Created by Hina on 2024/08/19.
//

import Foundation

@MainActor
final class QiitaSearchViewModel: ObservableObject {
    @Published var articles = [Article]()
    @Published var isPresentingAlert = false
    @Published var loadingState: LoadingState = .idle
    @Published var searchText: String = ""

    func fetchAllArticles(query: String) async throws {
        do {
            loadingState = .loading
            articles = try await ArticleAPIClient().fetchArticles(query: query)
            loadingState = .success
        } catch let error as ArticleAPIClientError {
            switch error {
            case .invalidURL:
                loadingState = .networkFailure
            case .unexpectedResponse:
                loadingState = .networkFailure
            case .networkError:
                loadingState = .networkFailure
            case .serverError:
                loadingState = .serverFailure
            }
        } catch {
            loadingState = .networkFailure
        }
    }
}
