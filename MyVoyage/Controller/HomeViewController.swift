//
//  HomeViewController.swift
//  MyVoyage
//
//  Created by Kyphun Lepeule on 07/04/2021.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate{
    
    // MARK: - Properties
    
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var city: UILabel!
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.first else { return }
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))
        myMap.setRegion(region, animated: true)
        self.myMap.showsUserLocation = true
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemark, error) in
            if error != nil {
                print("Error")
            } else {
                if let place = placemark?[0] {
                    self.city.text = place.locality
                }
            }
        }
    }

}

