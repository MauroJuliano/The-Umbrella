//
//  HomeViewController.swift
//  The Umbrella
//
//  Created by Lestad on 2021-01-02.
//  Copyright © 2021 Lestad. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var connectView: UIView!
    @IBOutlet var connectButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connectView.roundCorners(.topLeft, radius: 60)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func connectButton(_ sender: Any) {
        if let vc = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as? LoginViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }

}
extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }
}

