//
//  ViewController.swift
//  Landmarks
//
//  Created by Himaja Motheram on 4/13/17.
//  Copyright © 2017 Sriram Motheram. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate  {

    @IBOutlet weak var mapView: MKMapView!
    
    var LandmarksArray  = [Landmark]()
    
    var locationMgr = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupLocationMonitoring() {
        locationMgr.delegate = self
        locationMgr.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                turnOnLocationMonitoring()
            case .denied, .restricted:
                print("Hey turn us back on in Settings!")
            case .notDetermined:
                if locationMgr.responds(to: #selector(CLLocationManager.requestAlwaysAuthorization)) {
                    locationMgr.requestAlwaysAuthorization()
                }
            }
        } else {
            print("Hey Turn Location On in Settings!")
        }
    }
    
    func buildArray() {
        
       // (name: String, street_addr :String, city :String,state :String,zip :String,brief_descr     :String,latitude :Double,longitude :Double )
     /*   let loc1 = Landmark(name: "Waterfront", street_addr: "Wow it's nice",city: "city",state:"state",zip:"48187",brief_descr:"descr", latitude: 42, longitude: -83)
        let loc2 = Landmark(name: "Somewhere Someplace", street_addr: "Who knows", city: "city",state:"state",zip:"48187",brief_descr:"descr",latitude: 42.123, longitude: -83.123)
        let loc3 = Landmark(name: "I Wonder Where", street_addr: "I hope this works",city: "city",state:"state",zip:"48187",brief_descr:"descr", latitude: 42.234, longitude: -83.234)*/
        
        
        let loc1 = Landmark(name: "Detroit Institute of Arts", street_addr: "5200 Woodward Avenue",city: "Detroit",state:"MI",zip:"48202-4094",brief_descr:"Official site: http://www.dia.org/", latitude: 42.358742,longitude: -83.063754)
        let loc2 = Landmark(name: "Comerica Park", street_addr: "2100 Woodward Avenue", city: "Detroit",state:"MI",zip:"48201-3470",brief_descr:"Official site: http://detroit.tigers.mlb.com/det/ballpark/",latitude: 42.3677736,longitude: -83.4172997)
        
        let loc3 = Landmark(name: "Motown Museum", street_addr: "2648 West Grand Boulevard",city: "Detroit",state:"MI",zip:"48208-1237",brief_descr:"descr", latitude: 42.3644374,longitude: -83.0885255)
 
 
        let loc4 = Landmark(name: "Charles H. Wright Museum of African-American History", street_addr: "315 East Warren Avenue",city: "Detroit",state:"MI",zip:"48201-1443",brief_descr:"Official site: http://thewright.org/", latitude: 42.359002,longitude: -83.0632329)
 
        let loc5 = Landmark(name: "The Henry Ford Museum & Greenfield Village", street_addr: "20900 Oakwood Boulevard",city: "Dearborn",state:"MI",zip:"48202-4097",brief_descr:"Official site: http://www.thehenryford.org/village/index.aspx"
, latitude: 42.3002454,longitude: -83.2355048)
        
        let loc6 = Landmark(name: "Detroit Historical Museum", street_addr: "5401 Woodward Avenue",city: "Detroit",state:"MI",zip:"48124-4088",brief_descr:"Official site: http://detroithistorical.org/"
            , latitude: 42.3597913,longitude: -83.0693924)
        
        
        let loc7 = Landmark(name: "Detroit Public Library", street_addr: "5201 Woodward Avenue",city: "Detroit",state:"MI",zip:"48202-4093",brief_descr:"Official site: http://www.detroit.lib.mi.us/"
            , latitude: 42.3585466,longitude: -83.0688028)
        
        let loc8 = Landmark(name: "Masonic Temple of Detroit", street_addr: "500 Temple Avenue",city: "Detroit",state:"MI",zip:"48201-2693",brief_descr:"Official site: http://themasonic.com/"
            , latitude: 42.3415082,longitude: -83.0596134)
        
        let loc9 = Landmark(name: "Historic Fort Wayne", street_addr: "6325 West Jefferson",city: "Detroit",state:"MI",zip:"48201-2693",brief_descr:"Official site: http://www.historicfortwaynecoalition.com/"
            , latitude: 42.2993647,longitude: -83.0981986)
        
        let loc10 = Landmark(name: "Pewabic Pottery", street_addr: "10125 East Jefferson Avenue",city: "Detroit",state:"MI",zip:"48214",brief_descr:"Official site: http://www.pewabic.org/"
            , latitude: 42.3620531,longitude: -82.9838825)

        
        LandmarksArray = [loc1, loc2, loc3,loc4,loc5,loc6,loc7,loc8,loc9,loc10]
        
    }
    
    func annotateMapLocations() {
        var pinsToRemove = [MKPointAnnotation]()
        for annotation in mapView.annotations {
            if annotation is MKPointAnnotation {
                pinsToRemove.append(annotation as! MKPointAnnotation)
            }
        }
        mapView.removeAnnotations(pinsToRemove)
        
        for Landmark in LandmarksArray {
            let pa = MKPointAnnotation()
            pa.title = Landmark.name
            pa.subtitle = Landmark.street_addr
            pa.coordinate = CLLocationCoordinate2D(latitude: Landmark.latitude, longitude: Landmark.longitude)
            mapView.addAnnotation(pa)
        }
              zoomToPins()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLocationMonitoring()
        buildArray()
        annotateMapLocations()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLoc = locations.last!
        print("Last Loc: \(lastLoc.coordinate.latitude),\(lastLoc.coordinate.longitude)")
        zoomToLocation(lat: lastLoc.coordinate.latitude, lon: lastLoc.coordinate.longitude, radius: 500)
        manager.stopUpdatingLocation()
    }
    
    func turnOnLocationMonitoring() {
        locationMgr.startUpdatingLocation()
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        setupLocationMonitoring()
    }


    func zoomToLocation(lat: Double, lon: Double, radius: Double) {
        if lat == 0 && lon == 0 {
            print("Invalid Data")
        } else {
            let coord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let viewRegion = MKCoordinateRegionMakeWithDistance(coord, radius, radius)
            let adjustedRegion = mapView.regionThatFits(viewRegion)
            mapView.setRegion(adjustedRegion, animated: true)
        }
    }
    
    func zoomToPins() {
        mapView.showAnnotations(mapView.annotations, animated: true)
    }

}

