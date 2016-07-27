//
//  tabViewCours.swift
//  Titch
//
//  Created by Charlie Lim on 25/07/16.
//  Copyright © 2016 etna. All rights reserved.
//

import UIKit
import Material
import AVKit
import AVFoundation

class TabCoursController: UIViewController {
    
    //@IBOutlet var Videoview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func play(sender: AnyObject) {
        let url = NSURL(string: "http://symfonyios.cloudapp.net/uploads/lesson/file_lesson_26072016151854.mp4")
        
        let player =  AVPlayer(URL: url!)
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.presentViewController(playerController, animated: true, completion: nil)
        
    }
}