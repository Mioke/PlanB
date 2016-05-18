//
//  CoreService.swift
//  PlanB
//
//  Created by Klein Mioke on 5/16/16.
//  Copyright © 2016 Klein Mioke. All rights reserved.
//

import UIKit

class CoreService: KMBaseService {

    static let sharedInstance = CoreService()
    
    private let lastGroupKey = "af18n1nau9"
    private var currentGroupID: Int?
    
    var shouldReload = false
    
    override init() {
        super.init()
        self.currentGroupID = self.lastGroupID()
    }
    
    var groupID: Int? {
        get { return currentGroupID }
    }
    
    var currentGroup: WorkGroup? {
        get {
            guard let id = self.currentGroupID else { return nil }
            
            let condition = DatabaseCommandCondition()
            condition.whereConditions = "id = \(id)"
            let result = WorkGroupTable().queryRecordWithSelect(nil, condition: condition)
            assert(result.count > 0, "Database data error, missing current group with id: \(id)")
            
            for dic in result where dic is NSDictionary {
                return WorkGroup.readFromQueryResultDictionary(dic as! NSDictionary, table: WorkGroupTable())
            }
            return nil
        }
    }
    
    func thingsShouldFinishedInDate(date: NSDate) -> [Thing] {
        
        assert(currentGroupID != nil, "Should select group first")
        
        let begin = date.originTimeOfDay
        let condition = DatabaseCommandCondition()
        condition.whereConditions = "plan_end_date >= \(begin) and plan_end_date < \(begin + 86400) and group_id = \(self.currentGroupID!)"
        
        
        let table = ThingTable()
        let result = table.queryRecordWithSelect(nil, condition: condition)
        var things = [Thing]()
        
        for dic in result where dic is NSDictionary {
            if let th = Thing.readFromQueryResultDictionary(dic as! NSDictionary, table: table) {
                things.append(th)
            }
        }
        return things
    }
    
    var groups: [WorkGroup] {
        get {
            let table = WorkGroupTable()
            let result = table.queryRecordWithSelect(nil, condition: DatabaseCommandCondition())
            
            var groups = [WorkGroup]()
            
            for dic in result where dic is NSDictionary {
                if let gp = WorkGroup.readFromQueryResultDictionary(dic as! NSDictionary, table: table) {
                    groups.append(gp)
                }
            }
            return groups
        }
    }
    
    func selectGroupID(id: Int) -> Void {
        if id == self.currentGroupID {
            return
        }
        self.currentGroupID = id
        NSUserDefaults.standardUserDefaults().setInteger(id, forKey: lastGroupKey)
        self.shouldReload = true
    }
    
    func lastGroupID() -> Int? {
        return NSUserDefaults.standardUserDefaults().objectForKey(lastGroupKey) as? Int
    }
}
