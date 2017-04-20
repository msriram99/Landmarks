//
//  Landmark.swift
//  Landmarks
//
//  Created by Himaja Motheram on 4/13/17.
//  Copyright © 2017 Sriram Motheram. All rights reserved.
//

import UIKit

class Landmark: NSObject{
    
   // name, street address, city, state, zip, latitude, longitude, and a brief description
    
    
    var name          :String!
    var street_addr         :String!
    var city         :String!
    var state         :String!
    var  zip          :String!
    var brief_descr     :String!
    var latitude         :Double!
    var longitude        :Double!
  
    
    
   convenience init(name: String, street_addr :String, city :String,state :String,zip :String,brief_descr     :String,latitude :Double,longitude :Double ) {
        
        self.init( )
        self.name = name
        self.street_addr = street_addr
        self.city = city
        self.state = state
        self.zip = zip
        self.brief_descr = brief_descr
        self.latitude = latitude
        self.longitude = longitude
    

    }
    
    
    

var subtitle: String {
    return name
}
    
}


