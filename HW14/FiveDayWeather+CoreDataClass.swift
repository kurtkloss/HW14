//
//  FiveDayWeather+CoreDataClass.swift
//  HW14
//
//  Created by Oleg Shashkov on 12/09/2019.
//  Copyright © 2019 citymed12. All rights reserved.
//
//

import Foundation
import CoreData

@objc(FiveDayWeather)
public class FiveDayWeather: NSManagedObject {
    
    
}
extension FiveDayWeather{
    var pressureString: String {
        return "\(Int(pressure)) mm"
    }
    
    var humidityString: String {
        return "\(Int(humidity)) %"
    }
    
    var temperatureString: String {
        return "\(Int(temp - 273.15))˚C"
    }
    
    var temp_minString: String {
        return "\(Int(temp_min - 273.15))˚C"
    }
    var temp_maxString: String {
        return "\(Int(temp_min - 273.15))˚C"
    }
}
