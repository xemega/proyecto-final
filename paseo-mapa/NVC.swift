//
//  NVC.swift
//  proyectp-final
//
//  Created by César Méndez on 31/01/16.
//  Copyright © 2016 César Méndez. All rights reserved.
//

import UIKit

class NVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        
            let origen = sender as! QrVc
            let vc = segue.destinationViewController as! NavegaVC
            origen.objCaptureSession?.stopRunning()
            vc.pagina = origen.urls
            
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
      
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
