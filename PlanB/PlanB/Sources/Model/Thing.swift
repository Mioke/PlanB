//
//  Thing.swift
//  PlanB
//
//  Created by Klein Mioke on 5/16/16.
//  Copyright © 2016 Klein Mioke. All rights reserved.
//

import Foundation

class Thing: NSObject {
    
    var createDate: NSTimeInterval = NSDate.distantPast().timeIntervalSince1970
    var beginDate: NSDate = NSDate.distantPast()
    var needDays: Int = 0
    var planEndDate: NSDate = NSDate.distantPast()
    var isEmergency: Bool = false
    var remark: String = ""
    var groupId: Int = -1
    
    var title: String = ""
    var isFinished: Bool = false
    
    override init() {
        super.init()
    }
    
    convenience init(createDate: NSDate, beginDate: NSDate, planDays: Int, isEmergency: Bool) {
        self.init()
        self.createDate = createDate.timeIntervalSince1970
        self.beginDate = beginDate
        self.needDays = planDays
        self.planEndDate = self.beginDate.dateByAddingTimeInterval(NSTimeInterval(self.needDays - 1) * 86400)
    }
}

extension Thing: RecordProtocol {
    
    func dictionaryRepresentationInTable(table: TableProtocol) -> [String : AnyObject]? {
        guard table is ThingTable else {
            return nil
        }
        return [
            "create_time":      Int(self.createDate),
            "begin_time":       Int(self.beginDate.timeIntervalSince1970),
            "need_days":        self.needDays,
            "plan_end_date":    Int(self.planEndDate.timeIntervalSince1970),
            "is_emergency":     self.isEmergency,
            "remark":           self.remark,
            "group_id":         self.groupId,
            "title":            self.title,
            "is_finished":      self.isFinished
        ]
    }
    
    static func readFromQueryResultDictionary(dictionary: NSDictionary, table: TableProtocol) -> Thing? {
        
        if table is ThingTable {
            let new = Thing()
            new.createDate = Double(dictionary["create_time"] as? Int ?? 0)
            new.beginDate = NSDate(timeIntervalSince1970: NSTimeInterval(dictionary["begin_time"] as? Int ?? 0))
            new.needDays = dictionary["need_days"] as? Int ?? 0
            new.planEndDate = NSDate(timeIntervalSince1970: NSTimeInterval(dictionary["plan_end_date"] as? Int ?? 0))
            new.isEmergency = Bool(dictionary["is_emergency"] as? Int ?? 0)
            new.remark = dictionary["remark"] as? String ?? ""
            new.groupId = dictionary["group_id"] as? Int ?? -1
            new.title = dictionary["title"] as? String ?? ""
            new.isFinished = Bool(dictionary["is_finished"] as? Int ?? 0)
            return new
        }
        return nil
    }
}