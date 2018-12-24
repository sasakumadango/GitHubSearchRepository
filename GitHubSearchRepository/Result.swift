//
//  Result.swift
//  GitHubSearchRepository
//
//  Created by Yuta S. on 2018/03/18.
//  Copyright © 2018 Yuta S. All rights reserved.
//

import Foundation

enum Result<T, Error: Swift.Error> {
    case success(T)
    case failure(Error)
    
    init(value: T) {
        Debug.PRINT_LOG()
        self = .success(value)
    }
    
    init(error: Error) {
        Debug.PRINT_LOG()
        self = .failure(error)
    }
}
