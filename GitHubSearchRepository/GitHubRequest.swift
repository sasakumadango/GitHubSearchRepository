//
//  GitHubRequest.swift
//  GitHubSearchRepository
//
//  Created by Yuta S. on 2018/03/18.
//  Copyright © 2018 Yuta S. All rights reserved.
//


import Foundation

protocol GitHubRequest {
    associatedtype Response: JSONDecodable

    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethods { get }
    var parameters: Any? { get }
    var headers: [String: String]? { get }
}

extension GitHubRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    func buildURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        var urlRequest = URLRequest(url: url)

        switch method {
        case .get:
            let dictionaly = parameters as? [String: Any]
            let queryItems = dictionaly?.map { key, value in
                return URLQueryItem(name: key, value: String(describing: value))
            }
            components?.queryItems = queryItems
        case .post:
            urlRequest.httpBody = parameters as? Data
        default:
            fatalError("Unsupported methods\(method)")
        }

        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue

        if let headers = headers {
            for (key, value) in headers {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }

        return urlRequest
    }

    func response(from data: Data, urlResponse: URLResponse) throws -> Response {
        let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode

        // 204 Github Actions 処理受付成功時は204が返る
        // 値は何も返ってこない
        if statusCode == 204 {
            return try Response(json: "")
        }
        // 取得したデータをJSONに変換
        let json = try JSONSerialization.jsonObject(with: data)

        if case (200..<300)? = statusCode {
            // Jsonからモデルをインスタンス化
            return try Response(json: json)
        } else {
            // JsonからAPIエラーをインスタンス化
            throw try GitHubAPIResultError(json: json)
        }
    }
}
