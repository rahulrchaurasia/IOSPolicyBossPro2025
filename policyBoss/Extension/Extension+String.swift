//
//  Extension+String.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 18/03/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import Foundation



extension String {
    
    //colorPrimaryDark #00476e
    //without removing spaces between words
    var removeSpecialCharacters: String {
        return self.components(separatedBy: CharacterSet.alphanumerics.inverted).filter({ !$0.isEmpty }).joined(separator: " ")
    }
    
    
    var removeSpecialCharactersWithoutSpace: String {
        return self.components(separatedBy: CharacterSet.alphanumerics.inverted).filter({ !$0.isEmpty }).joined()
    }
    
    var digitOnly: String { filter { ("0"..."9").contains($0) } }
    
    
    /* **********************************
    // let myString = "Hello, world!"
    // let characterAt5 = myString.stringAt(index: 5)  // characterAt5 will be "o"
     ***********************************  */
    func stringAt(index : Int) -> String
    {
        let stringIndex = self.index(self.startIndex,offsetBy: index)
        return String(self[stringIndex])
    }
    
    var isBackspace : Bool {
        
        let char = self.cString(using: String.Encoding.utf8)!
        return strcmp(char, "\\b") == -92
    }
    
    var isValidPhoneNumber: Bool {
        // Refine phone number validation using a robust regular expression or library
        let pattern = "^\\d{10}$" // Check for 10-digit Indian phone number format
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return predicate.evaluate(with: self)
    }

    var maskedPhoneNumber: String {
        // Improve masking to handle different lengths and country codes
        let firstPart = String(self.prefix(6))
        let maskedPart = String(repeating: "*", count: 4)
        let lastPart = String(self.suffix(4))
        return "\(firstPart)\(maskedPart)\(lastPart)"
    }
}
