//
//  GradientView.swift
//  ClaroChallenge
//
//  Created by Andre Luis Campopiano on 02/07/2018.
//  Copyright © 2018 Andre Luis Campopiano. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    // MARK: - Public properties
    
    @IBInspectable var startColor: UIColor = .clear
    @IBInspectable var endColor: UIColor = .black
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0, y: 0)
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0, y: 1)
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        guard let result = layer as? CAGradientLayer else {
            fatalError("Could not cast gradient layer")
        }
        return result
    }
    
    override func awakeFromNib() {
        defaultGradient()
    }
    
    // MARK: - Public Methdos
    
    /**
     Default Gradient Colors by target
     */
    func defaultGradient() {
        self.setGradientBackground([startColor, endColor], startPoint: startPoint, endPoint: endPoint)
        
    }
    
    /// This function creates a gradient with a startPoint and endPoint
    ///
    /// - parameter colors:     CGColor array of colors
    /// - parameter startPoint: CGPoint start point
    /// - parameter endPoint:   CGPoint end point
    func setGradientBackground(_ colors: [UIColor],
                               startPoint: CGPoint = CGPoint(x: 0.5, y: 0),
                               endPoint: CGPoint = CGPoint(x: 0.5, y: 1),
                               fullScreenRelated: Bool = false) {
        
        if fullScreenRelated {
            let gradientFullScreen = CAGradientLayer()
            gradientFullScreen.startPoint = startPoint
            gradientFullScreen.endPoint = endPoint
            gradientFullScreen.colors = colors.map({ (color) -> CGColor in return color.cgColor })
            
            let relativeFrame = gradientFullScreen.convert(super.frame, to: UIApplication.shared.keyWindow?.layer)
            
            gradientFullScreen.frame = UIApplication.shared.keyWindow?.frame ?? super.frame
            
            if relativeFrame.origin.y != gradientFullScreen.frame.origin.y {
                gradientFullScreen.frame.origin.y -= UIApplication.shared.statusBarFrame.height
            }
            
            gradientLayer.sublayers =  [gradientFullScreen]
            gradientLayer.masksToBounds = true
        } else {
            gradientLayer.startPoint = startPoint
            gradientLayer.endPoint = endPoint
            gradientLayer.colors = colors.map({ (color) -> CGColor in return color.cgColor })
        }
        
    }
}
