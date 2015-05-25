//
//  ToDoListTableViewController.swift
//  TodoList
//
//  Created by Ming Gong on 5/25/15.
//  Copyright (c) 2015 gongmingqm10. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var toDoItems: [ToDoItem]! = [ToDoItem]()
    
    @IBOutlet weak var todoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadInitialData() {
        
        toDoItems.append(ToDoItem(itemName: "This is item 1"))
        toDoItems.append(ToDoItem(itemName: "This is item 2"))
        toDoItems.append(ToDoItem(itemName: "This is item 3"))
        toDoItems.append(ToDoItem(itemName: "This is item 4"))
        toDoItems.append(ToDoItem(itemName: "This is item 5"))
        toDoItems.append(ToDoItem(itemName: "This is item 6"))
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "todoCell")
        
        let item = toDoItems[indexPath.row]
        cell.textLabel!.text = item.itemName
        
        return cell
    }
    
    
}