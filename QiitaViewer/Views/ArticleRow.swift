//
//  ArticleRow.swift
//  QiitaViewer
//
//  Created by Hina on 2024/08/19.
//

import SwiftUI

struct ArticleRow: View {
    let article: Article
    var body: some View {
        HStack {
            AsyncImage(url: article.user.profileImageURL) { userImage in
                userImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
            } placeholder: {
                ProgressView()
            }
            Text(article.title)
                .font(.headline)
                .padding(.bottom)
            Spacer()
            HStack {
                if article.likeCount == 0 {
                    Image(systemName: "heart")
                        .accessibilityLabel("いいね数")
                } else {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .accessibilityLabel("いいね数")
                }
                Text("\(article.likeCount)")
            }
        }
    }
}

#Preview {
    ArticleRow(article:
                Article(
                    id: "28389",
                    likeCount: 1,
                    title: "プログラミング文法,Swift,クリーンアーキテクチャ,API",
                    user: User(
                        name: "hinakko",
                        profileImageURL: URL(string: "https://placehold.jp/60x60.png")!
                    )
                )
    )
}
