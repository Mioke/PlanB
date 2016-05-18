//
//  GroupSelectTableViewCell.swift
//  PlanB
//
//  Created by Klein Mioke on 5/17/16.
//  Copyright © 2016 Klein Mioke. All rights reserved.
//

import UIKit

class GroupSelectTableViewCell: UITableViewCell {
    
    static let identifier: String = "kGroupSelectCell"

    @IBOutlet weak var groupNameTF: UITextField!
    @IBOutlet weak var checkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let attr = [
            NSFontAttributeName: UI.defaultFontWithSize(18),
            NSForegroundColorAttributeName: UIColor.grayColor()
        ]
        self.groupNameTF.attributedPlaceholder = NSAttributedString(string: "Name a Group", attributes: attr)
        
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(GroupSelectTableViewCell.activeTextField)))
    }
    
    func activeTextField() -> Void {
        self.groupNameTF.userInteractionEnabled = true
        if self.groupNameTF.canBecomeFirstResponder() {
            self.groupNameTF.becomeFirstResponder()
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            self.checkImageView.backgroundColor = UIColor.whiteColor()
        } else {
            self.checkImageView.backgroundColor = UIColor.clearColor()
        }
    }

}
