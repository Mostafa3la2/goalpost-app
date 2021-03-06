//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Mostafa Alaa on 8/29/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTextfield: UITextField!
    
    
    var goalDescription:String!
    var goalType:GoalType!
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        pointsTextfield.delegate = self
    }

    func initData(description:String,type:GoalType){
        self.goalDescription = description
        self.goalType = type
    }
    @IBAction func createGoalPressed(_ sender: Any) {
        if pointsTextfield.text != nil{
            self.save { (complete) in
                if complete{
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        
        dismissDetail()
    }
    func save(completion: (_ finished:Bool)-> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{
            return
        }
        let goal = Goal(context: managedContext)
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalTotalAmount = Int32(pointsTextfield.text!)!
        goal.goalProgress = Int32(0)
        do{
        try managedContext.save()
            completion(true)
        }
        catch{
            debugPrint(error.localizedDescription)
            completion(false)
        }
    }
}
