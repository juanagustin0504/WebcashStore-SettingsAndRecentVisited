//
//  SettingViewController.swift
//  WebcashStore_SettingsAndRecentVisited
//
//  Created by Webcash on 2020/01/21.
//  Copyright © 2020 WebCash. All rights reserved.
//

import UIKit
import UserNotifications
import LanguageManager_iOS

class SettingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var touchAreaView: UIView!
    
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var settingsTitle: UILabel!
    @IBOutlet weak var notification: UILabel!
    @IBOutlet weak var notification_detail: UILabel!
    @IBOutlet weak var display_language: UILabel!
    @IBOutlet weak var choose_language: UILabel!
    @IBOutlet weak var about_us: UILabel!
    @IBOutlet weak var about_us_detail: UILabel!
    
    let bgTask = UIBackgroundTaskIdentifier.invalid
    
    private let langList: [String] = ["한국어", "ខ្មែរ", "English"]
    private let langImages: [UIImage] = [UIImage(named: "Flag_of_Korea_(1919_1945).png")!, UIImage(named: "255px-Flag_of_Cambodia.svg.png")!, UIImage(named: "UK-US_flag.png")!]
    private let btnLangImages: [UIImage] = [UIImage(named: "baseline-radio_button_unchecked-24px")!, UIImage(named: "baseline-radio_button_checked-24px")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "ic_expand_less_24px.png")!
        let newImage = image.rotate(radians: .pi/2) // Rotate 90 degrees
        backButton.setImage(newImage, for: .normal)
        
        applyRoundedShadow()
        changeStringsFromLanguage()
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.gotoNotificationSetting (_:)))
        self.touchAreaView.addGestureRecognizer(gesture)
        
    }
    
    func applyRoundedShadow() {
        
        let maskPath = UIBezierPath(roundedRect: tableView.bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight], cornerRadii: CGSize(width: 30.0, height: 30.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.tableView.bounds
        maskLayer.path = maskPath.cgPath
        
        let shadowLayer = CAShapeLayer()
        
        shadowLayer.path = maskPath.cgPath
        shadowLayer.fillColor = UIColor.clear.cgColor
        
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowLayer.shadowOpacity = 0.4
        shadowLayer.shadowRadius = 3
        
        
        tableView.layer.mask = maskLayer
        shadowView.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            if UIApplication.shared.isRegisteredForRemoteNotifications {
                self.notificationSwitch.isOn = true
            } else {
                self.notificationSwitch.isOn = false
            }
        }
        
    }
    
    @objc func gotoNotificationSetting(_ sender: UITapGestureRecognizer) {
        
        DispatchQueue.main.async {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                } else {
                    UIApplication.shared.openURL(settingsUrl as URL)
                }
            }
        }
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
        //        LanguageManager.shared.currentLanguage = selectedLanguage
        LanguageManager.shared.setLanguage(language: selectedLanguage)
        changeStringsFromLanguage()
        
        self.tableView.reloadData()
    }
    
    func changeStringsFromLanguage() {
        settingsTitle.text = "settings".localiz()
        notification.text = "notification".localiz()
        notification_detail.text = "notification_detail".localiz()
        display_language.text = "display_language".localiz()
        choose_language.text = "choose_language".localiz()
        about_us.text = "about_us".localiz()
        about_us_detail.text = "about_us_detail".localiz()
    }
    
    @IBAction func backToMain(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UIView {
    @discardableResult
    func corners(_ radius: CGFloat) -> UIView {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func shadow(radius: CGFloat, color: UIColor, offset: CGSize, opacity: Float) -> UIView {
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        return self
    }
}

extension SettingViewController: UITableViewDelegate, UNUserNotificationCenterDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: // Korean
            LanguageManager.shared.setLanguage(language: .ko)
        case 1: // Khmer
            LanguageManager.shared.setLanguage(language: .km)
        default:
            LanguageManager.shared.setLanguage(language: .en)
        }
        
        print(LanguageManager.shared.currentLanguage)
        changeStringsFromLanguage()
        self.tableView.reloadData()
    }
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

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat =  -10,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
