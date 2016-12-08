//
//  TableViewCell2.swift
//  
//
//  Created by macadmin on 2016-04-06.
//
//

import UIKit

class TableViewCell2: UITableViewCell {

    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblCant: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
