//
//  NetworkManager.swift
//  Marvel
//
//  Created by Anton Kuznetsov on 8/29/19.
//  Copyright © 2019 AntonKuznetsov. All rights reserved.
//

import Alamofire
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

struct NetworkManager {
    
    // MARK: - Private Properties
    
    private static let url = "http://gateway.marvel.com:80/v1/public/characters"
    private static let publicKey = "9a7830b428e8cfe7efc8f3819533f4e7"
    private static let privateKey = "75bf35f092ac9ff14262a6e12fb57c89f1ffdd7b"
    
    // MARK: - Public Methods
    
    static func fetchCharacters(completion: @escaping ([Character]) -> ()) {
        
        let ts = NSDate().timeIntervalSince1970.description
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        request(url, parameters: ["apikey": publicKey,
                                  "ts" : ts,
                                  "hash": hash]).validate().responseJSON { dataResponse in
                                    
            switch dataResponse.result {
            case .success(let value):
                let characters = Character.getCharacters(from: value)
                completion(characters ?? [])
            case .failure(let error):
                print("got an error: \(error)")
            }
        }
    }
}

// MARK: - Hash function for Marvel API

extension String {
    var md5: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
