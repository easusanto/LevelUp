//
//  ComboItemsTableViewController.swift
//  LevelUp
//
//  Created by Estelle Susanto on 12/8/16.
//  Copyright © 2016 Estelle Susanto. All rights reserved.
//

import UIKit

class ComboItemsTableViewController: UITableViewController {
    
    var dataObjectPassed = [String]()

    
    @IBOutlet var combosItemsTableView: UITableView!
    
    // Obtain the object reference to the App Delegate object
    //    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //---------- Create and Initialize the Arrays -----------------------
    var dict_ComboList: NSMutableDictionary = NSMutableDictionary()
    var dict_SkillsList:NSMutableDictionary = NSMutableDictionary()
    var comboNames = [String]()
    var skills = [String]()
    
    // dataObjectToPass is the data object to pass to the downstream view controller
    var dataObjectToPass: [String] = ["", "", "", "", "", "", ""]
    var comboItems = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up an Add button in the navigation bar
        let addButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(CombosTableViewController.addComboSkillsItem(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        
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
        
        let skillsFilePath: NSString? = Bundle.main.path(forResource: "Skills", ofType: "plist") as NSString?
        
        // Instantiate an NSDictionary object and initialize it with the contents of the Automobiles.plist file.
        let skillsDictionaryFromFile: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: skillsFilePath! as String)
        
        if let skillsDictionaryPlistFile = skillsDictionaryFromFile {
            
            // Typecast the created dictionary of type NSDictionary as Dictionary type
            // and assign it to the class property named dict_AutoMakers_AutoModels
            dict_SkillsList = skillsDictionaryPlistFile
            
            /*
             allKeys returns a new array containing the dictionary’s keys as of type AnyObject.
             Therefore, typecast the AnyObject type keys to be of type String.
             The keys in the array are *unordered*; therefore, they need to be sorted.
             */
            skills = skillsDictionaryPlistFile.allKeys as! [String]
            
            // Sort the auto manufacturer names within itself in alphabetical order
            skills.sort { $0 < $1 }
            
        }
        var i = 0;
        for _ in dataObjectPassed {
            if(dataObjectPassed[i] != ""){
                comboItems.append(dataObjectPassed[i])
                i += 1;
            }
        }
        combosItemsTableView.reloadData()
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
        
        return comboItems.count
    }
    
    
    /*
     -----------------------------
     MARK: - Add Movie Method
     -----------------------------
     */
    // The addCity method is invoked when the user taps the Add button created in viewDidLoad() above.
    func addToDo(_ sender: AnyObject) {
        // Perform the segue named AddCity
        performSegue(withIdentifier: "addComboItem", sender: self)
    }
    
    

    /*
     ------------------------------------
     Prepare and Return a Table View Cell
     ------------------------------------
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComboSkillsList", for: indexPath)
        let rowNumber: Int = (indexPath as NSIndexPath).row    // Identify the row number
        
        // Obtain the country code of the row
        let comboItemName: String = comboItems[rowNumber]
        cell.textLabel!.text = comboItemName as? String
        
        return cell
    }
    
    // MARK: - Navigation
    
    //--------------------------------
    // Selection of ToDoItem (row)
    //--------------------------------
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowNumber: Int = (indexPath as NSIndexPath).row    // Identify the row number
        
        // Obtain the country code of the row
        let comboItem: String = comboNames[rowNumber]
        
        dataObjectPassed[0] = comboItem
        
        dataObjectPassed[1] = comboItems[rowNumber]
        print(comboItem)
        
//        
//        performSegue(withIdentifier: "skillPreviewWhenAddingToCombo", sender: self)
    }
    
    
    //--------------------------------
    // Detail Disclosure Button Tapped
    //--------------------------------
    
    // This is the method invoked when the user taps the Detail Disclosure button (circle icon with i)
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let rowNumber: Int = (indexPath as NSIndexPath).row    // Identify the row number
        
        // Obtain the country code of the row
        let comboItem: String = comboItems[rowNumber]
        print(comboItem);
        var comboItemArray = [String]()
        
        for combo in comboNames {
            let comboItems = dict_ComboList[combo] as! [String]
            for item in comboItems{
                if(item == comboItem){
                    comboItemArray = dict_SkillsList[comboItem] as! [String]
                    print(comboItemArray);
                }
            }
        }
        
        print(dataObjectToPass);
        
        dataObjectToPass[0] = comboItem
        dataObjectToPass[1] = comboItemArray[1] as String
        dataObjectToPass[2] = comboItemArray[3] as String
        dataObjectToPass[3] = comboItemArray[2] as String
        dataObjectToPass[4] = comboItemArray[0] as String
        dataObjectToPass[5] = comboItemArray[4] as String
        dataObjectToPass[6] = comboItemArray[5] as String
        
        performSegue(withIdentifier: "showComboItem", sender: self)

    }

    
    /*
     -------------------------
     MARK: - Prepare for Segue
     -------------------------
     */
    // This method is called by the system whenever you invoke the method performSegueWithIdentifier:sender:
    // You never call this method. It is invoked by the system.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showComboItem" {
            
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
