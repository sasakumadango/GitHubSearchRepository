//
//  GitHubAPIError.swift
//  GitHubSearchRepository
//
//  Created by Yuta S. on 2018/03/18.
//  Copyright © 2018 Yuta S. All rights reserved.
//

import Foundation

struct GitHubAPIError: JSONDecodable, Error {
    struct FieldError: JSONDecodable {
        let resource: String
        let field: String
        let code: String
        
        init(json: Any) throws {
            Debug.PRINT_LOG()
            guard let dictionaly = json as? [String : Any] else {
                throw JSONDecoderError.invalidFormat(json: json)
            }
            
            guard let resource = dictionaly["resource"] as? String else {
                throw JSONDecoderError.missingValues(key: "resource", actualValue: dictionaly["resource"] as Any)
            }
            
            guard let field = dictionaly["field"] as? String else {
                throw JSONDecoderError.missingValues(key: "field", actualValue: dictionaly["field"] as Any)
            }
            
            guard let code = dictionaly["code"] as? String else {
                throw JSONDecoderError.missingValues(key: "code", actualValue: dictionaly["code"] as Any)
            }
            
            self.resource = resource
            self.field = field
            self.code = code
        }
    }
    
    let message: String
    let fieldErrors: [FieldError]
    
    init(json: Any) throws {
        Debug.PRINT_LOG()
        guard let dictionaly = json as? [String : Any] else {
            throw JSONDecoderError.invalidFormat(json: json)
        }
        
        guard let message = dictionaly["message"] as? String else {
            throw JSONDecoderError.missingValues(key: "mesage", actualValue: dictionaly["message"] as Any)
        }
        
        let fieldErrorObjects = dictionaly["errors"] as? [Any] ?? []
        let fieldErrors = try fieldErrorObjects.map {
            return try FieldError(json: $0)
        }
        
        self.message = message
        self.fieldErrors = fieldErrors
    }
}
