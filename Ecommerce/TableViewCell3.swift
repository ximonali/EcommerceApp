//
//  TableViewCell3.swift
//  
//
//  Created by Simon Gonzalez on 2016-04-07.
//
//

import UIKit

class TableViewCell3: UITableViewCell {

    

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
