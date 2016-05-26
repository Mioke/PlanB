//
//  ThingInfoViewController.swift
//  PlanB
//
//  Created by Klein Mioke on 5/18/16.
//  Copyright © 2016 Klein Mioke. All rights reserved.
//

import UIKit

class ThingInfoViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var planTextField: UITextField!
    @IBOutlet weak var beginDateLabel: UILabel!
    
    @IBOutlet weak var remarkTextView: UITextView!
    @IBOutlet weak var remarkHeight: NSLayoutConstraint!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var failedButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    var thing: Thing?
    var isNew: Bool = false
    
    @IBOutlet weak var finishedViewHeight: NSLayoutConstraint!
    @IBOutlet weak var finishedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if self.isNew {
            self.title = "New"
        } else {
            self.addButton.removeFromSuperview()
            
            guard let th = self.thing else {
                assert(false, "Thing couldn't be nil")
                return
            }
            if th.isFinished {
                self.failedButton.setTitle("Reopen", forState: .Normal)
                
                var str = "This matter is "
                if th.isSuccess {
                    str += "finished on \(th.finishedDate!.stringWithFormat("yyyy-MM-dd"))"
                } else {
                    str += "failed on \(th.finishedDate!.stringWithFormat("yyyy-MM-dd"))"
                }
                self.finishedLabel.text = str
                
                self.finishButton.enabled = false
                self.finishButton.backgroundColor = UIColor.lightGrayColor()
            } else {
                self.finishedViewHeight.constant = 0
            }
        }
        
        self.titleTextField.text = thing?.title
        self.planTextField.text = "\(thing?.needDays)"
        self.beginDateLabel.text = thing?.beginDate.description
        self.remarkTextView.text = thing?.remark
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickDeleteButton(sender: AnyObject) {
        
        let condition = DatabaseCommandCondition()
        condition.whereConditions = "create_time = \(Int(thing!.createDate))"
        ThingTable().deleteRecordWithCondition(condition)
        
        CoreService.sharedInstance.shouldReload = true
    }

    @IBAction func clickFinishButton(sender: AnyObject) {
        
        self.thing?.isFinished = true
        self.thing?.isSuccess = true
        ThingTable().replaceRecord(self.thing!)
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func clickFailedButton(sender: AnyObject) {
        
        if self.thing!.isFinished {
            self.thing?.isFinished = false
        } else {
            self.thing?.isFinished = true
        }
        ThingTable().replaceRecord(self.thing!)
        
        self.navigationController?.popViewControllerAnimated(true)

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
