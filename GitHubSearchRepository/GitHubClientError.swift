//
//  GitHubClientError.swift
//  GitHubSearchRepository
//
//  Created by Yuta S. on 2018/03/18.
//  Copyright © 2018 Yuta S. All rights reserved.
//

import Foundation

enum GitHubClientError: Error {
    /// 通信失敗
    case connectionError(Error)
    /// レスポンス解釈の失敗
    case responseParaseError(Error)
    /// APIからエラーレスポンスを受け取った
    case apiError(GitHubAPIError)
}
