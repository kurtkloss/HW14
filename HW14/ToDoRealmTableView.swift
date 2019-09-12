//
//  ToDoRealmTableView.swift
//  HW14
//
//  Created by Oleg Shashkov on 16/08/2019.
//  Copyright © 2019 citymed12. All rights reserved.
//

import UIKit

class ToDoRealmTableView: UITableViewController {
    var toDoList = ToDoRModel.shared.getToDoR()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = toDoList?.count ?? 0
        return count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let toDo = toDoList?[indexPath.row]{
            if  ToDoRModel.shared.changeState(toDoItem: toDo){
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
        //        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let toDo = toDoList?[indexPath.row]{
            cell.textLabel?.text = toDo.toDo
            if toDo.isCompleted {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
        }
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let toDo = toDoList?[indexPath.row]{
                ToDoRModel.shared.removeToDoR(toDo: toDo)
            }
            toDoList?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    @IBAction func pushAddAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "popUpContoller", sender: self)
        //
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ToDoPopupRealmViewController, segue.identifier == "popUpContoller"{
            vc.delegate = self
        }
    }
    
}
extension ToDoRealmTableView:PopUpControllerDelegate{
    func addToDo(toDo: String) {
        let newToDo = ToDoR()
        newToDo.toDo = toDo
        newToDo.isCompleted = false
        if toDoList == nil {
            toDoList = []
        }
        toDoList?.append(newToDo)
        ToDoRModel.shared.saveToDoR(toDoItem: newToDo)
        tableView.reloadData()
        
    }
    
    
}
