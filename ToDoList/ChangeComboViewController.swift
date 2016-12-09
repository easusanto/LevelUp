//
//  ChangeComboViewController.swift
//  LevelUp
//
//  Created by Estelle Susanto on 12/8/16.
//  Copyright © 2016 Estelle Susanto. All rights reserved.
//

import UIKit

class ChangeComboViewController: UIViewController {

    var dataObjectPassed = [String]()
    
    @IBOutlet var comboName: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        comboName.text = dataObjectPassed[0]
                
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
        
        if(comboName.isFirstResponder)
        {
            comboName.resignFirstResponder()
        }
    }
}
