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
import MapKit
import DynamicBlurView

class SearchViewController: UIViewController, UISearchBarDelegate {

    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    @IBOutlet var viewBlur: UIView!
    @IBOutlet var topView: UIView!
    
    @IBOutlet var buttonView: UIView!
    @IBOutlet var searchB: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchB.delegate = self
        searchB.showsCancelButton = true
        viewBlur.backgroundColor = UIColor(patternImage: UIImage(named: "wintersnow.png")!)
        setupBlur()
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
    
    @IBAction func NewLocation(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension SearchViewController: GMSAutocompleteResultsViewControllerDelegate  {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        print(place.name)
        print(place.coordinate)
        //implement database
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        //
    }
}
