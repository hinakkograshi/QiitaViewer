//
//  ArticleList.swift
//  QiitaViewer
//
//  Created by Hina on 2024/08/19.
//

import SwiftUI

struct ArticleList: View {
    let articles: [Article]
    var body: some View {
        List(articles) { article in
            ArticleRow(article: article)
        }
        .listStyle(.plain)
    }
}

#Preview {
    ArticleList(articles: [
        Article(
            id: "28389",
            likeCount: 1,
            title: "プログラミング文法,Swift,クリーンアーキテクチャ,API",
            user: User(
                name: "hinakko",
                profileImageURL: URL(string: "https://placehold.jp/350x600.png")!
            )
        )
    ])
}
