//
//  ToDoRealmModel.swift
//  HW14
//
//  Created by Oleg Shashkov on 16/08/2019.
//  Copyright © 2019 citymed12. All rights reserved.
//

import Foundation
import RealmSwift

class ToDoR: Object{
    @objc dynamic var toDo = ""
    
}
class ToDoRModel{
    static let shared = ToDoRModel()
    private let realm = try! Realm()
    func saveToDoR(toDoItem: ToDoR){
        try! realm.write {
            realm.add(toDoItem)
        }
        
    }
    func getToDoR() -> [ToDoR]?{
         let allToDoR = realm.objects(ToDoR.self).toArray(ofType: ToDoR.self)
        return allToDoR
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T]? {
        let array = Array(self) as! [T]
        return array.count > 0 ? array  : nil
    }
}
