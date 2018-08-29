//
//  ViewController.swift
//  goalpost-app
//
//  Created by Mostafa Alaa on 8/14/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate
class GoalsVC: UIViewController {

    @IBOutlet weak var goalsTableView: UITableView!
    
    var goals:[Goal] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        goalsTableView.delegate = self
        goalsTableView.dataSource = self
        goalsTableView.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        goalsTableView.reloadData()
    }
    func fetchCoreDataObjects(){
        self.fetch { (complete) in
            if complete{
                
                if goals.count >= 1{
                    goalsTableView.isHidden = false
                    
                }else{
                    goalsTableView.isHidden = true
                }
                
            }
        }
    }
    
    @IBAction func addgoalPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "create") else{return }
        presentDetail(createGoalVC)
    }
}

extension GoalsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {
            return UITableViewCell()
        }
        let goal = goals[indexPath.row]
        cell.configCell(goal:goal)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.5662774449, blue: 0.2174327442, alpha: 1)
        return [deleteAction,addAction]
    }
    

    
    
}
extension GoalsVC{
    
    func setProgress(atIndexPath indexPath:IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        let selectedGoal = goals[indexPath.row]
        if selectedGoal.goalProgress < selectedGoal.goalTotalAmount{
            selectedGoal.goalProgress+=1
            do {
                try managedContext.save()
            }catch{
                debugPrint(error.localizedDescription)
            }
        }else{
            return
        }
    }
    
    func removeGoal(atIndexPath indexPath:IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        managedContext.delete(goals[indexPath.row])
        
        do{
            try managedContext.save()
        }catch{
            debugPrint(error.localizedDescription)
        }
    }
    
    func fetch(completion: (_ finished:Bool)-> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do{
            goals = try managedContext.fetch(fetchRequest)
            print("successfully fetched data")
            completion(true)
            
        }catch {
            debugPrint(error.localizedDescription)
            completion(false)
        }
    }
}

