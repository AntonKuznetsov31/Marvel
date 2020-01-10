//
//  Character.swift
//  Marvel
//
//  Created by Anton Kuznetsov on 8/27/19.
//  Copyright © 2019 AntonKuznetsov. All rights reserved.
//

import UIKit
import Alamofire

struct Character: Decodable {
    
    let id: Int?
    let name: String?
    let description: String?
    var thumbnail: String?
    
    init(charactersDictionary: [String: Any]) {
        id = charactersDictionary["id"] as? Int
        name = charactersDictionary["name"] as? String
        description = charactersDictionary["description"] as? String
        guard let dict = charactersDictionary["thumbnail"] as? [String: String],
            let path = dict["path"],
            let ext = dict["extension"] else { return }
        thumbnail = "\(path).\(ext)"
    }
    
    static func getCharacters(from jsonData: Any) -> [Character]? {
        guard let json = jsonData as? [String: Any] else { return nil }
        guard let data = json["data"] as? [String: Any] else { return nil }
        guard let results = data["results"] as? [[String: Any]] else { return nil }
        return results.compactMap { Character(charactersDictionary: $0) }
    }
}

