//
//  AppConfig.swift
//  PlanB
//
//  Created by Klein Mioke on 5/17/16.
//  Copyright © 2016 Klein Mioke. All rights reserved.
//

import UIKit

class AppConfig: NSObject {

    private static let logKey = "s190n131kx"
    private static let instance = AppConfig()
    
    var isTodayFirstLogin = true
    
    static func initialize_config() {
        
        let now = NSDate()
        
        if let last = NSUserDefaults.standardUserDefaults().objectForKey(logKey) as? NSDate {
            if last.isDayEqualToDate(now) {
                instance.isTodayFirstLogin = false
            } else {
                NSUserDefaults.standardUserDefaults().setObject(now, forKey: logKey)
            }
        } else {
            NSUserDefaults.standardUserDefaults().setObject(now, forKey: logKey)
        }
    }
    
    static var isFirstLoginToday: Bool {
        get { return instance.isTodayFirstLogin }
    }
    
}
