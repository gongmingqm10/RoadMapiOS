//
//  ToDoListTableViewController.swift
//  TodoList
//
//  Created by Ming Gong on 5/25/15.
//  Copyright (c) 2015 gongmingqm10. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var toDoItems: [ToDoItem]!

    @IBOutlet weak var toDoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoItems = DatabaseAccessor.sharedInstance.getTodoItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        var item = (segue.sourceViewController as! AddToDoItemViewController).toDoItem
        if let toDoItem = item {
            toDoItems.append(toDoItem)
            DatabaseAccessor.sharedInstance.updateTodoItem(toDoItem)
            toDoTableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "todoCell")
        
        let item = toDoItems[indexPath.row]
        cell.textLabel!.text = item.itemName
        
        if item.completed != nil && item.completed == true {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var toDoItem = toDoItems[indexPath.row]
        toDoItem.completed = !toDoItem.completed
        DatabaseAccessor.sharedInstance.updateTodoItem(toDoItem)
        toDoTableView.reloadData()
    }
    
    
}
