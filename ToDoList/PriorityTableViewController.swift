//
//  PriorityTableViewController.swift
//  ToDoList
//
//  Created by Estelle Susanto on 12/1/16.
//  Copyright © 2016 Estelle Susanto. All rights reserved.
//

import UIKit

class PriorityTableViewController: UITableViewController {

    @IBOutlet var priorityTableView: UITableView!
    
    
    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //---------- Create and Initialize the Arrays -----------------------
    var dict_ToDoList: NSMutableDictionary = NSMutableDictionary()
    var priorityTasks = [String]()
    
    // dataObjectToPass is the data object to pass to the downstream view controller
    var dataObjectToPass: [String] = ["", "", "", "", ""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dict_ToDoList = applicationDelegate.dict_ToDoList
        

        //-------------------------- SORT BY PRIORITY -----------------------------
        var highPriorityArray = [String]()
        var normalPriorityArray = [String]()
        var lowPriorityArray = [String]()

        for item in dict_ToDoList{
            let name = item.key
            let val = item.value as! [String]


            if(val[2] == "High"){
                highPriorityArray.append(name as! String)
            }
            else if(val[2] == "Normal"){
                normalPriorityArray.append(name as! String)
            }
            else if(val[2] == "Low"){
                lowPriorityArray.append(name as! String)
            }
        }

        highPriorityArray.sort{ $0 < $1}
        normalPriorityArray.sort{ $0 < $1}
        lowPriorityArray.sort{ $0 < $1}
        
        priorityTasks = highPriorityArray + normalPriorityArray + lowPriorityArray
        
        priorityTableView.reloadData()
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
        
        return priorityTasks.count
    }
    
    
    /*
     ------------------------------------
     Prepare and Return a Table View Cell
     ------------------------------------
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PriorityList", for: indexPath)
        let rowNumber: Int = (indexPath as NSIndexPath).row    // Identify the row number
        
        // Obtain the country code of the row
        let toDoName: String = priorityTasks[rowNumber]
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
        let toDoItem: String = priorityTasks[rowNumber]
        
        let toDoItemArray = dict_ToDoList[toDoItem] as! [String]
        
        dataObjectToPass[0] = toDoItem
        dataObjectToPass[1] = toDoItemArray[1] as String
        dataObjectToPass[2] = toDoItemArray[3] as String
        dataObjectToPass[3] = toDoItemArray[2] as String
        dataObjectToPass[4] = toDoItemArray[0] as String
        
        performSegue(withIdentifier: "showToDoItem", sender: self)
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
    }
}
