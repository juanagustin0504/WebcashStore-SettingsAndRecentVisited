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
    
    private let langList: [String] = ["한국어", "ខ្មែរ", "English"]
    private let langImages: [UIImage] = [UIImage(named: "Flag_of_Korea_(1919_1945).png")!, UIImage(named: "255px-Flag_of_Cambodia.svg.png")!, UIImage(named: "UK-US_flag.png")!]
    private let btnLangImages: [UIImage] = [UIImage(named: "baseline-radio_button_unchecked-24px")!, UIImage(named: "baseline-radio_button_checked-24px")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let maskPath = UIBezierPath(roundedRect: tableView.bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight], cornerRadii: CGSize(width: 30.0, height: 30.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = tableView.bounds
        maskLayer.path = maskPath.cgPath

//        let shadowLayer = CAShapeLayer()
//        shadowLayer.frame = tableView.bounds
//        shadowLayer.path = maskPath.cgPath
//        shadowLayer.applySketchShadow(color: .black, alpha: 0.4, x: 0, y: -10, blur: 5, spread: 0)
        
//        tableView.layer.applySketchShadow(color: .black, alpha: 0.4, x: 0, y: -10, blur: 5, spread: 0)
        
        tableView.layer.mask = maskLayer
//        tableView.layer.mask = shadowLayer
    }
    

    @IBAction func changeLanguage(_ sender: UIButton) {
        let selectedLanguage: Languages
        switch sender.tag {
        case 0:
            selectedLanguage = .ko
        case 1:
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return langList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as? LanguageSelectionCell else {
            return UITableViewCell()
        }
        cell.languageImageView.image = langImages[indexPath.row]
        cell.lblLanguage.text = langList[indexPath.row]
        cell.btnSelection.tag = indexPath.row
        
        if indexPath.row == 0 { // Korean
            cell.btnSelection.setBackgroundImage((LanguageManager.shared.currentLanguage == .ko) ? btnLangImages[1] : btnLangImages[0], for: .normal)
        } else if indexPath.row == 1 {
            cell.btnSelection.setBackgroundImage((LanguageManager.shared.currentLanguage == .km) ? btnLangImages[1] : btnLangImages[0], for: .normal)
        } else {
            cell.btnSelection.setBackgroundImage((LanguageManager.shared.currentLanguage == .en) ? btnLangImages[1] : btnLangImages[0], for: .normal)
        }
        return cell
    }
    
    
}
