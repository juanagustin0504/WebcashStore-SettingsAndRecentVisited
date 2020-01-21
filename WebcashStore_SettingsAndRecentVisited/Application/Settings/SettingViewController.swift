//
//  SettingViewController.swift
//  WebcashStore_SettingsAndRecentVisited
//
//  Created by Webcash on 2020/01/21.
//  Copyright © 2020 WebCash. All rights reserved.
//

import UIKit
import LanguageManager_iOS

class SettingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    

    @IBAction func changeLanguage(_ sender: UIButton) {
        let selectedLanguage: Languages
        switch sender.tag {
        case 1:
            selectedLanguage = .ko
        case 2:
            selectedLanguage = .km
        default:
            selectedLanguage = .en
        }
        
        print(selectedLanguage)
        LanguageManager.shared.setLanguage(language: selectedLanguage)
        self.tableView.reloadData()

    }

}

extension SettingViewController: UITableViewDelegate {
    
}

extension SettingViewController: UITableViewDataSource {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        cell.lblHello.text = "Hello".localiz()
        
        return cell
    }
    
    
}
