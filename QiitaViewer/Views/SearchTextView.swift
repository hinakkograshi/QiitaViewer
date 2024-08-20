//
//  SearchTextView.swift
//  QiitaViewer
//
//  Created by Hina on 2024/08/20.
//

import SwiftUI

struct SearchTextView: View {
    @ObservedObject var qiitaSearchViewModel: QiitaSearchViewModel
    var body: some View {
        HStack {
            HStack {
                TextField("キーワード検索", text: $qiitaSearchViewModel.searchText)
                if !qiitaSearchViewModel.searchText.isEmpty {
                    Button {
                        qiitaSearchViewModel.searchText = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.gray)
                            .accessibilityLabel("閉じるボタン")
                    }
                }
            }
            .padding(15)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(5)

            Button {
                Task {
                    try await qiitaSearchViewModel.fetchAllArticles(query: qiitaSearchViewModel.searchText)
                }
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20))
                    .accessibilityLabel("検索ボタン")
            }
            .padding(5)
            .foregroundColor(.white)
            .background(qiitaSearchViewModel.searchText.isEmpty ? Color(.systemGray3) : Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .disabled(qiitaSearchViewModel.searchText.isEmpty)
        }.padding(5)
    }
}

#Preview {
    SearchTextView(qiitaSearchViewModel: QiitaSearchViewModel())
}
