//
//  StringExtension.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 19.02.23.
//

import Foundation
import CryptoKit

extension String {
    func md5() -> String {
        guard let data = self.data(using: .utf8) else {
            return " "
        }
        return Insecure.MD5.hash(data: data).map { String(format: "%02hhx", $0) }.joined()
    }

    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.dropFirst()
    }
}
