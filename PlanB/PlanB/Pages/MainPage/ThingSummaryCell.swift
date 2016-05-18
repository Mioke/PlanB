//
//  ThingSummaryCell.swift
//  PlanB
//
//  Created by Klein Mioke on 5/17/16.
//  Copyright © 2016 Klein Mioke. All rights reserved.
//

import UIKit

class ThingSummaryCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    
    func setWithThing(thing: Thing) -> Void {
        self.title.text = thing.title
        self.setFinished(thing.isFinished)
    }
    
    func setFinished(finished: Bool) -> Void {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
