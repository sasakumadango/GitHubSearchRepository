//
//  JSONDecodeError.swift
//  GitHubSearchRepository
//
//  Created by Yuta S. on 2018/03/18.
//  Copyright © 2018 Yuta S. All rights reserved.
//

import Foundation

protocol JSONDecodable {
    init(json: Any) throws
}

enum JSONDecoderError: Error {
    case invalidFormat(json: Any)
    case missingValues(key: String, actualValue: Any)
}
