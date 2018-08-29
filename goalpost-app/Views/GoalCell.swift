//
//  GoalCell.swift
//  goalpost-app
//
//  Created by Mostafa Alaa on 8/14/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    @IBOutlet weak var completionView: UIView!
    
    func configCell(goal:Goal){
        self.goalDescLbl.text=goal.goalDescription!
        self.goalTypeLbl.text=goal.goalType
        self.goalProgressLbl.text=String(describing:goal.goalProgress)
        
        if goal.goalProgress == goal.goalTotalAmount{
            completionView.isHidden = false
        }else{
            completionView.isHidden = true
        }
        
    }
}
