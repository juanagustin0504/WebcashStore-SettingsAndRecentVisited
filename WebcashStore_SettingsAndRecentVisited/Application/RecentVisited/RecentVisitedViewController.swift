//
//  RecentVisitedViewController.swift
//  WebcashStore_SettingsAndRecentVisited
//
//  Created by Webcash on 2020/01/29.
//  Copyright © 2020 WebCash. All rights reserved.
//

import UIKit

class RecentVisitedViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "ic_expand_less_24px.png")!
        let newImage = image.rotate(radians: .pi/2) // Rotate 90 degrees
        backButton.setImage(newImage, for: .normal)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToMain(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
