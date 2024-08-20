//
//  QiitaViewerApp.swift
//  QiitaViewer
//
//  Created by Hina on 2024/08/18.
//

import SwiftUI

@main
struct QiitaViewerApp: App {
    var body: some Scene {
        WindowGroup {
            QiitaSearchView(qiitaSearchViewModel: QiitaSearchViewModel())
        }
    }
}
