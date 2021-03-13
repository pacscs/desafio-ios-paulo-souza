//
//  Constants.swift
//  desafio-ios-paulo-souza
//
//  Created by Paulo Alfredo Coraini de Souza on 12/03/21.
//

import Foundation
import UIKit
import CommonCrypto

let fake: Bool = false
enum EnumEndpoints {
    case characters
    case comics(String)
    
    func toString() -> String {
        switch self {
        case .characters: return "characters"
        case .comics(let id): return "characters/\(id)/comics"
        }
    }
}

enum EnumImageFolder: String {
    case avatar
    case cover
}

let public_key = Environment.marvelPublicKey
let private_key = Environment.marvelPrivateKey
let base_url = "https://gateway.marvel.com:443/v1/public/"
var ts: String {
    get {
        return String(Int(NSDate().timeIntervalSince1970) * 1000)
    }
}
var hash: String {
    get {
        return (ts+private_key+public_key).md5
    }
}
var suffix: String {
    get {
        return "apikey=\(public_key)" + "&ts=\(ts)" + "&hash=\(hash)"
    }
}
extension String {
    
    var md5: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            //CC_SHA256(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }

}

extension UITableView {
    
    func reloadData(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() }) { _ in completion() }
    }

}

extension Optional where Wrapped == URL {
    
    func removeExtra() -> String {
        guard let url = self else { return String() }
        return url.absoluteString.replacingOccurrences(of: "file://", with: "")
    }
    
}

extension UIView {
    
    func dropShadow(scale: Bool = true) {
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 6
        self.clipsToBounds = false
    }
    
}

