//
//  StationModel.swift
//  Ttimer
//
//  Created by Joe Vieira on 6/1/16.
//  Copyright © 2016 Joe Vieira. All rights reserved.
//

import Foundation

class StationModel {
    
    var trains: [TrainModel];
    
    init(trains:[TrainModel]) {
        self.trains = trains;
    }
    
    func getTrains() -> [TrainModel] {
        return trains;
    }
    
}