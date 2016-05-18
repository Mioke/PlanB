//
//  AddGroupViewController.swift
//  PlanB
//
//  Created by Klein Mioke on 5/17/16.
//  Copyright © 2016 Klein Mioke. All rights reserved.
//

import UIKit

class AddGroupViewController: UIViewController {
    
    var groups: [WorkGroup] = []
    
    var selectedRow: Int?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 64
        
        self.groups = CoreService.sharedInstance.groups
        self.tableView.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickBack(sender: AnyObject) {
        
        if self.selectedRow == nil {
            // warn user
            return
        }
        
        let id = self.groups[self.selectedRow!].id
        CoreService.sharedInstance.selectGroupID(id)
        
        let table = WorkGroupTable()
        for group in groups {
            table.replaceRecord(group)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func AddGroup(sender: AnyObject) {
        
        let id = Int(NSDate().timeIntervalSince1970)
        let group = WorkGroup(id: id, name: "")

//        WorkGroupTable().replaceRecord(group)
        self.groups.append(group)
        
        let index = NSIndexPath(forRow: groups.count - 1, inSection: 0)
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
        let cell = self.tableView.cellForRowAtIndexPath(index) as! GroupSelectTableViewCell
        
        cell.activeTextField()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddGroupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groups.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(GroupSelectTableViewCell.identifier) as? GroupSelectTableViewCell else {
            return UITableViewCell()
        }
        cell.groupNameTF.text = self.groups[indexPath.row].name
        cell.groupNameTF.delegate = self
        cell.groupNameTF.tag = indexPath.row
        
        if self.groups[indexPath.row].id == CoreService.sharedInstance.groupID {
            self.selectedRow = indexPath.row
            tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .None)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedRow = indexPath.row
    }
}

extension AddGroupViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        guard let newName = textField.text where newName.length > 0 else {
            self.groups.removeLast()
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Fade)
            return
        }
        let group = self.groups[textField.tag]
        group.name = newName
        self.groups[textField.tag] = group
    }
//    
//    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
//        guard let newName = textField.text where newName.length > 0 else {
//            self.groups.removeLast()
//            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
//            return true
//        }
//        let group = self.groups[textField.tag]
//        group.name = newName
//        self.groups[textField.tag] = group
//        
//        return true
//    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.userInteractionEnabled = false
        return true
    }
}


