//
//  ThingTable.swift
//  PlanB
//
//  Created by Klein Mioke on 5/16/16.
//  Copyright © 2016 Klein Mioke. All rights reserved.
//

import Foundation

class ThingTable: KMPersistanceTable, TableProtocol {

    weak var database: KMPersistanceDatabase? {
        get {
            return DefaultDatabase.instance
        }
    }
    var tableName: String {
        get { return "Thing" }
    }
    
    var tableColumnInfo: [String : String] {
        get {
            return [
                "create_time":      "Integer primary key",
                "begin_time":       "Integer",
                "need_days":        "Integer",
                "plan_end_date":    "Integer",
                "is_emergency":     "BOOL",
                "remark":           "TEXT",
                "group_id":         "Integer",
                "title":            "TEXT",
                "is_finished":      "BOOL",
                "finished_date":    "Integer default NULL",
                "is_success":       "Integer default 0"
            ]
        }
    }
}
