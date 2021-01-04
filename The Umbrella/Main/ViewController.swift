//
//  ViewController.swift
//  The Umbrella
//
//  Created by Lestad on 2020-08-04.
//  Copyright © 2020 Lestad. All rights reserved.
//

import UIKit
import CoreLocation
import DynamicBlurView

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //Outlets
    @IBOutlet var locationsCollection: UICollectionView!
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet weak var CityName: UILabel!
    @IBOutlet weak var Temp: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var weather: UILabel!
    @IBOutlet weak var ImageWeather: UIImageView!
    
    var controller: mainViewController?
    var request = dataRequest()
    //Constants
    let locationManager = CLLocationManager()
    //Variables
    var currentWeather: CurrentWeather!
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.black
        
        self.callDelegate()
        self.setupLocation()
        
        currentWeather = CurrentWeather()
        //imageBlur()
        //blurVibrancy()
        requestSetup()
       
        // Do any additional setup after loading the view.
    }
    
    func blurVibrancy(){
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = backgroundImage.bounds
        backgroundImage.addSubview(blurredEffectView)
        
//        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
//        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
//        vibrancyEffectView.frame = backgroundImage.bounds
//
//
//        blurredEffectView.contentView.addSubview(vibrancyEffectView)
        
    }
    func requestSetup(){
        print("request okay")
        request.downloadData(completionHandler: { success,_ in
            if success {
                self.collectionSetup()
            }
        })
    }
    
    func collectionSetup(){
        controller = mainViewController(mainView: self, request: request)
        locationsCollection.delegate = controller
        locationsCollection.dataSource = controller
        locationsCollection.reloadData()
    }
    func imageBlur(){
        
        let blurView = DynamicBlurView(frame: backgroundImage.bounds)
        blurView.blurRadius = 3.5
        backgroundImage.addSubview(blurView)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        locationAutoCheck()
    }
    
    func callDelegate(){
        locationManager.delegate = self
    }
    
    func setupLocation(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // take permission from user.
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func locationAutoCheck() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            //get the location from device
            currentLocation = locationManager.location
            //pass the location coord to our API
            Locations.sharedInstance.latitude = currentLocation.coordinate.latitude
            Locations.sharedInstance.longitude = currentLocation.coordinate.longitude
            // download API data
            currentWeather.downloadCurrentWeather {
            // update the UI after download is completed.
            self.updateUI()
            }
            
        } else{ // user did not allow
            locationManager.requestWhenInUseAuthorization()//take permission from the user
            locationAutoCheck()
            
        }
    }
    @IBAction func NewLocation(_ sender: Any) {
        if let vc = UIStoryboard(name: "search", bundle: nil).instantiateInitialViewController() as? SearchViewController {
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    func updateUI(){
        CityName.text = currentWeather.cityName
        Temp.text = "\(currentWeather.currentTemp)°"
        Date.text = currentWeather.date
        weather.text = currentWeather.weatherType
        self.image()
    }
    
    func image(){
        if currentWeather.weatherType == "Clouds"{
            self.ImageWeather.image = UIImage(systemName:"cloud")
        } else if currentWeather.weatherType == "Rain"{
            self.ImageWeather.image = UIImage(systemName:"cloud.rain")
        }else if currentWeather.weatherType == "snow"{
            self.ImageWeather.image = UIImage(systemName:"snow")
        }else if currentWeather.weatherType == "sun"{
            self.ImageWeather.image = UIImage(systemName:"sun.min")
        }
    }
}


