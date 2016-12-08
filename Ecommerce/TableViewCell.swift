//
//  TableViewCell.swift
//  
//
//  Created by Simon Gonzalez on 2016-03-27.
//
//

import UIKit

class TableViewCell: UITableViewCell {

    //Controls
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCant: UILabel!
    @IBOutlet weak var imgItem: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
