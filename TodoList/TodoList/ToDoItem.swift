//
//  ToDoItem.swift
//  TodoList
//
//  Created by Ming Gong on 5/25/15.
//  Copyright (c) 2015 gongmingqm10. All rights reserved.
//

import Foundation

class ToDoItem: NSObject {
    var itemName: String!
    var completed: Bool!
    var creationDate: NSDate!
    
    init(json: NSDictionary) {
        self.itemName = json["itemName"] as! String
        self.completed = json["completed"] as! Int == 1

        if let jsonDate = json["creationDate"] as? String {
            self.creationDate = ToDoItem.dateFormmater.dateFromString(jsonDate)
        } else {
            creationDate = NSDate()
        }
        
        super.init()
    }
    
    class var dateFormmater: NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:MM:SS"
        return formatter
    }
    
}
