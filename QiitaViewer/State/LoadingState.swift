//
//  LoadingState.swift
//  QiitaViewer
//
//  Created by Hina on 2024/08/19.
//

import Foundation

enum  LoadingState {
    /// 初期状態
    case idle
    /// ロード中
    case loading
    /// 成功
    case success
    /// ネットワーク失敗
    case networkFailure
    /// サーバー失敗
    case serverFailure

    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
}
