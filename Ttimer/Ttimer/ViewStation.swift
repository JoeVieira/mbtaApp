//
//  ViewStation.swift
//  Ttimer
//
//  Created by Joe Vieira on 6/1/16.
//  Copyright © 2016 Joe Vieira. All rights reserved.
//

import UIKit

class ViewStation: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var api: MBTA_API!;
    var station: StationModel!;
    
    var trains: [TrainModel] = [];
    var stationSelector: String = "";
    
    @IBOutlet var TrainList: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        api = appDelegate.api!;
        
        station = api.getStation(stationSelector);
        trains = station.getTrains();
        TrainList.delegate = self
        TrainList.dataSource = self
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trains.count;
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TrainCell", forIndexPath: indexPath)
        
        var cellContents: String;
        
        let row = indexPath.row
        cellContents = trains[row].Destination + " - " + trains[row].Status;
        
        if (trains[row].howLate() > 1) {
            cellContents += " - " + String(trains[row].howLate()) + " mins late"
            cell.textLabel?.textColor = UIColor(red: 0.5, green: 0.002, blue: 0.002, alpha: 1.0);
        }
        else if (trains[row].howLate() > 0) {
            cellContents += " - about a min late";
            cell.textLabel?.textColor = UIColor(red: 0.5, green: 0.001, blue: 0.001, alpha: 1.0);
        }
        cell.textLabel?.text = cellContents;
        
        return cell
    }
    
}
