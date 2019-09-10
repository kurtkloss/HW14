//
//  ToDoPopupRealmViewController.swift
//  HW14
//
//  Created by Oleg Shashkov on 15/08/2019.
//  Copyright © 2019 citymed12. All rights reserved.
//

import UIKit
protocol PopUpControllerDelegate{
    func addToDo(toDo:String)
}



class ToDoPopupRealmViewController: UIViewController {
    var delegate:PopUpControllerDelegate?
    @IBOutlet weak var toDoTextField: UITextField!
    @IBOutlet weak var toDoView: UIView!
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func saveButtonAction(_ sender: UIButton) {
        if let toDoText = toDoTextField.text{
        delegate?.addToDo(toDo: toDoText)
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
