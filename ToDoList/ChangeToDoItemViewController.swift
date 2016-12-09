//
//  ChangeToDoItemViewController.swift
//  ToDoList
//
//  Created by Estelle Susanto on 12/1/16.
//  Copyright © 2016 Estelle Susanto. All rights reserved.
//

import UIKit

class ChangeToDoItemViewController: UIViewController {

    var dataObjectPassed = [String]()
    
    @IBOutlet var toDoTitle: UITextView!
    @IBOutlet var toDoDescription: UITextView!
    @IBOutlet var toDoDueDateAndTime: UIDatePicker!
    @IBOutlet var toDoPriority: UISegmentedControl!
    @IBOutlet var toDoCompleted: UISegmentedControl!
    @IBOutlet var toDoEvent: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        toDoTitle.text = dataObjectPassed[0]
        toDoDescription.text = dataObjectPassed[1]
        
        //---------------------------------------------------------
        // Set Date Picker to show the To-Do Item Due Date and Time
        //---------------------------------------------------------
        
        // Create a Date Formatter object
        let dateFormatter = DateFormatter()
        
        // Set the date and time format
        dateFormatter.dateFormat = "yyyy-MM-dd 'at' HH:mm"
        
        // Convert date and time from String type to Date object type
        let dateAndTime = dateFormatter.date(from: dataObjectPassed[2])
        
        // Set Date Picker to show the date and time
        toDoDueDateAndTime.setDate(dateAndTime!, animated: true)
        
        let toDoPrioritySegment = dataObjectPassed[3]
        switch toDoPrioritySegment {
        case "Low":
            toDoPriority.selectedSegmentIndex = 0
        case "Normal":
            toDoPriority.selectedSegmentIndex = 1
        case "High":
            toDoPriority.selectedSegmentIndex = 2
        default:
            print("Invalid Priority")
        }
        
        let toDoCompletedSegment = dataObjectPassed[4]
        switch toDoCompletedSegment {
            
        case "YES":
            toDoCompleted.selectedSegmentIndex = 0
        case "NO":
            toDoCompleted.selectedSegmentIndex = 1
        default:
            print("Invalid Completion")
        }
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
