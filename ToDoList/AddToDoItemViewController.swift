//
//  AddToDoItemViewController.swift
//  ToDoList
//
//  Created by Estelle Susanto on 12/1/16.
//  Copyright © 2016 Estelle Susanto. All rights reserved.
//

import UIKit

class AddToDoItemViewController: UIViewController {

    @IBOutlet var toDoTitle: UITextView!
    @IBOutlet var toDoDescription: UITextView!
    @IBOutlet var toDoDueDateAndTime: UIDatePicker!
    @IBOutlet var toDoPriority: UISegmentedControl!
    @IBOutlet var toDoCompleted: UISegmentedControl!
    @IBOutlet var toDoEvent: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     ---------------------------------
     MARK: - Keyboard Handling Methods
     ---------------------------------
     */
    
    // This method is invoked when the user taps the Done key on the keyboard
    @IBAction func keyboardDone(_ sender: UITextField) {
        
        // Once the text field is no longer the first responder, the keyboard is removed
        sender.resignFirstResponder()
    }
    
    @IBAction func backgroundTouch(_ sender: UIControl) {
        
        if(toDoTitle.isFirstResponder)
        {
            toDoTitle.resignFirstResponder()
        }
        else
        {
            toDoDescription.resignFirstResponder()
        }
    }

}
