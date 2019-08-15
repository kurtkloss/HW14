//
//  NamePersistance.swift
//  HW14
//
//  Created by Oleg Shashkov on 15/08/2019.
//  Copyright © 2019 citymed12. All rights reserved.
//

import Foundation
class NamePersistance{
    static let shared = NamePersistance()
    private let kUsernameKey = "NamePersistance.nameKey"
    private let kUserSurNameKey = "NamePersistance.surNameKey"
    var name: String?{
         set{UserDefaults.standard.set(newValue, forKey: "kUserNameKey")}
        get{return UserDefaults.standard.string(forKey:  "kUserNameKey")}
    }
    var surName:String?{
        set{UserDefaults.standard.set(newValue, forKey: "kUserSurNameKey")}
        get{return UserDefaults.standard.string(forKey:  "kUserSurNameKey")}
    }
}
