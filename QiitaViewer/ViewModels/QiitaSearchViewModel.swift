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
    @Published var currentAlertType: CustomAlert.AlertType?
    @Published var loadingState: LoadingState = .idle
    @Published var searchText: String = ""


    func fetchAllArticles() async throws {
        do {
            loadingState = .loading
            articles = try await ArticleAPIClient().fetchArticles(query: searchText)
            loadingState = .success
        } catch let error as ArticleAPIClientError {
            loadingState = .failure
            switch error {
            case .invalidURL:
                await showNetWorkErrorAlert()
            case .unexpectedResponse:
                await showRetryAlert()
            case .networkError:
                await showRetryAlert()
            case .serverError:
                showServerErrorAlert()
            }
        } catch {
            loadingState = .failure
            await showRetryAlert()
        }
    }

    private func showNetWorkErrorAlert() async {
        closeAlert(title: "通信エラー", message: "通信することができませんでした。")
    }

    private func showServerErrorAlert() {
        closeAlert(title: "メンテナンス中", message: "メンテナンス後にお試しください。")
    }

    private func showRetryAlert() async {
        await retryAlert(title: "通信エラー", message: "もう一度通信しますか？")
    }

    private func closeAlert(title: String, message: String) {
        currentAlertType = .close(title: title, message: message)
        isPresentingAlert = true
    }

    private func retryAlert(title: String, message: String) async {
        currentAlertType = .retry(title: title, message: message) { [weak self] in
            try? await self?.fetchAllArticles()
        }
        isPresentingAlert = true
    }
}
