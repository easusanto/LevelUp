//
//  CombosTableViewController.swift
//  LevelUp
//
//  Created by Estelle Susanto on 12/8/16.
//  Copyright © 2016 Estelle Susanto. All rights reserved.
//

import UIKit

class CombosTableViewController: UITableViewController {

    @IBOutlet var combosTableView: UITableView!
    
    // Obtain the object reference to the App Delegate object
//    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //---------- Create and Initialize the Arrays -----------------------
    var dict_ComboList: NSMutableDictionary = NSMutableDictionary()
    var comboNames = [String]()
    
    // dataObjectToPass is the data object to pass to the downstream view controller
    var dataObjectToPass: [String] = ["", "", "", "", "", "", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
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
        
        combosTableView.reloadData()
    }
    
    
    

    func addComboSkillsItem(_ sender: AnyObject) {
        // Perform the segue named AddCity
        performSegue(withIdentifier: "addCombo", sender: self)
    }
    
    
    @IBAction func unwindToCombosTableViewController (segue : UIStoryboardSegue) {
        
        if segue.identifier == "ChangeComboSkillsItem-Save" {
            
            // Obtain the object reference of the source view controller
            let controller: ChangeComboViewController = segue.source as! ChangeComboViewController
            
            let comboName: String = controller.comboName.text!
            
            
            if (comboName == "") {
                let alertController = UIAlertController(title: "Must Fill all Fields",
                                                        message: "All text fields must have input",
                                                        preferredStyle: UIAlertControllerStyle.alert)
                
                // Create a UIAlertAction object and add it to the alert controller
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                // Present the alert controller by calling the presentViewController method
                self.present(alertController, animated: true, completion: nil)
                
                
            } else {
                dict_ComboList.removeObject(forKey: comboName)
                
                //create empty String Array list for new combo name
                let updatedComboList: [String] = []
                
                dict_ComboList.setValue(updatedComboList, forKey: comboName)
                
                comboNames = dict_ComboList.allKeys as! [String]
                
                // Sort the country names within itself in alphabetical order
                comboNames.sort { $0 < $1 }
                
                // Reload the rows and sections of the Table View countryCityTableView
                combosTableView.reloadData()
            }
        }
        if segue.identifier == "AddComboSkillsItem-Save" {
            // Obtain the object reference of the source view controller
            let controller: AddComboViewController = segue.source as! AddComboViewController
            
            let comboName: String = controller.comboName.text!
            
            
            if (comboName == "") {
                let alertController = UIAlertController(title: "Must Fill all Fields",
                                                        message: "All text fields must have input",
                                                        preferredStyle: UIAlertControllerStyle.alert)
                
                // Create a UIAlertAction object and add it to the alert controller
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                // Present the alert controller by calling the presentViewController method
                self.present(alertController, animated: true, completion: nil)
                
                
            } else {
                dict_ComboList.removeObject(forKey: comboName)
                
                //create empty String Array list for new combo name
                let updatedComboList: [String] = []
                
                dict_ComboList.setValue(updatedComboList, forKey: comboName)
                
                comboNames = dict_ComboList.allKeys as! [String]
                
                // Sort the country names within itself in alphabetical order
                comboNames.sort { $0 < $1 }
                
                // Reload the rows and sections of the Table View countryCityTableView
                combosTableView.reloadData()            }
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
        
        return comboNames.count
    }
    
    
    /*
     ------------------------------------
     Prepare and Return a Table View Cell
     ------------------------------------
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComboList", for: indexPath)
        let rowNumber: Int = (indexPath as NSIndexPath).row    // Identify the row number
        
        let comboName: String = comboNames[rowNumber]        
        cell.textLabel!.text = comboName as? String
        
        return cell
    }
    
    // MARK: - Navigation
    
    //--------------------------------
    // Selection of ToDoItem (row)
    //--------------------------------
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowNumber: Int = (indexPath as NSIndexPath).row    // Identify the row number
        
        // Obtain the country code of the row
        let clickedCombo: String = comboNames[rowNumber]
        
        
        var items = [String]()
        
        for item in dict_ComboList{
            let name = item.key as! String
            
            if(name == clickedCombo){
                let val = item.value as! [String]
                
                var j = 0;
                for _ in val {
                    items.append(val[j])
                    j += 1;
                }
            }
        }
        var i = 0;
        for item in items{
            dataObjectToPass[i] = item as String
            i += 1;
        }
        print(dataObjectToPass)
        
        performSegue(withIdentifier: "showComboItems", sender: self)

    }
    
    //--------------------------------
    // Detail Disclosure Button Tapped
    //--------------------------------
    
    // This is the method invoked when the user taps the Detail Disclosure button (circle icon with i)
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let rowNumber: Int = (indexPath as NSIndexPath).row    // Identify the row number
        
        performSegue(withIdentifier: "changeCombo", sender: self)
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
            
            let taskToDelete = comboNames[(indexPath as NSIndexPath).row]
            
            dict_ComboList.removeObject(forKey: taskToDelete)
            
            comboNames = dict_ComboList.allKeys as! [String]
            
            // Sort the country names within itself in alphabetical order
            comboNames.sort { $0 < $1 }
            
            // Reload the rows and sections of the Table View countryCityTableView
            combosTableView.reloadData()
            
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
        if segue.identifier == "showComboItems" {
            
            // Obtain the object reference of the destination (downstream) view controller
            let comboItemsTableViewController: ComboItemsTableViewController = segue.destination as! ComboItemsTableViewController
            
            /*
             This view controller creates the dataObjectToPass and passes it (by value) to the downstream view controller
             MovieTrailerViewController by copying its content into MovieTrailerViewController property dataObjectPassed.
             */
            comboItemsTableViewController.dataObjectPassed = dataObjectToPass
            
        }
        if segue.identifier == "changeCombo" {
            
            // Obtain the object reference of the destination (downstream) view controller
            //let changeComboItemViewController: ChangeComboItemsViewController = segue.destination as! //ChangeComboItemsViewController
            
            /*
             This view controller creates the dataObjectToPass and passes it (by value) to the downstream view controller
             MovieTrailerViewController by copying its content into MovieTrailerViewController property dataObjectPassed.
             */
            //changeComboItemViewController.dataObjectPassed = dataObjectToPass
            
        }
    }

}
