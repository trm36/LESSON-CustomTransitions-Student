//
//  DetailViewController.swift
//  FlippinCollectionView-CustomTransitions
//
//  Created by Taylor Mott on 04-Oct-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var colorInfoLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var color: Color?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = color?.uiColor ?? .black
        colorInfoLabel.text = color?.colorString
        idLabel.text = color?.id.uuidString
        dateLabel.text = color?.dateString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FlippinPresentAnimatedTransitionController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FlippinDismissAnimatedTransitionController()
    }
    
    @IBAction func tapGestureRecognizerActivated() {
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

