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
import EMTNeumorphicView

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //Outlets
    @IBOutlet var locationsCollection: UICollectionView!
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var cardBackground: UIView!
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
        
        self.callDelegate()
        self.setupLocation()
    
        currentWeather = CurrentWeather()
        requestSetup()
        setupUI()
        // Do any additional setup after loading the view.
    }
    func setupUI(){
        //userImage.roundCorners(.allCorners, radius: 15)
        //cardBackground.roundCorners(.allCorners, radius: 20)
        let lilas = UIColor(hexString: "#6A6A93")
        CityName.textColor = lilas
    }
    func requestSetup(){
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
        Temp.text = " \(currentWeather.currentTemp)°"
        let weatherType = currentWeather.weatherType
        
        if weatherType == "Rain"{
            weather.text = "It's Raining Now \n Don't forget your umbrella !\n"
        }else if weatherType == "Clouds"{
            weather.text = "It's Cloudy Now"
        }else if weatherType == "Clear"{
            weather.text = "It's Sunning Now \n Don't forget to use sunscreen"
        }else if weatherType == "Snow"{
            weather.text = "It's Snowing! Remember to dress warmly!"
        }
        self.image()
    }
    
    func image(){
        if currentWeather.weatherType == "Clouds"{
            self.ImageWeather.image = UIImage(named:"clouds")
        }else if currentWeather.weatherType == "Rain"{
            self.ImageWeather.image = UIImage(named:"rain")
        }else if currentWeather.weatherType == "snow"{
            self.ImageWeather.image = UIImage(named:"snowing")
        }else if currentWeather.weatherType == "Clear"{
            self.ImageWeather.image = UIImage(named:"sun1")
        }
    }
}




