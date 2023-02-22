//
//  personRecord.swift
//  personInfoApp
//
//  Created by user on 1/22/17.
//  Copyright © 2017 ASU. All rights reserved.
//

// persn record class that defines the person record structure
import Foundation
class personRecord
{
    var name:String? = nil
    var ssn:Int64? = nil
    var age:Int16? = nil
    
    init(n:String, s:Int64, a:Int16) {
        self.name = n
        self.ssn = s
        self.age = a
    }
    
    func change_age(newAge:Int16)
    {
        self.age = newAge;
    }
    
}
    
    
    
    
