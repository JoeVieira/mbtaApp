//
//  MBTA_API.swift
//  Ttimer
//
//  Created by Joe Vieira on 6/1/16.
//  Copyright © 2016 Joe Vieira. All rights reserved.
//

import Foundation

class MBTA_API {
    
    var timer: NSTimer;
    var data: String;
    var error: String;
    var stations: [String:StationModel];

    init() {
        data = String();
        timer = NSTimer();
        error = String();
        stations = [String:StationModel]();
        getData();
        start();
    }
    
    func start() {
        timer = NSTimer.scheduledTimerWithTimeInterval(
            10.0, target: self, selector: #selector(MBTA_API.getData),
            userInfo: nil, repeats: true
        );
    }
    
    func updateData(data:String, error:String?) {
        
        self.data = data;
        self.error = error!;
        print("Getting new data");
        stations = makeStations();
        
        
    }
    
    func makeStations() -> [String:StationModel] {
        
        var southStationTrains = [TrainModel]();
        var northStationTrains = [TrainModel]();
       
        var items = data.componentsSeparatedByString("\n");
        
        let pos = items[0].componentsSeparatedByString(",");
        
        items.removeAtIndex(0);
        
        for row in items {
            
            let train = TrainModel();
            
            var station = "";
            let keys = row.componentsSeparatedByString(",");
            if keys.count != pos.count {
                continue; //a row with an invalid number of columns
            }
            for index in 0...pos.count-1 {
                
                let key = keys[index];
    
                let trimmed = key.stringByReplacingOccurrencesOfString("\"",withString: "");
                
                if pos[index] == "Origin" && ["North Station","South Station"].contains(trimmed) {
                    station = trimmed;
                }
                
                if pos[index] == "Destination" {
                    train.Destination = trimmed;
                }
                if pos[index] == "Lateness" {
                    let late:Int? = Int(key);
                    train.Lateness = late!;
                }
                if pos[index] == "Status\r" {
                    train.Status = trimmed
                }
                if pos[index] == "ScheduledTime" {
                    let time:Int? = Int(key);
                    train.TimeDepart = time!;
                }
            
            }
            
            if station == "North Station" {
                northStationTrains.append(train);
            }
            else if station == "South Station" {
                southStationTrains.append(train);
            }
            
        }
        
        return ["north":StationModel(trains: northStationTrains), "south":StationModel(trains: southStationTrains)];
        
    }
    
    func getStation(station: String)-> StationModel {
        
        return stations[station]!;
        
    }
    
    dynamic func getData() {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://developer.mbta.com/lib/gtrtfs/Departures.csv")!);
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                self.updateData("", error: error!.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding:
                    NSASCIIStringEncoding)!
                self.updateData(result as String,error: "")
            }
        }
        task.resume()
    }
    
    
    func pause() {
        timer.invalidate();
    }
    
    
}