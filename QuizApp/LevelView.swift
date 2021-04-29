//
//  LevelView.swift
//  QuizApp
//
//  Created by Lovre on 14/04/2021.
//

import Foundation
import UIKit

class LevelView: UIView{
    
    
    private var level:Int
    var label:UILabel!
    
    init(frame: CGRect, levelOfQuestion:Int){
        level = levelOfQuestion
        super.init(frame: frame)
        
        label.textColor = Styles.secondColor
        label.textColor = Styles.secondColor
        self.addSubview(label)
        self.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.autoPinEdge(toSuperviewEdge: .leading)
        label.autoPinEdge(toSuperviewEdge: .top)
    }
    
    func setLevel(levelOfQuestion:Int){
        level = levelOfQuestion
        self.showLevel()
    }
    
    private func showLevel(){
        switch level{
        case 1:
            label.text = "X O O"
            break
        case 2:
            label.text = "X X O"
            break
        case 3:
            label.text = "X X X"
            break
        default:
            label.text = "-----"
            break
        }
    }
}
