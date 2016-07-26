//
//  LessonType.swift
//  Titch
//
//  Created by lin_d on 7/22/16.
//  Copyright © 2016 etna. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Toast_Swift

class LTypeTableViewController: UITableViewController {
    

    @IBOutlet var tableV: UITableView!
    
    var types = [TypeLesson]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let headers = ["Authorization" : "Bearer " + token]
        
        print(headers)
        Alamofire.request(.GET, "http://symfonyios.cloudapp.net/api/lesson/type/all", headers: headers)
            .validate()
            .responseJSON { response in
                if (response.result.value != nil) {
                    debugPrint(response.result.value!)
                    let json = JSON(response.result.value!)
                    for (_,subJson) in json {
                        //Do something you want
                        let typetmp = TypeLesson(name: subJson["name"].stringValue, desc: subJson["description"].stringValue, id: subJson["id"].stringValue)!
                        self.types.append(typetmp)
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return types.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  segue.identifier == "ShowLessonsByType",
            let destination = segue.destinationViewController as? LessonTableViewController,
            blogIndex = tableView.indexPathForSelectedRow?.row
        {
            let type = types[blogIndex]
            destination.name = type.name
            destination.desc = type.desc
            destination.id = type.id
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //CODE TO BE RUN ON CELL TOUCH
        self.performSegueWithIdentifier("ShowLessonsByType", sender: self)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "LTypeTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! LTypeTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        
        let type = types[indexPath.row]
        // Configure the cell...
        
        cell.TypeName.text = type.name
        
        return cell
    }
}
