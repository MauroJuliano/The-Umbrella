//
//  SearchViewController.swift
//  The Umbrella
//
//  Created by Lestad on 2020-12-31.
//  Copyright © 2020 Lestad. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
//import MapKit
import DynamicBlurView
import FirebaseAuth
import FirebaseDatabase

class SearchViewController: UIViewController, UISearchBarDelegate {

    var resultsViewController: GMSAutocompleteResultsViewController?
    let ref: DatabaseReference = Database.database().reference()
    var searchController: UISearchController?
    @IBOutlet var viewBlur: UIView!
    @IBOutlet var topView: UIView!
    
    @IBOutlet var buttonView: UIView!
    @IBOutlet var searchB: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchB.delegate = self
        searchB.showsCancelButton = true
        //viewBlur.backgroundColor = UIColor(patternImage: UIImage(named: "wintersnow.png")!)
       // setupBlur()
        setupSearchController()
    }
    
    func setupBlur(){
        topView.backgroundColor = UIColor.darkGray
        
        let blurView = DynamicBlurView(frame: viewBlur.bounds)
        blurView.blurRadius = 2
        viewBlur.addSubview(blurView)
    }
    
    func setupSearchController(){
        resultsViewController = GMSAutocompleteResultsViewController()
            searchController = UISearchController(searchResultsController: resultsViewController)
        resultsViewController?.delegate = self
            searchController?.searchResultsUpdater = resultsViewController

        let searchBar = searchController!.searchBar
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = searchController?.searchBar
        definesPresentationContext = true
        
        searchBar.barTintColor = UIColor.darkGray
        searchBar.tintColor = UIColor.white
        searchBar.showsCancelButton = true
        searchController?.hidesNavigationBarDuringPresentation = false
        searchB.addSubview(searchBar)
        
        searchBar.delegate = self
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: GMSAutocompleteResultsViewControllerDelegate  {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        
        if let uid = Auth.auth().currentUser?.uid {
            
            if let placename = place.name {
                let lat = place.coordinate.latitude
                let long = place.coordinate.longitude
                
                let dict: [String: Any] = [
                    "name": "\(placename)",
                    "latitude": lat,
                    "longitude": long,
                    "userID": uid
                ]
                ref.child("locations").child(uid).childByAutoId().updateChildValues(dict)
            }
        }
    }
 
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        //
    }
}
