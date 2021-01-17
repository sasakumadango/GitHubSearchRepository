//
//  GitHubAPIRequest.swift
//  GitHubSearchRepository
//
//  Created by Yuta S. on 2018/03/18.
//  Copyright © 2018 Yuta S. All rights reserved.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case head = "HEAD"
    case delete = "DELETE"
    case patch = "PATCH"
    case trace = "TRACE"
    case options = "OPTIONS"
    case connect = "CONNECT"
}

final class GitHubAPIRequest {
    static let USERNAME = "sasakumadango"
    static let REPOSITORY = "GitHubSearchRepository"
    
    /// リポジトリー検索
    struct SearchRepositiries: GitHubRequest {
        let keyword: String
        
        // GitHubRequestが要求する連想型
        typealias Response = SearchResponse<GitHubAPIResult.Repository>
        
        var method: HTTPMethods {
            return .get
        }
        
        var path: String {
            return "/search/repositories"
        }
        
        var headers: [String: String]? {
            return ["Accept": "application/vnd.github.v3+json"]
        }
        
        var parameters: Any? {
            return ["q": keyword]
        }
    }
    
    /// ユーザー検索
    struct SearchUsers: GitHubRequest {
        let keyword: String
        
        // GitHubRequestが要求する連想型
        typealias Response = SearchResponse<GitHubAPIResult.User>
        
        var method: HTTPMethods {
            return .get
        }
        
        var path: String {
            return "/search/users"
        }
        
        var headers: [String: String]? {
            return ["Accept": "application/vnd.github.v3+json"]
        }
        
        var parameters: Any? {
            return ["q": keyword]
        }
    }
    
    /// ブランチ名取得
    struct FetchBranchName: GitHubRequest {
        /// GitHubRequestが要求する連想型
        typealias Response = GitHubAPIResult.FetchBranch
        
        var method: HTTPMethods {
            return .get
        }
        
        var path: String {
            return "repos/\(GitHubAPIRequest.USERNAME)/\(GitHubAPIRequest.REPOSITORY)/branches"
        }
        
        var headers: [String: String]? {
            return ["Authorization": "token \(GITHUB_TOKEN)", "Accept": "application/vnd.github.v3+json"]
        }
        
        var parameters: Any? {
            return []
        }
    }
    
    /// ユーザー名取得
    struct FetchCollaborators: GitHubRequest {
        /// GitHubRequestが要求する連想型
        typealias Response = GitHubAPIResult.FetchCollaborators
        
        var method: HTTPMethods {
            return .get
        }
        
        var path: String {
            return "repos/\(GitHubAPIRequest.USERNAME)/\(GitHubAPIRequest.REPOSITORY)/collaborators"
        }
        
        var headers: [String: String]? {
            return ["Authorization": "token \(GITHUB_TOKEN)", "Accept": "application/vnd.github.v3+json"]
        }
        
        var parameters: Any? {
            return []
        }
    }
    
    /// Github Actions 実行
    struct DoGithubActions: GitHubRequest {
        /// GitHubRequestが要求する連想型
        typealias Response = GitHubAPIResult.DoGithubActions
        
        var method: HTTPMethods {
            return .post
        }
        
        var path: String {
            return "repos/\(GitHubAPIRequest.USERNAME)/\(GitHubAPIRequest.REPOSITORY)/dispatches"
        }
        
        var headers: [String: String]? {
            return ["Authorization": "token \(GITHUB_TOKEN)", "Accept": "application/vnd.github.v3+json"]
        }
        
        let parameters: Any?
        /// Github Actions のPost のデータ
        struct JsonModel: Codable {
            var event_type: String = "test-man"
            let client_payload: Payload
            
            struct Payload: Codable {
                /// 対象ブランチ
                let ref: String
            }
        }
    }
}
