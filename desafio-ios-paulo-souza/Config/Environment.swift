//
//  Environment.swift
//  desafio-ios-paulo-souza
//
//  Created by Paulo Alfredo Coraini de Souza on 13/03/21.
//

import Foundation

public enum Environment {
  private static let infoDictionary: [String: Any] = {
    guard let dict = Bundle.main.infoDictionary else {
      fatalError("Plist file not found")
    }
    return dict
  }()

  static let marvelPublicKey: String = {
    guard let marvelPublicKey = Environment.infoDictionary["MARVEL_PUBLIC_KEY"] as? String else {
      fatalError("Marvel Public Key not set in plist for this environment")
    }
    return marvelPublicKey
  }()
    
    static let marvelPrivateKey: String = {
      guard let marvelPrivateKey = Environment.infoDictionary["MARVEL_PRIVATE_KEY"] as? String else {
        fatalError("Marvel PRivate Key not set in plist for this environment")
      }
      return marvelPrivateKey
    }()
}
