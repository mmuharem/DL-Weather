//
//  SecondViewController.swift
//  Weather-App
//
//  Created by Mehmed Muharemovic on 1/22/19.
//  Copyright © 2019 Mehmed Muharemovic. All rights reserved.
//

import UIKit

class WeekWeatherVC: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var day1Button: UIButton!
    @IBOutlet weak var day2Button: UIButton!
    @IBOutlet weak var day3Button: UIButton!
    @IBOutlet weak var day4Button: UIButton!
    @IBOutlet weak var day5Button: UIButton!
    
    var previouslySelectedIndex = 1 //tag 0 is default so that's dumb
    var selectedDate = Date()
    var currentLocation : LocationStruct?
    
    var days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var fiveDayForecast : [String : [ListModel]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Week Weather VC")
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupTable()
        self.addDays()
        
        cityLabel.text = "Enable location to find city"
        dateLabel.text = "Today's date"
        
        LocationHandler.sharedInstance.stop()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            LocationHandler.sharedInstance.start()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLocation(_:)), name: NSNotification.Name(rawValue: "updateLocation"), object: nil)
    }

    @objc func updateLocation(_ notification: Notification) {
        WeatherRequestHandler.sharedInstance.getWeatherForLocationWeek { (response, result) in
            
            if response == RequestAnswer.Success {
                
                if let city = result.first?.city?.name {
                    self.cityLabel.text = city
                }
                
                if let allDays = result.first?.list {
                    
                    //want to iterate through the day.list and hash each day's hours into it's own day
                    
                    let dictByKey = Dictionary(grouping: allDays, by: { $0.dt_txt.components(separatedBy: " ").first! })
                    self.fiveDayForecast = dictByKey
                    
                    self.changeDate()
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            
            }
            
        }
    }
    
    func changeDate() {
        let newDate = Calendar.current.date(byAdding: .day, value: self.previouslySelectedIndex - 1, to: Date())!
        
        self.selectedDate = newDate
        
        self.dateLabel.text = self.selectedDate.DateToString(format: "yyyy-MM-dd")
    }
    
    func addDays() {
        //get today's date
        let today = Date().DateToString(format: "E")
        self.dateLabel.text = Date().DateToString(format: "yyyy-MM-dd")
        
        if let index = self.days.index(of: today) {
            
            let subArray = self.days[index...index+6]
            for (index, day) in subArray.enumerated() {
                
                switch index {
                case 0:
                    //tag is index + 1. 0 is 1 because 0 tag is default for all and won't find this
                    editButton(button: day1Button, text: day, tag: index + 1)
                case 1:
                    editButton(button: day2Button, text: day, tag: index + 1)
                case 2:
                    editButton(button: day3Button, text: day, tag: index + 1)
                case 3:
                    editButton(button: day4Button, text: day, tag: index + 1)
                case 4:
                    editButton(button: day5Button, text: day, tag: index + 1)
                default:
                    print("nothing")
                }
                
            }
        }
    }
    
    func editButton(button: UIButton, text : String, tag: Int) {
        button.setTitle(text, for: .normal)
        button.addTarget(self, action: #selector(clickedDayButton), for: .touchUpInside)
        button.tag = tag
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        if previouslySelectedIndex == tag {
            button.isSelected = true
        }
    }
    
    @objc func clickedDayButton(sender: UIButton){

        let tempButton = self.view.viewWithTag(self.previouslySelectedIndex) as? UIButton
        tempButton?.isSelected = false

        sender.isSelected = true
        self.previouslySelectedIndex = sender.tag

        self.changeDate()

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

extension WeekWeatherVC : UITableViewDataSource, UITableViewDelegate {
    
    func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
        
        tableView.register(UINib(nibName: "WeatherHourlyTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WeatherHourlyTableViewCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let date = self.selectedDate.DateToString(format: "yyyy-MM-dd")
        print(date)
        
        guard let day = fiveDayForecast[date] else {
            print("day not found??")
            return 0
        }
        
        print("self - returning rows: \(day.count)")
        return day.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let date = self.selectedDate.DateToString(format: "yyyy-MM-dd")
        
        guard let day = fiveDayForecast[date] else {
            print("day not found??")
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherHourlyTableViewCell") as! WeatherHourlyTableViewCell
        
        let weatherForTime = day[indexPath.row]
        
        cell.time = weatherForTime.dt_txt.components(separatedBy: " ")[1]
        cell.weather = weatherForTime.weather?.first?.main
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
