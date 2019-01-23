//
//  WeatherHourlyTableViewCell.swift
//  Weather-App
//
//  Created by Mehmed Muharemovic on 1/22/19.
//  Copyright © 2019 Mehmed Muharemovic. All rights reserved.
//

import UIKit

class WeatherHourlyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var weather : String! {
        didSet {
            self.weatherLabel.text = weather
        }
    }
    
    var time : String! {
        didSet {
            self.timeLabel.text = time
        }
    }
    
}
