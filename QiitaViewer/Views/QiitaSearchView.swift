//
//  ContentView.swift
//  QiitaViewer
//
//  Created by Hina on 2024/08/18.
//

import SwiftUI

struct QiitaSearchView: View {
    @StateObject private var qiitaSearchViewModel: QiitaSearchViewModel

    var body: some View {

        NavigationStack {
            Button("フェッチ") {
                Task {
                    let articles = try await ArticleAPIClient().fetchArticles(query: "Swift")
                    print(articles)
                }
            }

        }
        .searchable(text: $searchText, prompt: "キーワード検索")
        .keyboardType(.default)
        .scrollDismissesKeyboard(.immediately)
    }
}

#Preview {
    QiitaSearchView()
}
