//
//  DropShadow.swift
//  Clouds
//
//  Created by Madison Waters on 10/23/19.
//  Copyright © 2019 EmPact. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setViewShadow(color: UIColor?, opacity: Float?, offset: CGSize?, radius: CGFloat, viewCornerRadius: CGFloat?) {
        layer.shadowColor = color?.cgColor ?? UIColor.black.cgColor
        layer.shadowOpacity = opacity ?? 1.0
        layer.shadowOffset = offset ?? CGSize.zero
        layer.shadowRadius = radius
        layer.cornerRadius = viewCornerRadius ?? 0
    }
    
    func setCellViewShadow() {
        layer.cornerRadius = 10
        layer.shadowOpacity = 1
        layer.shadowRadius = 2
        layer.shadowColor = UIColor(named: "Orange")?.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        backgroundColor = UIColor(named: "Red")
    }
}

extension UIView{
    func dropShadow(shadowColor: UIColor = UIColor.black,
                    fillColor: UIColor = UIColor.white,
                    opacity: Float = 0.2,
                    offset: CGSize = CGSize(width: 0.0, height: 1.0),
                    radius: CGFloat = 10) -> CAShapeLayer {
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath
        shadowLayer.fillColor = fillColor.cgColor
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = offset
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = radius
        layer.insertSublayer(shadowLayer, at: 0)
        return shadowLayer
    }
}

extension UITableViewCell {
    func setCellDropShadow(cell: UITableViewCell, color: UIColor?, opacity: Float?, offset: CGSize?, radius: CGFloat, viewCornerRadius: CGFloat?) {
//        cell.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: viewCornerRadius ?? 0.0).cgPath
//        cell.layer.shadowColor = color?.cgColor ?? UIColor.black.cgColor
//        cell.layer.shadowOpacity = opacity ?? 1.0
//        cell.layer.shadowOffset = offset ?? CGSize.zero
//        cell.layer.shadowRadius = radius
        
        
        cell.contentView.layer.cornerRadius = 2.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = offset ?? CGSize.zero
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: viewCornerRadius ?? 0.0).cgPath
            
            
            //[UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].cgPath
    }
}

extension UITableViewCell {
    func setCellShadow(cell: UITableViewCell,
                       shadowColor: UIColor = UIColor.black,
                       fillColor: UIColor = UIColor.white,
                       opacity: Float = 0.2,
                       offset: CGSize = CGSize(width: 0.0, height: 1.0),
                       radius: CGFloat = 10) -> CAShapeLayer {
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath
        shadowLayer.fillColor = fillColor.cgColor
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = offset
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = radius
        layer.insertSublayer(shadowLayer, at: 0)
        return shadowLayer
    }
    
}

extension UIStackView { // This only sets the shadow on the text
    func setStackShadow(color: UIColor?, opacity: Float?, offset: CGSize?, radius: CGFloat, viewCornerRadius: CGFloat?) {
        //layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: viewCornerRadius ?? 0.0).CGPath
        layer.shadowColor = color?.cgColor ?? UIColor.black.cgColor
        layer.shadowOpacity = opacity ?? 1.0
        layer.shadowOffset = offset ?? CGSize.zero
        layer.shadowRadius = radius
    }
}

extension UILabel { // This only sets the shadow on the text
    func setLabelShadow(color: UIColor?, opacity: Float?, offset: CGSize?, radius: CGFloat, viewCornerRadius: CGFloat?) {
        //layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: viewCornerRadius ?? 0.0).CGPath
        layer.shadowColor = color?.cgColor ?? UIColor.black.cgColor
        layer.shadowOpacity = opacity ?? 1.0
        layer.shadowOffset = offset ?? CGSize.zero
        layer.shadowRadius = radius
    }
}
