//
//  Styles.swift
//  AutoLayout
//
//  Created by Lovre on 13/04/2021.
//

import Foundation
import UIKit

class Styles:NSObject{
    static let defaultColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    //MARGINE
    /*static let leadingMarginaOfComponents:CGFloat!
    static let topMarginOfComponents:CGFloat!
    static let middleMargin:CGFloat!
    static let topMarginOfTitle:CGFloat!
    static let iconPasswordInset:CGFloat!
    
    //DIMENZIJE
    static let widthOfComponents:CGFloat!
    static let heightOfComponents:CGFloat!
    static let heightOfTitle:CGFloat!*/
    
    //STILOVI
    static let mainColor:UIColor! = UIColor(red: 0.60, green: 0.35, blue: 0.86, alpha: 1.00)
    static let secondColor:UIColor! = .white
    static let secondColorLight:UIColor! = UIColor(red:1,green:1,blue:1,alpha:0.60)
    static let secondColorLighter:UIColor! = UIColor(red:1,green:1,blue:1,alpha:0.30)
    static let titleFont:UIFont! = UIFont.preferredFont(forTextStyle: .largeTitle)
    static let textFont:UIFont! = UIFont.preferredFont(forTextStyle: .body)
    static let subtitleFont:UIFont! = UIFont.preferredFont(forTextStyle: .title2)
}
