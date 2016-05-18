//
//  WorkGroup.swift
//  PlanB
//
//  Created by Klein Mioke on 5/16/16.
//  Copyright © 2016 Klein Mioke. All rights reserved.
//

import Foundation

class WorkGroup: NSObject {

    var name: String = ""
    var id: Int = 0
    
    override init() {
        super.init()
    }
    
    init(id: Int, name: String) {
        super.init()
        self.id = id
        self.name = name
    }
}

extension WorkGroup: RecordProtocol {
    
    func dictionaryRepresentationInTable(table: TableProtocol) -> [String : AnyObject]? {
        
        guard table is WorkGroupTable else { return nil }
        
        return [
            "id": self.id,
            "name": self.name
        ]
    }
    
    static func readFromQueryResultDictionary(dictionary: NSDictionary, table: TableProtocol) -> WorkGroup? {
        
        guard table is WorkGroupTable,
            let name = dictionary["name"] as? String,
            let id = dictionary["id"] as? Int
        else { return nil }
        
        return WorkGroup(id: id, name: name)
    }
}