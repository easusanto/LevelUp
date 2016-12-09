//
//  ToDoTableViewController.swift
//  LevelUp
//
//  Created by Estelle Susanto on 12/1/16.
//  Copyright © 2016 Estelle Susanto. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    @IBOutlet var toDoTableView: UITableView!
    
    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //---------- Create and Initialize the Arrays -----------------------
    var dict_ToDoList: NSMutableDictionary = NSMutableDictionary()
    var toDoNames = [String]()
    
    // dataObjectToPass is the data object to pass to the downstream view controller
    var dataObjectToPass: [String] = ["", "", "", "", "", "", ""]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        // Set up an Add button in the navigation bar
        let addButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ToDoTableViewController.addToDo(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        dict_ToDoList = applicationDelegate.dict_ToDoList
        
        toDoNames = applicationDelegate.dict_ToDoList.allKeys as! [String]
        toDoNames.sort { $0 < $1 }
        toDoTableView.reloadData()
    }
    
    
    
    /*
     -----------------------------
     MARK: - Add Movie Method
     -----------------------------
     */
    // The addCity method is invoked when the user taps the Add button created in viewDidLoad() above.
    func addToDo(_ sender: AnyObject) {
        // Perform the segue named AddCity
        performSegue(withIdentifier: "addToDoItem", sender: self)
    }
    
    /*
     ----------------------------------------------
     MARK: - Unwind Segue Method
     ----------------------------------------------
     */
    @IBAction func unwindToToDoTableViewController (segue : UIStoryboardSegue) {
        
        if segue.identifier == "ChangeToDoItem-Save" {
            
            // Obtain the object reference of the source view controller
            let controller: ChangeToDoItemViewController = segue.source as! ChangeToDoItemViewController
            
            let toDoTask: String = controller.toDoTitle.text!
            let toDoTaskDescription: String = controller.toDoDescription.text!
            // Get the movie genre entered by the user on the AddMovieViewController UI
            //--------------------------------------------
            // Create the New To Do Item Due Date and Time
            //--------------------------------------------
            
            // Create a Date Formatter object
            let dateFormatter = DateFormatter()
            
            // Set the date and time format
            dateFormatter.dateFormat = "yyyy-MM-dd 'at' HH:mm"
            
            // Obtain the date and time from the controller
            let dateAndTime = controller.toDoDueDateAndTime.date
            
            // Set the date and time according to the defined format
            let newToDoItemDateAndTime = dateFormatter.string(from: dateAndTime)
            
            let toDoTaskPriority: Int = controller.toDoPriority.selectedSegmentIndex
            let toDoTaskCompleted: Int = controller.toDoCompleted.selectedSegmentIndex
            
            var taskPriority: String = ""
            var taskCompleted: String = ""
            
            switch toDoTaskPriority {
            case 0: taskPriority = "Low"
            case 1: taskPriority = "Normal"
            case 2: taskPriority = "High"
            default:
                print("Invalid Task Priority Selected")
            }
            
            switch toDoTaskCompleted {
            case 0: taskCompleted = "YES"
            case 1: taskCompleted = "NO"
            default:
                print("Invalid Task Completed Selected")
            }
            
            let toDoEvent: Int = controller.toDoEvent.selectedSegmentIndex
            var taskEvent: String = ""


            switch toDoEvent {
            case 0: taskEvent = "Vault"
            case 1: taskEvent = "Bars"
            case 2: taskEvent = "Beam"
            case 3: taskEvent = "Floor"
            default:
                print("Invalid Event Selected")
            }
            
            if (toDoTask == "" || toDoTaskDescription == "" || newToDoItemDateAndTime == "" || taskPriority == "" || taskCompleted == "") {
                let alertController = UIAlertController(title: "Must Fill all Fields",
                                                        message: "All text fields must have input",
                                                        preferredStyle: UIAlertControllerStyle.alert)
                
                // Create a UIAlertAction object and add it to the alert controller
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                // Present the alert controller by calling the presentViewController method
                self.present(alertController, animated: true, completion: nil)
                
                
            } else {
                applicationDelegate.dict_ToDoList.removeObject(forKey: dataObjectToPass[0])
                
                let updatedTask: [String] = [taskCompleted,toDoTaskDescription,taskPriority,newToDoItemDateAndTime]
                
                applicationDelegate.dict_ToDoList.setValue(updatedTask, forKey: toDoTask)
                
                toDoNames = applicationDelegate.dict_ToDoList.allKeys as! [String]
                
                // Sort the country names within itself in alphabetical order
                toDoNames.sort { $0 < $1 }
                
                // Reload the rows and sections of the Table View countryCityTableView
                toDoTableView.reloadData()
            }
        }
        if segue.identifier == "AddToDoItem-Save" {
            // Obtain the object reference of the source view controller
            let controller: AddToDoItemViewController = segue.source as! AddToDoItemViewController
            
            let toDoTask: String = controller.toDoTitle.text!
            let toDoTaskDescription: String = controller.toDoDescription.text!
            // Get the movie genre entered by the user on the AddMovieViewController UI
            //--------------------------------------------
            // Create the New To Do Item Due Date and Time
            //--------------------------------------------
            
            // Create a Date Formatter object
            let dateFormatter = DateFormatter()
            
            // Set the date and time format
            dateFormatter.dateFormat = "yyyy-MM-dd 'at' HH:mm"
            
            // Obtain the date and time from the controller
            let dateAndTime = controller.toDoDueDateAndTime.date
            
            // Set the date and time according to the defined format
            let newToDoItemDateAndTime = dateFormatter.string(from: dateAndTime)
            
            let toDoTaskPriority: Int = controller.toDoPriority.selectedSegmentIndex
            let toDoTaskCompleted: Int = controller.toDoCompleted.selectedSegmentIndex
            
            var taskPriority: String = ""
            var taskCompleted: String = ""
            
            switch toDoTaskPriority {
            case 0: taskPriority = "Low"
            case 1: taskPriority = "Normal"
            case 2: taskPriority = "High"
            default:
                print("Invalid Task Priority Selected")
            }
            
            switch toDoTaskCompleted {
            case 0: taskCompleted = "YES"
            case 1: taskCompleted = "NO"
            default:
                print("Invalid Task Completed Selected")
            }
            
            let toDoEvent: Int = controller.toDoEvent.selectedSegmentIndex
            var taskEvent: String = ""

            switch toDoEvent {
            case 0: taskEvent = "Vault"
            case 1: taskEvent = "Bars"
            case 2: taskEvent = "Beam"
            case 3: taskEvent = "Floor"
            default:
                print("Invalid Event Selected")
            }
            
            
            if (toDoTask == "" || toDoTaskDescription == "" || newToDoItemDateAndTime == "" || taskPriority == "" || taskCompleted == "" || taskEvent == "") {
                let alertController = UIAlertController(title: "Must Fill all Fields",
                                                        message: "All text fields must have input",
                                                        preferredStyle: UIAlertControllerStyle.alert)
                
                // Create a UIAlertAction object and add it to the alert controller
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                // Present the alert controller by calling the presentViewController method
                self.present(alertController, animated: true, completion: nil)
                
                
            } else {
                let updatedTask: [String] = [taskCompleted,toDoTaskDescription,taskPriority,newToDoItemDateAndTime, taskEvent]
                
                applicationDelegate.dict_ToDoList.setValue(updatedTask, forKey: toDoTask)
                
                toDoNames = applicationDelegate.dict_ToDoList.allKeys as! [String]
                
                // Sort the country names within itself in alphabetical order
                toDoNames.sort { $0 < $1 }
                
                // Reload the rows and sections of the Table View countryCityTableView
                toDoTableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    // Asks the data source to return the number of sections in the table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Asks the data source to return the number of rows in a section, the number of which is given
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDoNames.count
    }

    
    /*
     ------------------------------------
     Prepare and Return a Table View Cell
     ------------------------------------
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoList", for: indexPath)
        let rowNumber: Int = (indexPath as NSIndexPath).row    // Identify the row number
        
        // Obtain the country code of the row
        let toDoName: String = toDoNames[rowNumber]
        let toDoDataArray = dict_ToDoList[toDoName] as! [String]
        
        cell.textLabel!.text = toDoName as? String
        cell.detailTextLabel!.text = toDoDataArray[3] as? String
        
        let checked = toDoDataArray[0] as? String
        var check: String = ""
        if (checked == "YES") {
            check = "CheckedBox"
        } else {
            check = "CheckBox"
        }
        cell.imageView!.image = UIImage(named: check)
        
        let priorityLevel = toDoDataArray[2] as! String
        switch priorityLevel {
            case "High":
                cell.textLabel?.textColor = UIColor.red
                cell.detailTextLabel?.textColor = UIColor.red
            case "Normal":
                cell.textLabel?.textColor = UIColor.brown
                cell.detailTextLabel?.textColor = UIColor.brown
            case "Low":
                cell.textLabel?.textColor = UIColor.black
                cell.detailTextLabel?.textColor = UIColor.black
            default:
                print("Invalid Priority Color")
        }
        
        return cell
    }
    
    // MARK: - Navigation
    
    //--------------------------------
    // Selection of ToDoItem (row)
    //--------------------------------
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowNumber: Int = (indexPath as NSIndexPath).row    // Identify the row number
        
        // Obtain the country code of the row
        let toDoItem: String = toDoNames[rowNumber]
        
        let toDoItemArray = dict_ToDoList[toDoItem] as! [String]
        
        
        dataObjectToPass[0] = toDoItem
        dataObjectToPass[1] = toDoItemArray[1] as String
        dataObjectToPass[2] = toDoItemArray[3] as String
        dataObjectToPass[3] = toDoItemArray[2] as String
        dataObjectToPass[4] = toDoItemArray[0] as String
        dataObjectToPass[5] = toDoItemArray[4] as String
        dataObjectToPass[6] = toDoItemArray[5] as String
        
        
        
        performSegue(withIdentifier: "showToDoItem", sender: self)
    }
    
    //--------------------------------
    // Detail Disclosure Button Tapped
    //--------------------------------
    
    // This is the method invoked when the user taps the Detail Disclosure button (circle icon with i)
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let rowNumber: Int = (indexPath as NSIndexPath).row    // Identify the row number
        
        // Obtain the country code of the row
        let toDoItem: String = toDoNames[rowNumber]
        
        let toDoItemArray = dict_ToDoList[toDoItem] as! [String]
        
        dataObjectToPass[0] = toDoItem
        dataObjectToPass[1] = toDoItemArray[1] as String
        dataObjectToPass[2] = toDoItemArray[3] as String
        dataObjectToPass[3] = toDoItemArray[2] as String
        dataObjectToPass[4] = toDoItemArray[0] as String
        dataObjectToPass[5] = toDoItemArray[4] as String
        
        performSegue(withIdentifier: "changeToDoItem", sender: self)
    }
    
    
    //---------------------------
    // Delete Rows
    //---------------------------
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let taskToDelete = toDoNames[(indexPath as NSIndexPath).row]
            
            applicationDelegate.dict_ToDoList.removeObject(forKey: taskToDelete)
            
            toDoNames = applicationDelegate.dict_ToDoList.allKeys as! [String]
            
            // Sort the country names within itself in alphabetical order
            toDoNames.sort { $0 < $1 }
            
            // Reload the rows and sections of the Table View countryCityTableView
            toDoTableView.reloadData()
            
        }
    }

    /*
     -------------------------
     MARK: - Prepare for Segue
     -------------------------
     */
    // This method is called by the system whenever you invoke the method performSegueWithIdentifier:sender:
    // You never call this method. It is invoked by the system.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showToDoItem" {
            
            // Obtain the object reference of the destination (downstream) view controller
            let toDoItemViewController: ToDoItemViewController = segue.destination as! ToDoItemViewController
            
            /*
             This view controller creates the dataObjectToPass and passes it (by value) to the downstream view controller
             MovieTrailerViewController by copying its content into MovieTrailerViewController property dataObjectPassed.
             */
            toDoItemViewController.dataObjectPassed = dataObjectToPass
            
        }
        if segue.identifier == "changeToDoItem" {
            
            // Obtain the object reference of the destination (downstream) view controller
            let changeToDoItemViewController: ChangeToDoItemViewController = segue.destination as! ChangeToDoItemViewController
            
            /*
             This view controller creates the dataObjectToPass and passes it (by value) to the downstream view controller
             MovieTrailerViewController by copying its content into MovieTrailerViewController property dataObjectPassed.
             */
            changeToDoItemViewController.dataObjectPassed = dataObjectToPass
            
        }
    }


}
