//
//  CalendalCell.swift
//  to-do list app
//
//  Created by 농협 on 02/04/2020.
//  Copyright © 2020 nonghyup. All rights reserved.
//

import UIKit

class CalendalCell: UICollectionViewCell {

    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
    }

}
