//
//  WorkGroupTable.swift
//  PlanB
//
//  Created by Klein Mioke on 5/16/16.
//  Copyright © 2016 Klein Mioke. All rights reserved.
//

import Foundation

class WorkGroupTable: KMPersistanceTable, TableProtocol {
    
    weak var database: KMPersistanceDatabase? {
        get { return DefaultDatabase.instance }
    }
    
    var tableName: String {
        get { return "work_group" }
    }
    
    var tableColumnInfo: [String : String] {
        get {
            return [
                "id": "Integer primary key",
                "name": "varchar"
            ]
        }
    }
}
