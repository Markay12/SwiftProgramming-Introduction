//
//  cswift
//  personInfoApp
//
//  Created by user on 1/22/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
class infoDictionary
{
    // dictionary that stores person records
    var infoRepository : [Int64:personRecord] = [Int64:personRecord] ()
    init() { }
  
    func add(_ name:String, _ ssn:Int64, _ age:Int16)
    {
        let pRecord =  personRecord(n: name, s:ssn, a: age)
        infoRepository[pRecord.ssn!] = pRecord
        
    }
    
    func add(p:personRecord)
    {
        print("adding" + p.name!)
        infoRepository[p.ssn!] = p
        
    }
    
    func search(s:Int64) -> personRecord?
    {
        var found = false
        
        for (ssn, _) in infoRepository
        {
            if ssn == s {
            found = true
                break
            }
        }
        if found
        {
           return infoRepository[s]
        }else  {
     
            return nil
            }
    }
    
    func deleteRec(s:Int64)
    {
        infoRepository[s] = nil
        
    }
}
