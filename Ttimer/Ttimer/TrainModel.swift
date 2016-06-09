//
//  TrainModel.swift
//  Ttimer
//
//  Created by Joe Vieira on 6/1/16.
//  Copyright © 2016 Joe Vieira. All rights reserved.
//

import Foundation

class TrainModel {
    
    var TimeDepart = 0;
    var Lateness = 0;
    var Destination = "";
    var Status = "";
    
    func howLate() -> Int {
        return (Lateness - TimeDepart) / 60;
    }
    
}