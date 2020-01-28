//
//  SettingsViewController.swift
//  WebcashStore_SettingsAndRecentVisited
//
//  Created by Webcash on 2020/01/20.
//  Copyright © 2020 WebCash. All rights reserved.
//

import UIKit
import LanguageManager_iOS

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var lblHello: UILabel!
    
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var settingsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let maskPath = UIBezierPath(roundedRect: settingsView.bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight], cornerRadii: CGSize(width: 30.0, height: 30.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = settingsView.bounds
        maskLayer.path = maskPath.cgPath
        
//        maskLayer.applySketchShadow(color: .black, alpha: 0.4, x: 0, y: -5, blur: 5, spread: 0)
//        settingsView.layer.applySketchShadow(color: .black, alpha: 0.4, x: 0, y: -10, blur: 5, spread: 0)
        
        settingsView.layer.mask = maskLayer
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
        
        LanguageManager.shared.setLanguage(language: selectedLanguage, for: nil, viewControllerFactory: nil, animation: nil)
//        LanguageManager.shared.setLanguage(language: selectedLanguage, for: nil, viewControllerFactory: { title -> UIViewController in
//            print(title ?? "")
//            let mainSb = UIStoryboard(name: "Main", bundle: nil)
//            return mainSb.instantiateInitialViewController()!
//            return self
//        }) { view in
//            view.transform = CGAffineTransform(scaleX: 2, y: 2)
//            view.alpha = 0
//        }
        self.viewDidLoad()
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
