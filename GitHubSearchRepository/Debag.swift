//
//  Debag.swift
//  GitHubSearchRepository
//
//  Created by Yuta S. on 2018/04/22.
//  Copyright © 2018 Yuta S. All rights reserved.
//

import Foundation

class Debug {
    static func PRINT_LOG(object: String = "", fileName: String = #file, functionName: String = #function, line: Int = #line, column: Int = #column) {
        #if DEBUG
        let obj = object == "" ? "" : "[object: \(object)]"
        print("\(obj)[Function Name: \(functionName)] [Line: \(line)]")
        #endif
    }
}
