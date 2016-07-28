//
//  Lessons.swift
//  Titch
//
//  Created by lin_d on 7/21/16.
//  Copyright © 2016 etna. All rights reserved.
//
import UIKit
import SwiftyJSON
import Alamofire
import Toast_Swift

class LessonTableViewController: UITableViewController {

    @IBOutlet var tableV: UITableView!

    var name = String()
    var desc = String()
    var id = String()
    
    var lessons = [Lesson]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("name \(name)")
        print("desc \(desc)")
        print("id \(id)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let headers = ["Authorization" : "Bearer " + token]

        Alamofire.request(.GET, "http://symfonyios.cloudapp.net/api/lesson/type/one/\(id)", headers: headers)
            .validate()
            .responseJSON { response in
                if (response.result.value != nil) {
                    debugPrint(response.result.value!)
                    let json = JSON(response.result.value!)
                    for (_,subJson) in json["lessons"] {
                        let lessontmp = Lesson(title: subJson["name"].stringValue, desc: subJson["description"].stringValue, id: subJson["id"].stringValue)!
                        self.lessons.append(lessontmp)
                    }
                }
                else {
                    self.view.makeToast("Error Call BDD")
                }
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        tableV.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  segue.identifier == "LessonVideoView",
            let destination = segue.destinationViewController as? VideoViewController,
            blogIndex = tableView.indexPathForSelectedRow?.row
        {
            let lesson = lessons[blogIndex]
            destination.id = lesson.id
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //CODE TO BE RUN ON CELL TOUCH
        self.performSegueWithIdentifier("LessonVideoView", sender: self)
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lessons.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "LessonTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! LessonTableViewCell

        // Fetches the appropriate meal for the data source layout.
        
        let lesson = lessons[indexPath.row]
        // Configure the cell...
        
        cell.Title.text = lesson.title
        cell.Description.text = lesson.desc
        	
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
