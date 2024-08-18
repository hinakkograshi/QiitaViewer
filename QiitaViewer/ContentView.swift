//
//  ContentView.swift
//  QiitaViewer
//
//  Created by Hina on 2024/08/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            // TODO:SearchView作成
            Button("フェッチした") {
                Task {
                    do {
                        let articles = try await ArticleAPIClient().fetchArticles(query: "Swift")
                        print("🐥\(articles)")
                    } catch {
                        print("失敗")
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
