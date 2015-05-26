//
//  AddToDoItemViewController.swift
//  TodoList
//
//  Created by Ming Gong on 5/25/15.
//  Copyright (c) 2015 gongmingqm10. All rights reserved.
//

import UIKit

class AddToDoItemViewController: UIViewController {
    
    @IBOutlet weak var toDoTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var toDoItem: ToDoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender as? UIBarButtonItem != self.saveButton || toDoTextField.text.isEmpty{
            return
        }
        
        self.toDoItem = ToDoItem(json: ["itemName": toDoTextField.text, "completed": 0])
    }
    
}



