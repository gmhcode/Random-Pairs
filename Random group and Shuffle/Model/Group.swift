//
//  Group.swift
//  Six Week Technical Challenge
//
//  Created by Greg Hughes on 1/11/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import Foundation

class Group: Codable{

    var personList : [String]
    var person1 : String
    var person2 : String
    
    
    init(person1: String, person2: String = "") {
        self.personList = [person1,person2]
        self.person1 = person1
        self.person2 = person2
    }
    
    
}
