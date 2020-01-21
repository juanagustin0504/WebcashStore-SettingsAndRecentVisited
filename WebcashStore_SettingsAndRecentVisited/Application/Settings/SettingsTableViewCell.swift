//
//  SettingsTableViewCell.swift
//  WebcashStore_SettingsAndRecentVisited
//
//  Created by Webcash on 2020/01/21.
//  Copyright © 2020 WebCash. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet var lblHello: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblHello.text = "Hello"
    }


}
