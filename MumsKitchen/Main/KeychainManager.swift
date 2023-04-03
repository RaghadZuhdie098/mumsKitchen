//
// 
// KeychainManager.swift
// MumsKitchen
//
// Created by Raghad Ikhwizhieh
// Copyright © MAF Digital Lab - Jordan. All rights reserved. 
//


import Foundation
import Security


class KeychainManager {

    static  let  apiKeyIdentifier = "com.spoonacular.apikey"

    func saveApiKey() {

        guard let apiKey = getAPIKeyFromPlist() else {
            print("Error retrieving API key from plist")
            return
        }
        
        let saveQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: KeychainManager.apiKeyIdentifier,
            kSecValueData as String: apiKey.data(using: .utf8)!
        ]
        
        let status = SecItemAdd(saveQuery as CFDictionary, nil)

        switch status {
        case errSecSuccess:
            print("API key saved to keychain")
            break
        case errSecDuplicateItem:
            print("API key already exists in keychain")
            update()

        default:
            print("Error saving API key to keychain: \(status)")
        }

    }

   static func retrieveApiKey() -> String? {
        let readQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: apiKeyIdentifier,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]
//The constant kSecReturnData is used to indicate that data should be returned, and true is the value for this attribute.
       //. The constant kSecMatchLimit is used to indicate the maximum number of matching items that should be returned, and kSecMatchLimitOne indicates that only one item should be returned.
        var result: AnyObject?
        let status = SecItemCopyMatching(readQuery as CFDictionary, &result)
        if status == errSecSuccess,
           let data = result as? Data,
           let apiKey = String(data: data, encoding: .utf8) {
            print("API key retrieved from keychain: \(apiKey)")
            return apiKey
        } else {
            print("Error retrieving API key from keychain: \(status)")
            return nil
        }
    }


    private func update()  {
        guard let apiKey = getAPIKeyFromPlist() else {
            print("Error retrieving API key from plist")
            return
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: KeychainManager.apiKeyIdentifier,
        ]

        let attributes: [String: Any] = [
            kSecValueData as String: apiKey.data(using: .utf8)!
        ]

        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)

        guard status != errSecItemNotFound else {
           print("Can't update key not found")
            return
        }

        guard status == errSecSuccess else {
            return
        }
        print("No error the key is updated")

    }

   private func getAPIKeyFromPlist() -> String? {
        guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
              let keysDict = NSDictionary(contentsOfFile: path),
              let apiKey = keysDict["apiKey"] as? String
        else {
            return nil
        }
        return apiKey
    }

}
