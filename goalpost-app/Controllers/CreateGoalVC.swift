//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by Mostafa Alaa on 8/28/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var goalTextview: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    var goalType:GoalType = .shortTerm
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindToKeyboard()
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselctedColor()
        goalTextview.delegate = self
    }

    @IBAction func shortTermPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselctedColor()
    }
    
    @IBAction func longTermPressed(_ sender: Any) {
        goalType = .longTerm
        longTermBtn.setSelectedColor()
        shortTermBtn.setDeselctedColor()
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        if goalTextview.text != "" && goalTextview.text != "What is your goal?"{
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "finishGoal") as? FinishGoalVC else{return}
            finishGoalVC.initData(description: goalTextview.text!, type: goalType)
            presentingViewController?.presentSecondaryDetail(finishGoalVC)
        }
        
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    func textViewDidBeginEditing(_ textView : UITextView) {
        goalTextview.text = ""
        goalTextview.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
}
