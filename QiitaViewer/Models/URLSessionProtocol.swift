//
//  URLSessionProtocol.swift
//  QiitaViewer
//
//  Created by Hina on 2024/08/21.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, Int)
}
