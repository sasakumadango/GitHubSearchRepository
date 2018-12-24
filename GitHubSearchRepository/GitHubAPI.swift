//
//  GitHubAPI.swift
//  GitHubSearchRepository
//
//  Created by Yuta S. on 2018/03/18.
//  Copyright © 2018 Yuta S. All rights reserved.
//

import Foundation

final class GitHubAPI {
    struct SearchRepositiries: GitHubRequest {
        let keyword: String
        
        // GitHubRequestが要求する連想型
        typealias Response = SearchResponse<Repository>
        
        var method: HTTPMethods {
            return .get
        }
        
        var path: String {
            return "/search/repositories"
        }
        
        var parameters: Any? {
            return ["q": keyword]
        }
    }
    
    struct SearchUsers: GitHubRequest {
        let keyword: String
        
        // GitHubRequestが要求する連想型
        typealias Response = SearchResponse<Repository>
        
        var method: HTTPMethods {
            return .get
        }
        
        var path: String {
            return "/search/users"
        }
        
        var parameters: Any? {
            return ["q": keyword]
        }
    }
}
