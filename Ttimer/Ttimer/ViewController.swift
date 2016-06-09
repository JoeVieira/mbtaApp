//
//  ViewController.swift
//  Ttimer
//
//  Created by Joe Vieira on 6/1/16.
//  Copyright © 2016 Joe Vieira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    var api: MBTA_API!;
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        api = appDelegate.api!;
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let stationView = segue.destinationViewController as! ViewStation
        if segue.identifier == "showNorthStation" {
            stationView.stationSelector = "north";
        }
        if segue.identifier == "showSouthStation" {
            stationView.stationSelector = "south";
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}