//
//  ListCell.swift
//  geoWeather
//
//  Created by Гриша on 04.02.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(_ list: List) {
        locationLabel.text = list.name
        iconLabel.text = list.icon
        tempLabel.text = list.temp
        dateLabel.text = list.date.stringFromDate()
    }

}
