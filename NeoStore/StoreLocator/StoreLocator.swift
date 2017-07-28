//
//  StoreLocator.swift
//  NeoStore
//
//  Created by webwerks1 on 6/30/17.
//  Copyright © 2017 webwerks1. All rights reserved.
//

import UIKit
import MapKit

class StoreLocator: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var tableView: UITableView!
    let geoCoder = CLGeocoder()

    @IBOutlet var map: MKMapView!
    var locations: [Dictionary<String, Any>] = []
    
   // @IBOutlet var map: MKMapView
    @IBOutlet var locationTable: UITableView!
    let locationManager = CLLocationManager()
    var pointAnnotation: CustomAnnotation!
    var pinAnnotation: MKPinAnnotationView!
    var totalLocations = 0
    // MARK:- Lifecycle methodes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        loadPlist()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.title = "Store Locator"
        
    }
    
    // MARK:- Other methodes
    
    func setRegion(lat: Double, lon: Double)
    {
        
        let location = CLLocationCoordinate2D(latitude: lat,
                                              longitude: lon)
        
        let span = MKCoordinateSpanMake(1.02, 1.02)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)

    }
    
    func addAnnotation(lat: Double, lon: Double, name: String, address: String)
    {
        
        let location = CLLocationCoordinate2D(latitude: lat,
                                              longitude: lon)
        pointAnnotation = CustomAnnotation()
        pointAnnotation.img = "star_check"
        pointAnnotation.coordinate = location
        pointAnnotation.title = name
        pointAnnotation.subtitle = address
        pinAnnotation = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: "pin")
        map.addAnnotation(pinAnnotation.annotation!)

    }
    
    // Funcion to load data from plist
    func loadPlist()
    {
        
        if let file = Bundle.main.path(forResource: "locationList", ofType: "plist")
        {
            locations =  NSArray(contentsOfFile: file)! as! [Dictionary<String, Any>]
            print(locations)
           let locationForRegion = locations[0]
            setRegion(lat: locationForRegion["latitude"] as! Double, lon: locationForRegion["longitude"] as! Double)
        }
        
    }
    
    
//    // function to create location information from plist values
//    func loadData()
//    {
//        SVProgressHUD.show()
//        DispatchQueue.global().async(execute: {
//         self.loadPlist()
//        for i in 0..<self.locations.count
//        {
//            let locationValues = self.locations[i]
//            let lan = locationValues["longitude"]!
//            let lon = locationValues["latitude"]!
//            DispatchQueue.global().async(execute: {
//             self.reverseGeocoding(latitude: lan as! CLLocationDegrees, longitude: lon as! CLLocationDegrees)
//            })
//            if i == (self.locations.count - 1)
//            {
//                self.tableView.reloadData()
//            }
//                
//        self.addAnnotation(lat: lan as! Double, lon: lon as!  Double)
//        }
//       })
//        SVProgressHUD.dismiss()
//        
//    }
    
//    func reverseGeocoding(latitude: CLLocationDegrees, longitude: CLLocationDegrees)  {
//        //locName = ""
//               let location = CLLocation(latitude: latitude, longitude: longitude)
//        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
//            var placeMark: CLPlacemark!
//            placeMark = placemarks?[0]
//         
//            
//            if let locName = placeMark.addressDictionary!["Name"] as? NSString {
//                DispatchQueue.main.async(execute: {
//                    print("location name = \(locName)\n")
//                
//                })
//                
//            }
//        })
//    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        let customPointAnnotation = annotation as! CustomAnnotation
        annotationView?.image = UIImage(named: customPointAnnotation.img)
        
        return annotationView
    }
    
    // MARK:- TableVIew Methodes
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "store") as! StoreCell
        let location = locations[indexPath.row]
        cell.locationName.text = "\(String(describing: location["locName"]!))"
        cell.loctionAddress.text = "\(String(describing: location["address"]!))"
        addAnnotation(lat: location["latitude"] as! Double, lon: location["longitude"] as! Double,name: cell.locationName.text as! String, address: cell.loctionAddress.text as! String)
        return cell
    }
    

   
}
