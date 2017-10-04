//
//  Color.swift
//  FlippinCollectionView-CustomTransitions
//
//  Created by Taylor Mott on 04-Oct-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import UIKit

struct Color {
    
    var id = UUID()
    var uiColor: UIColor
    var dateString: String
    var colorString: String
    
    init() {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        uiColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .long
        
        dateString = dateFormatter.string(from: Date())
        
        var red = CGFloat()
        var green = CGFloat()
        var blue = CGFloat()
        
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        let redInt = Int(red * 255.0)
        let greenInt = Int(green * 255.0)
        let blueInt = Int(blue * 255.0)
        
        colorString = "R: \(redInt) \nG: \(greenInt) \nB: \(blueInt)"
    }
}
