//
//  ContentView.swift
//  QiitaViewer
//
//  Created by Hina on 2024/08/18.
//

import SwiftUI

struct QiitaSearchView: View {
    @StateObject var qiitaSearchViewModel: QiitaSearchViewModel

    var body: some View {
        VStack {
            SearchTextView(qiitaSearchViewModel: qiitaSearchViewModel)
            Spacer()
            switch qiitaSearchViewModel.loadingState {
            case .idle:
                ContentUnavailableView {
                    Label("キーワード検索", systemImage: "magnifyingglass")
                } description: {
                    Text("キーワードを検索で記事を探してください。")
                }
            case .loading:
                EmptyView()
            case .success:
                ArticleList(articles: qiitaSearchViewModel.articles)
            case .networkFailure:
                ContentUnavailableView {
                    Label("通信に失敗", systemImage: "wifi.slash")
                } description: {
                    Text("電波の良いところで通信してください。")
                }
            case .serverFailure:
                ContentUnavailableView {
                    Label("メンテナンス中", systemImage: "exclamationmark.magnifyingglass")
                } description: {
                    Text("メンテナンスが終了するまでお待ちください。")
                }
            }
        }
        .overlay {
            if qiitaSearchViewModel.loadingState.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .padding()
                    .tint(Color.white)
                    .background(Color.gray)
                    .cornerRadius(8)
                    .scaleEffect(1.2)
            }
        }
    }
}

#Preview {
    QiitaSearchView(qiitaSearchViewModel: QiitaSearchViewModel())
}
