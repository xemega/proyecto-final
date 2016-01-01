//
//  ViewController.swift
//  paseo-mapa
//
//  Created by César Méndez on 31/12/15.
//  Copyright © 2015 César Méndez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    
    @IBOutlet weak var btnEstandar: UIButton!
    
    @IBOutlet weak var btnSatelital: UIButton!
    
    @IBOutlet weak var btnHibrido: UIButton!
    
    private var manejador = CLLocationManager()
    
    var zoom = 0.0028
    
    var distanciaActual : Double = 0.0
    
    var anteriorLocation : CLLocation! = nil
    
    var ultimoLocation : CLLocation! = nil
    
    var distancia : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manejador.delegate = self
        manejador.desiredAccuracy = kCLLocationAccuracyBest
        manejador.requestWhenInUseAuthorization()
        
        
        mapa.zoomEnabled = true
        mapa.setCenterCoordinate(mapa.userLocation.coordinate, animated: true)

        
    }

    
    @IBAction func accionEstandar(sender: AnyObject) {
        
        self.mapa.mapType = .Standard
    }
    
    @IBAction func accionSatelital(sender: AnyObject) {
        self.mapa.mapType = .Satellite
    }
    
    @IBAction func accionHibrido(sender: AnyObject) {
        self.mapa.mapType = .Hybrid
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse
        {
            manejador.startUpdatingLocation()
            mapa.showsUserLocation = true
        }
        else
        {
            manejador.stopUpdatingLocation()
            mapa.showsUserLocation = false
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let center = CLLocationCoordinate2D(latitude: (manager.location?.coordinate.latitude)!, longitude: (manager.location?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: zoom, longitudeDelta: zoom))
        mapa.setRegion(region, animated: true)
        
        
        
        let actualLocation = CLLocation(latitude: (manager.location?.coordinate.latitude)!, longitude: (manager.location?.coordinate.longitude)!)
        
     
        
        if anteriorLocation == nil {
        ultimoLocation = CLLocation(latitude: (manager.location?.coordinate.latitude)!, longitude: (manager.location?.coordinate.longitude)!)
            distanciaActual = 0
            
            var punto = CLLocationCoordinate2D()
            punto.latitude =  (manager.location?.coordinate.latitude)!
            punto.longitude =         (manager.location?.coordinate.longitude)!

            let titulo : String = String(format: "Latitud: %.4f  Longitud: %.4f)", arguments: [punto.latitude, punto.longitude])
            
            let distancia : String = String(format: "Distancia actual: %.2f Mt", arguments: [distanciaActual])
            
            let pin = MKPointAnnotation()
            pin.title = titulo
            pin.subtitle = distancia
            pin.coordinate = punto
            mapa.addAnnotation(pin)
        }
        else
        {
            
            distancia = actualLocation.distanceFromLocation(anteriorLocation)
            distanciaActual = distanciaActual + distancia
            
             if actualLocation.distanceFromLocation(ultimoLocation ) > 50 {
                
                var punto = CLLocationCoordinate2D()
                punto.latitude =  (manager.location?.coordinate.latitude)!
                punto.longitude =         (manager.location?.coordinate.longitude)!

                
                
                let titulo : String = String(format: "Latitud: %.4f  Longitud: %.4f)", arguments: [punto.latitude, punto.longitude])
                
                let distancia : String = String(format: "Distancia actual: %.2f Mt", arguments: [distanciaActual])
                
                let pin = MKPointAnnotation()
                pin.title = titulo
                pin.subtitle = distancia
                pin.coordinate = punto
                mapa.addAnnotation(pin)
                
                ultimoLocation = CLLocation(latitude: (manager.location?.coordinate.latitude)!, longitude: (manager.location?.coordinate.longitude)!)
                
                
            }
            
            
        }
        
        anteriorLocation = CLLocation(latitude: (manager.location?.coordinate.latitude)!, longitude: (manager.location?.coordinate.longitude)!)
       
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
       
        let alerta = UIAlertController(title: "Error", message: "error \(error.code)", preferredStyle: .Alert)
        let accionOK = UIAlertAction(title: "Ok", style: .Default, handler: {accion in })
        alerta.addAction(accionOK)
        self.presentViewController(alerta, animated: true, completion: nil)    }


}

