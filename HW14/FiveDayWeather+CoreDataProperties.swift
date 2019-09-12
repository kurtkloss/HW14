//
//  FiveDayWeather+CoreDataProperties.swift
//  HW14
//
//  Created by Oleg Shashkov on 12/09/2019.
//  Copyright © 2019 citymed12. All rights reserved.
//
//

import Foundation
import CoreData


extension FiveDayWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FiveDayWeather> {
        return NSFetchRequest<FiveDayWeather>(entityName: "FiveDayWeather")
    }

    @NSManaged public var dt_txt: String?
    @NSManaged public var temp: Double
    @NSManaged public var pressure: Double
    @NSManaged public var humidity: Double
    @NSManaged public var temp_min: Double
    @NSManaged public var temp_max: Double

}
