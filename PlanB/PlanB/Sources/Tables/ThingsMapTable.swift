//
//  ThingsMapTable.swift
//  PlanB
//
//  Created by Klein Mioke on 5/19/16.
//  Copyright © 2016 Klein Mioke. All rights reserved.
//

import UIKit

class ThingsMapTable: KMPersistanceTable, TableProtocol {

    var database: KMPersistanceDatabase? {
        get { return DefaultDatabase.instance }
    }
    
    var tableName: String {
        get { return "things_map" }
    }
    
    var tableColumnInfo: [String : String] {
        get {
            return [
                "date":     "TEXT primary key",
                "group_id": "Integer",
                "things":   "TEXT"
            ]
        }
    }
}
