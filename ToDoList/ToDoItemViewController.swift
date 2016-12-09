//
//  ToDoItemViewController.swift
//  LevelUp
//
//  Created by Estelle Susanto on 12/1/16.
//  Copyright © 2016 Estelle Susanto. All rights reserved.
//
import UIKit

class ToDoItemViewController: UIViewController {

    var dataObjectPassed = [String]()
    
    @IBOutlet var toDoTitle: UILabel!
    @IBOutlet var toDoDescription: UITextView!
    @IBOutlet var toDoDueDateAndTime: UILabel!
    @IBOutlet var toDoPriority: UILabel!
    @IBOutlet var toDoCompleted: UILabel!
    @IBOutlet var toDoEvent: UILabel!
    @IBOutlet var toDoGif: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Skill"
        
        toDoTitle.text = dataObjectPassed[0]
        toDoDescription.text = dataObjectPassed[1]
        toDoDueDateAndTime.text = dataObjectPassed[2]
        toDoPriority.text = dataObjectPassed[3]
        toDoCompleted.text = dataObjectPassed[4]
        toDoEvent.text = dataObjectPassed[5]
        //toDoGif.image = UIImageView(image: dataObjectPassed[6])
        
        
        let gifURL : String = dataObjectPassed[6]
        let imageURL = UIImage.gifImageWithURL(gifURL)
        toDoGif.image = imageURL
//        if let url = NSURL(string: imageURL) {
//            if let data = NSData(contentsOf: url as URL) {
//                toDoGif.image = UIImage(data: data as Data)
//            }
//        }
        
        
        //toDoGif = UIImageView(image: imageURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        /*
         Ask the movieInfoTextView to scroll to the top of the text view.
         You can use the following to scroll to the bottom of the text view if desired in another app:
         movieInfoTextView.scrollRangeToVisible(NSMakeRange(0, (movieInfoTextView.text as NSString).length))
         */
        toDoDescription.scrollRangeToVisible(NSMakeRange(0, 0))
    }

   

}
