//
//  TableViewCell.swift
//  Exchange converter
//
//  Created by Ярослав Акулов on 24.10.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var charCodeLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet weak var progressionImage: UIImageView!
    
    func configure(with valutes: [String: ValuteDescription],_ keys:[String], _ index: Int) {
        guard let valuteName = valutes[keys[index]]?.Name else {return}
        guard let valuteCharCode = valutes[keys[index]]?.CharCode else {return}
        guard let valuteValue = valutes[keys[index]]?.Value else {return}
        guard let previousValue = valutes[keys[index]]?.Previous else {return}
        guard let nominal = valutes[keys[index]]?.Nominal else {return}
        nameLabel.text = valuteName
        charCodeLabel.text = valuteCharCode
        valueLabel.text = getRoundValue(by: 1000)
        
        if valuteValue > previousValue {
            valueLabel.textColor = .systemGreen
            progressionImage.image = UIImage(systemName: "arrowtriangle.up.fill")

        } else if valuteValue < previousValue {
            valueLabel.textColor = .systemRed
            progressionImage.image = UIImage(systemName: "arrowtriangle.down.fill")
        }
    
        progressionImage.tintColor = valueLabel.textColor
        
        func getRoundValue(by order: Double) -> String {
        let value = Double(round(order*(valuteValue / Double(nominal))) / order )
            return String(value)
    }
    }
}
    
