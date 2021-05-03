//
//  QuizCellView.swift
//  QuizApp
//
//  Created by Lovre on 29/04/2021.
//

import Foundation
import UIKit

class QuizCellView: UITableViewCell{
    
    var labelTitle:UILabel = {
        let label = UILabel()
        label.textColor = Styles.secondColor
        return label
    }()
    
    var labelDescription:UILabel = {
        let label = UILabel()
        label.textColor = Styles.secondColor
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var imageQuiz:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    var viewLevel:LevelView = LevelView(frame: CGRect(x: 0, y: 0, width: 80, height: 30),levelOfQuestion:0)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)  {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Styles.secondColorLighter
        self.textLabel!.textColor = Styles.secondColor
        
        
        contentView.addSubview(labelTitle)
        contentView.addSubview(labelDescription)
        contentView.addSubview(imageQuiz)
        contentView.addSubview(viewLevel)
        
        //DIMENSIONS
        let widthOfComponents:CGFloat! = self.bounds.width
        let imageHeight:CGFloat! = 80
        let leftWidth:CGFloat! = 80
        let titleHeight:CGFloat! = 20
        let rightWidth:CGFloat! = widthOfComponents - leftWidth - 20
        let fullWidth:CGFloat! = widthOfComponents - 20
        let descriptionHeight:CGFloat! = 50
        let levelWidth:CGFloat! = 80
        
        imageQuiz.autoSetDimensions(to: CGSize(width: leftWidth, height: imageHeight))
        
        viewLevel.autoSetDimensions(to: CGSize(width: levelWidth, height: titleHeight))
        
        //POSITION
        let leadingMargin:CGFloat! = 10
        let HorizontalMiddleMargin:CGFloat! = 10
        let topMargin:CGFloat! = 10
        let verticalMiddleMargin:CGFloat! = 10
        
        labelTitle.autoPinEdge(toSuperviewEdge: .top, withInset: topMargin)
        labelTitle.autoPinEdge(toSuperviewEdge: .leading, withInset: leadingMargin)
        labelTitle.autoPinEdge(toSuperviewEdge: .trailing,withInset: leadingMargin)
        
        imageQuiz.autoPinEdge(.top, to: .bottom, of: labelTitle, withOffset: verticalMiddleMargin)
        imageQuiz.autoPinEdge(toSuperviewEdge: .leading, withInset: leadingMargin)
    
        labelDescription.autoPinEdge(.top, to: .bottom, of: labelTitle, withOffset: verticalMiddleMargin)
        labelDescription.autoPinEdge(.leading, to: .trailing, of: imageQuiz, withOffset: HorizontalMiddleMargin)
        labelDescription.autoPinEdge(toSuperviewEdge: .trailing, withInset: leadingMargin)
        
        viewLevel.autoPinEdge(.top, to: .bottom, of: labelDescription, withOffset: verticalMiddleMargin)
        viewLevel.autoPinEdge(toSuperviewEdge: .leading, withInset: (widthOfComponents-levelWidth)/2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
    
    
}


