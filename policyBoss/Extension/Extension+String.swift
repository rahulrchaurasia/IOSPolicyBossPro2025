//
//  Extension+String.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 18/03/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import Foundation



extension String {
    
    //without removing spaces between words
    var removeSpecialCharacters: String {
        return self.components(separatedBy: CharacterSet.alphanumerics.inverted).filter({ !$0.isEmpty }).joined(separator: " ")
    }
    
    
    var removeSpecialCharactersWithoutSpace: String {
        return self.components(separatedBy: CharacterSet.alphanumerics.inverted).filter({ !$0.isEmpty }).joined()
    }
    
    var digitOnly: String { filter { ("0"..."9").contains($0) } }
}
