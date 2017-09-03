//
//  measureCell.swift
//  AirQuality
//
//  Created by Ellen Bianca Mota de Carvalho on 02/09/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//
//
//Available in: https://github.com/ellenmota
import UIKit

class measureCell: UITableViewCell {

    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var viewIndicator: UIView!
    @IBOutlet weak var airIndicator: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
