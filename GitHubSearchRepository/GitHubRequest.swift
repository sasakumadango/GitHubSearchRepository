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
}

extension GitHubRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    func buildURLRequest() -> URLRequest {
        Debug.PRINT_LOG()
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        switch method {
        case .get:
            let dictionaly = parameters as? [String: Any]
            let queryItems = dictionaly?.map { key, value in
                return URLQueryItem(name: key, value: String(describing: value))
            }
            components?.queryItems = queryItems
        default:
            fatalError("Unsupported methods\(method)")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
    func response(from data: Data, urlResponse: URLResponse) throws -> Response {
        Debug.PRINT_LOG()
        // 取得したデータをJSONに変換
        let json = try JSONSerialization.jsonObject(with: data)
        
        if case (200..<300)? = (urlResponse as? HTTPURLResponse)?.statusCode {
            // Jsonからモデルをインスタンス化
            return try Response(json: json)
        } else {
            // JsonからAPIエラーをインスタンス化
            throw try GitHubAPIError(json: json)
        }
    }
}
