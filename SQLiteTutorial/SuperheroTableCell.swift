//
//  SuperheroTableCell.swift
//  SQLiteTutorial
//
//  Created by Ram Mhapasekar on 12/03/17.
//  Copyright © 2017 Ram Mhapasekar. All rights reserved.
//

import UIKit

class SuperheroTableCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblPower: UILabel!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var btnDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
