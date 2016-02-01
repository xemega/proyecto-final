//
//  NavegaVC.swift
//  proyectp-final
//
//  Created by César Méndez on 31/01/16.
//  Copyright © 2016 César Méndez. All rights reserved.
//

import UIKit

class NavegaVC: UIViewController {
    
    var pagina : String?

    @IBOutlet weak var navegador: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: pagina!)
        let peticion = NSURLRequest(URL: url!)
        
        navegador.loadRequest(peticion)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
