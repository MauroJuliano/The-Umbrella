//
//  HomeViewController.swift
//  The Umbrella
//
//  Created by Lestad on 2021-01-02.
//  Copyright © 2021 Lestad. All rights reserved.
//

import UIKit
import FirebaseAuth
class HomeViewController: UIViewController {

    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var connectView: UIView!
    @IBOutlet var connectButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherLabel.text = "Check The Umbrella \n to be prepared for any \n weather"
        connectView.roundCorners(.topLeft, radius: 60)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if let uid = Auth.auth().currentUser?.uid {
          goToFeed()
        }
    }
    
    @IBAction func connectButton(_ sender: Any) {
        if let vc = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as? LoginViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    func goToFeed(){
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? ViewController{
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

