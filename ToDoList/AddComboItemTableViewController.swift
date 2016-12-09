//
//  AddComboItemViewController.swift
//  LevelUp
//
//  Created by Estelle Susanto on 12/8/16.
//  Copyright © 2016 Estelle Susanto. All rights reserved.
//

import UIKit

class AddComboItemTableViewController: UITableViewController {
    
    var dataObjectPassed = [String]()

    @IBOutlet var toDoTableView: UITableView!
    
    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //---------- Create and Initialize the Arrays -----------------------
    var dict_ToDoList: NSMutableDictionary = NSMutableDictionary()
    var toDoNames = [String]()
    
    var comboNames = [String]()
    var dict_ComboList: NSMutableDictionary = NSMutableDictionary()

    
    // dataObjectToPass is the data object to pass to the downstream view controller
    var dataObjectToPass: [String] = ["", "", "", "", "", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let comboFilePath: NSString? = Bundle.main.path(forResource: "Combos", ofType: "plist") as NSString?
        
        // Instantiate an NSDictionary object and initialize it with the contents of the Automobiles.plist file.
        let dictionaryFromFile: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: comboFilePath! as String)
        
        if let dictionaryForCombosPlistFile = dictionaryFromFile {
            
            // Typecast the created dictionary of type NSDictionary as Dictionary type
            // and assign it to the class property named dict_AutoMakers_AutoModels
            dict_ComboList = dictionaryForCombosPlistFile
            
            /*
             allKeys returns a new array containing the dictionary’s keys as of type AnyObject.
             Therefore, typecast the AnyObject type keys to be of type String.
             The keys in the array are *unordered*; therefore, they need to be sorted.
             */
            comboNames = dictionaryForCombosPlistFile.allKeys as! [String]
            
            // Sort the auto manufacturer names within itself in alphabetical order
            comboNames.sort { $0 < $1 }
            
        }

        
        dict_ToDoList = applicationDelegate.dict_ToDoList
        
        toDoNames = applicationDelegate.dict_ToDoList.allKeys as! [String]
        toDoNames.sort { $0 < $1 }
        toDoTableView.reloadData()
        
        
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
        //cell.imageView!.image = UIImage(named: check)
        
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
    
    @IBAction func unwindToToDoTableViewController (segue : UIStoryboardSegue) {
        
        if segue.identifier == "AddComboItem-Save" {
            
//            //dataObjectToPass[0] - Parent
//            //dataObjectToPass[1] - Skill
//            dict_ToDoList.setValue(dataObjectToPass[1], forKey: dataObjectToPass[0])
//            
//            toDoNames = dict_ToDoList.allKeys as! [String]
//            
//            // Sort the country names within itself in alphabetical order
//            toDoNames.sort { $0 < $1 }
//            
//            // Reload the rows and sections of the Table View countryCityTableView
//            combosItemsTableView.reloadData()
            
            
            
        }
    }
    
    // MARK: - Navigation
    
    //--------------------------------
    // Selection of ToDoItem (row)
    //--------------------------------
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowNumber: Int = (indexPath as NSIndexPath).row    // Identify the row number
        
        // Obtain the country code of the row
        let toDoItem: String = toDoNames[rowNumber]
      
        
        dataObjectPassed[0] = toDoItem
        print(dataObjectPassed[0])
        
        dataObjectPassed[1] = comboNames[rowNumber]
        print(dataObjectPassed[1])

        
        
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
        dataObjectToPass[6] = toDoItemArray[5] as String
        
        
        
        performSegue(withIdentifier: "skillPreviewWhenAddingToCombo", sender: self)
        
        
        
        
        
        
        
        
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
        if segue.identifier == "skillPreviewWhenAddingToCombo" {
            
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
