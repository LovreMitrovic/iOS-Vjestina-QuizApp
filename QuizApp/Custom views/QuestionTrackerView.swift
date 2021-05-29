//
//  QuestionTrackerView.swift
//  QuizApp
//
//  Created by Lovre on 02/05/2021.
//

import Foundation
import UIKit

class QuestionTrackerView:UIStackView{
    
    var numberOfQuestions:Int!
    var index:Int = 0
    var currentColor:UIColor = .white
    var correctColor:UIColor = .green
    var wrongColor:UIColor = .red
    var defaultColor:UIColor = .lightGray
    
    private var dotts:[UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        axis = .horizontal
        distribution = .fillEqually
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNumberOfQuestions(numOfQuestions:Int){
        numberOfQuestions = numOfQuestions
        createSubviews()
    }
    
    func nextStep(correct:Bool){
        if(correct){
            dotts[index].backgroundColor = correctColor
        } else {
            dotts[index].backgroundColor = wrongColor
        }
        index = index + 1
        if (index < numberOfQuestions){
            dotts[index].backgroundColor = currentColor
        }
    }
    
    private func createSubviews(){
        for i in 0..<numberOfQuestions{
            let dot = UIView()
            if(i == 0){
                dot.backgroundColor = currentColor
            } else{
                dot.backgroundColor = defaultColor
            }
            dotts.append(dot)
            addArrangedSubview(dotts[i])
        }
    }
    
}
