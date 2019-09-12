//
//  FiveDayWeatherLoader.swift
//  HW13
//
//  Created by Oleg Shashkov on 13/08/2019.
//  Copyright © 2019 citymed12. All rights reserved.
//

import Foundation
import CoreData
import Alamofire

class FiveDayWeatherLoader{
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    lazy var entity = NSEntityDescription.entity(forEntityName: "FiveDayWeather", in: context)
    func loadFiveDayWeather(completion: @escaping ([FiveDayWeather])->Void){
        var fiveDayWeathers:[FiveDayWeather] = []
        Alamofire.request("https://api.openweathermap.org/data/2.5/forecast?q=Moscow&APPID=40886fb7457c64056fc82aebfac0e87f").responseJSON { (response) in
            if let json = response.result.value,
                let jsonDict = json as? NSDictionary{
                if let list  = jsonDict.object(forKey: "list") as? [NSDictionary]{
                    for m in list {
                        let dt_txt = m.object(forKey: "dt_txt") as? String
                        if let main = m.object(forKey: "main") as? NSDictionary{
                            let  temp = main["temp"] as? Double
                            let temp_min = main["temp_min"] as? Double
                            let temp_max = main["temp_max"] as? Double
                            let pressure = main["pressure"] as? Double
                            let humidity = main["humidity"] as? Double
                            let newFiveDay = NSManagedObject(entity: self.entity!, insertInto: self.context) as! FiveDayWeather
                            newFiveDay.dt_txt = dt_txt!
                            newFiveDay.temp = temp!
                            newFiveDay.temp_min = temp_min!
                            newFiveDay.temp_max = temp_max!
                            newFiveDay.pressure = pressure!
                            newFiveDay.humidity = humidity!
                            
                            do{
                                try self.context.save()
                                fiveDayWeathers.append(newFiveDay)
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                        
                        
                        
                    }
                }
                
            }
            DispatchQueue.main.async {
                print(fiveDayWeathers.count)
                completion(fiveDayWeathers)
            }
        }
        
    }
}
