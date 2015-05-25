//
//  ToDoItem.swift
//  TodoList
//
//  Created by Ming Gong on 5/25/15.
//  Copyright (c) 2015 gongmingqm10. All rights reserved.
//

import UIKit

class ToDoItem: NSObject {
    var itemName : String
    var completed : Bool = false
    private(set) var creationDate : NSDate
    
    init(itemName:String) {
        self.itemName = itemName
        creationDate = NSDate()
    }
}
