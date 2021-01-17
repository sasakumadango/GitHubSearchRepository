//
//  GitHubAPIResult.swift
//  GitHubSearchRepository
//
//  Created by Yuta S. on 2018/03/18.
//  Copyright © 2018 Yuta S. All rights reserved.
//


import Foundation

struct GitHubAPIResult {
    /// リポジトリー検索
    struct Repository: JSONDecodable {
        let id: Int
        let name: String
        let fullName: String
        let owner: User
        
        init(json: Any) throws {
            Debug.PRINT_LOG()
            guard let dictionary = json as? [String : Any] else {
                throw JSONDecoderError.invalidFormat(json: json)
            }
            
            guard let id = dictionary["id"] as? Int else {
                throw JSONDecoderError.missingValues(key: "id", actualValue: ["id"])
            }
            
            guard let name = dictionary["name"] as? String else {
                throw JSONDecoderError.missingValues(key: "name", actualValue: ["name"])
            }
            
            guard let fullName = dictionary["full_name"] as? String else {
                throw JSONDecoderError.missingValues(key: "full_name", actualValue: ["full_name"])
            }
            
            guard let ownerObject = dictionary["owner"] else {
                throw JSONDecoderError.missingValues(key: "owner", actualValue: dictionary["owner"] as Any)
            }
            
            self.id = id
            self.name = name
            self.fullName = fullName
            self.owner = try User(json: ownerObject)
        }
    }

    /// ユーザー検索
    struct User: JSONDecodable {
        let id: Int
        let login: String
        
        init(json: Any) throws {
            Debug.PRINT_LOG()
            guard let dictionary = json as? [String : Any] else {
                throw JSONDecoderError.invalidFormat(json: json)
            }
            
            guard let id = dictionary["id"] as? Int else {
                throw JSONDecoderError.missingValues(key: "id", actualValue: ["id"])
            }
            
            guard let login = dictionary["login"] as? String else {
                throw JSONDecoderError.missingValues(key: "Login", actualValue: ["Login"])
            }
            
            self.id = id
            self.login = login
        }
    }


    /// ブランチ名取得リザルト
    struct FetchBranch: JSONDecodable {
        let branchList: [Branch]

        init(json: Any) throws {
            guard let dictionary = json as? [[String: Any]] else {
                throw JSONDecoderError.invalidFormat(json: json)
            }

            var tmp: [Branch] = []
            try dictionary.forEach {
                guard let branch = try? Branch(json: $0) else {
                    throw JSONDecoderError.invalidFormat(json: dictionary)
                }

                tmp.append(branch)
            }

            self.branchList = tmp
        }

        struct Branch: JSONDecodable {
            let name: String

            init(json: Any) throws {
                guard let dictionary = json as? [String: Any] else {
                    throw JSONDecoderError.invalidFormat(json: json)
                }

                guard let name = dictionary["name"] as? String else {
                    throw JSONDecoderError.missingValues(key: "name", actualValue: ["name"])
                }

                self.name = name
            }
        }
    }

    /// ユーザー名取得リザルト
    struct FetchCollaborators: JSONDecodable {
        let collaborators: [Collaborator]

        init(json: Any) throws {
            guard let dictionary = json as? [[String: Any]] else {
                throw JSONDecoderError.invalidFormat(json: json)
            }

            var tmp: [Collaborator] = []
            try dictionary.forEach {
                guard let collaborator = try? Collaborator(json: $0) else {
                    throw JSONDecoderError.invalidFormat(json: dictionary)
                }

                tmp.append(collaborator)
            }

            self.collaborators = tmp
        }

        struct Collaborator: JSONDecodable {
            let name: String

            init(json: Any) throws {
                guard let dictionary = json as? [String: Any] else {
                    throw JSONDecoderError.invalidFormat(json: json)
                }

                guard let login = dictionary["login"] as? String else {
                    throw JSONDecoderError.missingValues(key: "login", actualValue: ["login"])
                }

                self.name = login
            }
        }
    }

    /// ブランチ名取得リザルト
    struct DoGithubActions: JSONDecodable {
        // このApiの成功時は何も返ってこない
        init(json: Any) throws {
        }
    }
}
