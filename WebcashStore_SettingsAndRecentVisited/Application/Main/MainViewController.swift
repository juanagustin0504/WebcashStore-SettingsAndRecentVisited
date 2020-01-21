//
//  MainViewController.swift
//  WebcashStore_SettingsAndRecentVisited
//
//  Created by Webcash on 2020/01/20.
//  Copyright © 2020 WebCash. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func gotoSettings(_ sender: UIButton) {
        let settingsVc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController_sid") as! SettingsViewController
        settingsVc.modalPresentationStyle = .fullScreen
        settingsVc.modalTransitionStyle = .crossDissolve
        self.present(settingsVc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
