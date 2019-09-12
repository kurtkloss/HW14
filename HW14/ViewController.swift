//
//  ViewController.swift
//  HW14
//
//  Created by Oleg Shashkov on 15/08/2019.
//  Copyright © 2019 citymed12. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var surNameLabel: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButton.layer.borderWidth = 1
        sendButton.layer.cornerRadius = 10
        if let name = NamePersistance.shared.name, let surName = NamePersistance.shared.surName{
            nameLabel.text = name
            surNameLabel.text = surName
        }
    }
    
    @IBAction func sendButtonAction(_ sender: UIButton) {
        NamePersistance.shared.name = nameLabel.text
        NamePersistance.shared.surName = surNameLabel.text
        
    }
    
    
}



