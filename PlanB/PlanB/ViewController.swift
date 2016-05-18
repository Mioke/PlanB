//
//  ViewController.swift
//  PlanB
//
//  Created by Klein Mioke on 5/16/16.
//  Copyright © 2016 Klein Mioke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let group = WorkGroup(id: 12, name: "test group")
        WorkGroupTable().replaceRecord(group)
        
        let thing = Thing(createDate: NSDate(), beginDate: NSDate(), planDays: 2, isEmergency: false)
        thing.groupId = group.id
        thing.remark = "test thing"
        
        ThingTable().replaceRecord(thing)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

