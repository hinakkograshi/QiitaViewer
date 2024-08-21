//
//  MockURLSessionTest.swift
//  QiitaViewerTests
//
//  Created by Hina on 2024/08/21.
//

import XCTest
@testable import QiitaViewer

final class MockURLSessionTest: XCTestCase {

    private let jsonString = """
                [
                {
                    "id": "idTest1",
                    "likes_count": 1,
                    "title": "Test Article",
                    "user": {
                        "name": "hinakko",
                        "profile_image_url": "https://placehold.jp/60x60.png"
                    }
                }
                ]
                """
    // 正常時 StatusCode: 200
    func test_正常にURLSessionとDecodeが行われて記事が1つ返ってくる() async {
        let mockArticleAPIClient = ArticleAPIClient(urlSession: MockURLSession(statusCode: 200, jsonString: jsonString))
        do {
            let articles = try await mockArticleAPIClient.fetchArticles(query: "Test")
            XCTAssertEqual(articles.count, 1)
        } catch {
            XCTFail("Error: 記事が取得できませんでした")
        }
    }

    // 異常時 StatusCode: 400 networkError
    func test_400番の異常の時にnetworkErrorが返ってくる() async {
        let mockArticleAPIClient = ArticleAPIClient(urlSession: MockURLSession(statusCode: 400, jsonString: jsonString))
        do {
            _ = try await mockArticleAPIClient.fetchArticles(query: "Test")
            XCTFail("異常時であるはずが失敗しなかった")
        } catch let error as ArticleAPIClientError {
            XCTAssertEqual(error, ArticleAPIClientError.networkError)
        } catch {
            XCTFail("例外的なエラーが発生しました: \(error)")
        }
    }

    // 異常時 StatusCode: 500 serverError
    func test_500番の異常の時にserverErrorが返ってくる() async {
        let mockArticleAPIClient = ArticleAPIClient(urlSession: MockURLSession(statusCode: 500, jsonString: jsonString))
        do {
            _ = try await mockArticleAPIClient.fetchArticles(query: "Test")
            XCTFail("異常時であるはずが失敗しなかった")
        } catch let error as ArticleAPIClientError {
            XCTAssertEqual(error, ArticleAPIClientError.serverError)
        } catch {
            XCTFail("例外的なエラーが発生しました: \(error)")
        }
    }
}
