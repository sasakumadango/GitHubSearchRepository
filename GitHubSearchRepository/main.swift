//
//  main.swift
//  GitHubSearchRepository
//
//  Created by Yuta S. on 2018/03/18.
//  Copyright © 2018 Yuta S. All rights reserved.
//

import Foundation

print("Enter your, query here >", terminator: " ")

/// 入力されたクエリの取得
guard let kewWord = readLine() else { exit(1) }

/// APIクライアント生成
let client = GitHubClient()

/// リクエストの発行
let request = GitHubAPIRequest.SearchRepositiries(keyword: kewWord)

// リクエストの送信
client.send(request: request) { result in
    Debug.PRINT_LOG()
    switch result {
    case let .success(response):
        // リポジトリの所有者と名前を出力
        response.items.forEach { print($0.owner.login + "/" + $0.name) }
        exit(0)
    case let .failure(error):
        print(error)
        exit(0)
    }
}

/// タイムアウト時間
let timeoutInterval: TimeInterval = 60

// タイムアウトまでメインスレッドを停止
Thread.sleep(forTimeInterval: timeoutInterval)

// タイムアウト後の処理
print("Connection timeout")
exit(1)

/// リモートのブランチ名取得
func fetchBranchName() {
    /// APIクライアント生成
    let client = GitHubClient()
    
    /// リクエストの発行
    let request = GitHubAPIRequest.FetchBranchName()
    
    // リクエストの送信
    client.send(request: request) { result in
        DispatchQueue.main.async {
            switch result {
            case let .success(response):
                print(response)
            case let .failure(error):
                print(error)
            }
        }
    }
}

/// メンバー取得
func fetchCollaborators() {
    /// APIクライアント生成
    let client = GitHubClient()
    
    /// リクエストの発行
    let request = GitHubAPIRequest.FetchCollaborators()
    
    // リクエストの送信
    client.send(request: request) { result in
        DispatchQueue.main.async {
            switch result {
            case let .success(response):
                print(response)
            case let .failure(error):
                print(error)
            }
        }
    }
}


/// Github Actions 実行
/// - Parameters:
///   - branchName: ブランチ名
func doGithubActions(branchName: String) {
    /// APIクライアント生成
    let client = GitHubClient()
    let clientPayload = GitHubAPIRequest.DoGithubActions.JsonModel.Payload(ref: branchName)
    let encoder = JSONEncoder()
    guard let jsonValue = try? encoder.encode(GitHubAPIRequest.DoGithubActions.JsonModel(client_payload: clientPayload)) else {
        fatalError("Failed to encode to JSON.")
    }
    
    /// リクエストの発行
    let request = GitHubAPIRequest.DoGithubActions(parameters: jsonValue)
    
    // リクエストの送信
    client.send(request: request) { result in
        DispatchQueue.main.async {
            switch result {
            case .success(_):
                print("Done Github Actions")
            case let .failure(error):
                print(error)
            }
        }
    }
}
