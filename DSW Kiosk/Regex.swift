//
//  Regex.swift
//  DSW Kiosk
//
//  Created by Jay Zeschin on 9/21/17.
//  Copyright © 2017 Denver Startup Week. All rights reserved.
//

import Foundation

// Adapted from http://benscheirman.com/2014/06/regex-in-swift/

class Regex {
    let internalExpression: NSRegularExpression
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
        try! self.internalExpression = NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    
    func test(input: String) -> Bool {
        let matches = self.internalExpression.matches(in:input, range:NSMakeRange(0, input.characters.count))
        return matches.count > 0
    }
}
