//
//  ToDoCoreTableView.swift
//  HW14
//
//  Created by Oleg Shashkov on 11/09/2019.
//  Copyright © 2019 citymed12. All rights reserved.
//

import UIKit
import CoreData

class ToDoCoreTableView: UITableViewController {
    
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var toDoList:[ToDoCore] = []
    
    override func viewWillAppear(_ animated: Bool) {
        let fetchRequest :NSFetchRequest<ToDoCore> = ToDoCore.fetchRequest()
        do{
            toDoList = try context.fetch(fetchRequest)
        } catch{
            print(error.localizedDescription)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDoList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let toDo = toDoList[indexPath.row]
        toDo.isCompleted = !toDo.isCompleted
        do{
            try context.save()
            if  toDo.isCompleted {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }
            
            
        } catch{
            print(error.localizedDescription)
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        //        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let toDo = toDoList[indexPath.row]
        cell.textLabel?.text = toDo.toDo
        if toDo.isCompleted {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let  toDo = toDoList[indexPath.row]
            context.delete(toDo)
            do{
                try context.save()
                toDoList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch{
                print(error.localizedDescription)
            }
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    
    
    
    @IBAction func pushAddAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "popUpCore", sender: self)
        //
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ToDoPopupRealmViewController, segue.identifier == "popUpCore"{
            vc.delegate = self
        }
    }
    
}
extension ToDoCoreTableView:PopUpControllerDelegate{
    func addToDo(toDo: String) {
        let entity = NSEntityDescription.entity(forEntityName: "ToDoCore", in: context)
        let newToDoObject = NSManagedObject(entity: entity!, insertInto: context) as! ToDoCore
        newToDoObject.toDo = toDo
        newToDoObject.isCompleted = false
        do{
            try context.save()
            toDoList.append(newToDoObject)
            print("context saved")
        } catch {
            print(error.localizedDescription)
        }
        tableView.reloadData()
        
    }
    
    
}
