//
//  MainViewController.swift
//  PlanB
//
//  Created by Klein Mioke on 5/17/16.
//  Copyright © 2016 Klein Mioke. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var GroupNameLabel: UILabel!
    
    var things: [Thing] = []
    var animationSwitch: Bool = false
    var delay: NSTimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let _ = CoreService.sharedInstance.lastGroupID() {
            self.reloadData()
            
        } else {
            self.goToGroupViewController()
        }
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "CG",
                                                                style: .Plain,
                                                                target: self,
                                                                action: #selector(MainViewController.goToGroupViewController))
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if CoreService.sharedInstance.shouldReload {
            CoreService.sharedInstance.shouldReload = false
            self.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func segmentCtrlValueChanged(sender: AnyObject) {
        
    }
    
    func goToGroupViewController() -> Void {
        self.performSegueWithIdentifier("kShowAddGroup", sender: nil)
    }

    @IBAction func addThing(sender: AnyObject) {
        
        let thing = Thing(createDate: NSDate(), beginDate: NSDate(), planDays: 1, isEmergency: false)
        thing.groupId = CoreService.sharedInstance.groupID!
        thing.remark = "test thing---\(thing.createDate)"
        thing.title = "Test thing -- \(thing.createDate)"
        
        if ThingTable().replaceRecord(thing) {
            self.things.append(thing)
        }
        self.reloadData()
    }
    
    func reloadData() -> Void {
        
        if let group = CoreService.sharedInstance.currentGroup {
            self.GroupNameLabel.text = group.name
        }
        self.things = CoreService.sharedInstance.thingsShouldFinishedInDate(NSDate())
        
        self.animationSwitch = true
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toDetailSegue" {
            guard let vc = segue.destinationViewController as? ThingInfoViewController,
                let cell = sender as? ThingSummaryCell else {
                assert(false, "Wrong destination vc")
            }
            vc.thing = cell.thing
        }
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.things.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier("kThingSummaryCell") as? ThingSummaryCell else {
            return UITableViewCell()
        }
        
        cell.setWithThing(self.things[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if !animationSwitch { return }
        cell.x = 15
        cell.alpha = 0
        
        UIView.animateWithDuration(0.2, delay: delay, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
            cell.x = 0; cell.alpha = 1
        }, completion: nil)
        
        delay += 0.08
        
        if indexPath.row == self.things.count - 1 {
            delay = 0
            animationSwitch = false
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}