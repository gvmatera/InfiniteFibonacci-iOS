//
//  FibonacciCell.swift
//  Fibonacci
//
//  Created by Gianni Matera on 10/25/16.
//  Copyright © 2016 Gianni Matera. All rights reserved.
//

import UIKit

class FibonacciCell: UITableViewCell {

    @IBOutlet weak var fibonacciLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
