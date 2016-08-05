//
//  EventDetailsViewController.swift
//  Discovol
//
//  Created by Carol Zhang on 8/3/16.
//  Copyright © 2016 Carol Zhang. All rights reserved.
//

import Foundation
import MapKit

class EventDetailsViewController: UIViewController, MKMapViewDelegate {
    
    var event: VolunteerEvent!
    
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var dealsImage: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
    var userLocation: UserLocation = UserLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = event.name
        
        self.addressLabel.text = self.event.displayAddress
        self.categoriesLabel.text = self.event.displayCategories
        
        let distance = self.event.location.distanceFromLocation(self.userLocation.location)
        self.distanceLabel.text = String(format: "%.1f mi", distance / 1609.344)
        self.distanceLabel.sizeToFit()
        
        
        self.mapView.delegate = self
        let annotation = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2D(latitude: self.event.latitude!, longitude: self.event.longitude!)
        annotation.setCoordinate(coordinate)
        self.mapView.addAnnotation(annotation)
        self.mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpanMake(0.01, 0.01)), animated: false)
        self.mapView.layer.cornerRadius = 9.0
        self.mapView.layer.masksToBounds = true
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        var view = mapView.dequeueReusableAnnotationViewWithIdentifier("pin") as? MKPinAnnotationView
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            view!.canShowCallout = false
        }
        return view
    }
}