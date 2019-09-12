//
//  FiveDayViewController.swift
//  HW14
//
//  Created by Oleg Shashkov on 12/09/2019.
//  Copyright © 2019 citymed12. All rights reserved.
//

import UIKit
import CoreData

class FiveDayViewController: UITableViewController {
    var fiveDayWeathers:[FiveDayWeather] = []
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    lazy var entity = NSEntityDescription.entity(forEntityName: "FiveDayWeather", in: context)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let fetchRequest :NSFetchRequest<FiveDayWeather> = FiveDayWeather.fetchRequest()
        do{
            fiveDayWeathers = try context.fetch(fetchRequest)
            
        } catch{
            print(error.localizedDescription)
        }
        
        FiveDayWeatherLoader().loadFiveDayWeather { fiveDayWeathers in
            for weather in self.fiveDayWeathers{
                self.context.delete(weather)
            }
            do{
                try self.context.save()
                print("weather deleted")
            } catch{
                print(error.localizedDescription)
            }

            self.fiveDayWeathers = fiveDayWeathers
            self.tableView.reloadData()
        }
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fiveDayWeathers.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FiveDayCell
        
        cell.humidityLabel.text = fiveDayWeathers[indexPath.row].humidityString
        cell.pressureLabel.text = fiveDayWeathers[indexPath.row].pressureString
        cell.tempLabel.text = fiveDayWeathers[indexPath.row].temperatureString
        cell.dateLabel.text = fiveDayWeathers[indexPath.row].dt_txt
        return cell
    }
    
    
    
}
