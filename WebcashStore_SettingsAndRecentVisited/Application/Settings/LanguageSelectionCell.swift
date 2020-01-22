//
//  LanguageSelectionCell.swift
//  WebcashStore_SettingsAndRecentVisited
//
//  Created by Webcash on 2020/01/22.
//  Copyright © 2020 WebCash. All rights reserved.
//

import UIKit

class LanguageSelectionCell: UITableViewCell {
    
    @IBOutlet weak var languageImageView: UIImageView!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var btnSelection: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
