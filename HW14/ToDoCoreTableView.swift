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

    var toDoList:[ToDoCore] = []
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest :NSFetchRequest<ToDoCore> = ToDoCore.fetchRequest()
        do{
            toDoList = try context.fetch(fetchRequest)
        } catch{
            print(error.localizedDescription)
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         return toDoList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let toDo = toDoList[indexPath.row]
//            if  ToDoRModel.shared.changeState(toDoItem: toDo){
//                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//            }else {
//                tableView.cellForRow(at: indexPath)?.accessoryType = .none
//            }
        //}
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
//            if let toDo = toDoList?[indexPath.row]{
//                ToDoRModel.shared.removeToDoR(toDo: toDo)
            //}
            toDoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
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