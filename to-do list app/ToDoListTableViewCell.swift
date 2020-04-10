//
//  ToDoListTableViewCell.swift
//  to-do list app
//
//  Created by 농협 on 02/04/2020.
//  Copyright © 2020 nonghyup. All rights reserved.
//

import UIKit

class ToDoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var lineViewLeading: NSLayoutConstraint!
    @IBOutlet weak var lineViewWidth: NSLayoutConstraint!
    
    var checked: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        detailView.layer.cornerRadius = 10.0
        detailView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
