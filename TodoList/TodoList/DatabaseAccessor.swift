//
//  DatabaseAccessor.swift
//  TodoList
//
//  Created by Ming Gong on 5/26/15.
//  Copyright (c) 2015 gongmingqm10. All rights reserved.
//

import Foundation

class DatabaseAccessor: NSObject {
    private var database: FMDatabase
    
    init(path: String) {
        database = FMDatabase(path: path)
        database.open()
        super.init()
        createTablesIfNotExist()
    }
    
    private func createTablesIfNotExist() {
        let createToDoItemTable = "CREATE TABLE IF NOT EXISTS todoitems (itemName TEXT, completed INTEGER, creationDate TEXT, PRIMARY KEY(itemName, creationDate));"
        self.database.executeStatements(createToDoItemTable)
    }
    
    dynamic class var sharedInstance: DatabaseAccessor {
        return databaseAccessor
    }
    
    func updateTodoItem(todoItem: ToDoItem) {
        let updatedTodoItemSQL = "INSERT OR REPLACE INTO todoitems (itemName, completed, creationDate) VALUES (?, ?, ?);"

        let creationDateString = ToDoItem.dateFormmater.stringFromDate(todoItem.creationDate)
        
        self.database.executeUpdate(updatedTodoItemSQL, withArgumentsInArray: [todoItem.itemName, todoItem.completed, creationDateString])
    }
    
    func getTodoItems() -> [ToDoItem] {
        let selectTodoItemsSQL = "SELECT itemName, completed, creationDate from todoitems"
        var todoItems = [ToDoItem]()
        if let resultSet = self.database.executeQuery(selectTodoItemsSQL, withArgumentsInArray: []) {
            while resultSet.next() {
                let resultDictionary = resultSet.resultDictionary()
                todoItems.append(ToDoItem(json: resultDictionary))
            }
        }
        return todoItems
    }
    
}

private let databaseAccessor: DatabaseAccessor = {
    let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
    let path = documentsDirectory.stringByAppendingPathComponent("TodoList.sqlite")
    return DatabaseAccessor(path: path)
}()
