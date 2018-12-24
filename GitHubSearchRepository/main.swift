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
let request = GitHubAPI.SearchRepositiries(keyword: kewWord)

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
