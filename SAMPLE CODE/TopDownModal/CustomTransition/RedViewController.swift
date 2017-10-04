//
//  ViewController.swift
//  CustomTransition
//
//  Created by Taylor Mott on 2/15/17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import UIKit

class RedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toBlue" {
            let navController = segue.destination as! UINavigationController
            navController.transitioningDelegate = navController.viewControllers.first as! BlueViewController
        }
        
    }


}

