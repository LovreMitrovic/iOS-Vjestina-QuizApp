//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Lovre on 02/05/2021.
//

import Foundation
import PureLayout
import UIKit

class QuizViewController:UIViewController {
    
    var quiz:Quiz!
    private var index:Int = -1
    private var correct:Int = 0
    
    private let labelCurrent:UILabel = {
        let label = UILabel()
        label.text = "labelCurrent"
        label.textAlignment = .center
        label.textColor = Styles.secondColor
        label.font = Styles.subtitleFont
        return label
    }()
    
    private let labelQuestion:UILabel = {
        let label = UILabel()
        label.text = "labelQuestion"
        label.textAlignment = .center
        label.textColor = Styles.secondColor
        label.font = Styles.textFont
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let buttonsAnswear:[UIButton] = {
        var list:[UIButton] = []
        for i in 0...3{
            let button = UIButton()
            button.backgroundColor = Styles.secondColorLight
            button.setTitleColor(Styles.mainColor, for: .normal)
            button.setBackgroundColor(Styles.secondColor, forState: .highlighted)
            button.setTitle("Button "+String(i), for: .normal)
            button.tag = i
            button.addTarget(self, action:#selector(answearSelected), for: .touchUpInside)
            list.append(button)
        }
        return list
    }()
    
    private let progressBar:QuestionTrackerView = {
        let bar = QuestionTrackerView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        return bar
        
    }()
    
    private var leadingMargin:CGFloat!
    private var titleMargin:CGFloat = 90
    private var topMargin:CGFloat = 10
    private var heightOfComponents:CGFloat = 50
    private var widthOfComponents:CGFloat!
    
    @objc private func answearSelected(sender:UIButton) -> Void{
        if (sender.tag == quiz.questions[index].correctAnswer){
            progressBar.nextStep(correct: true)
            correct = correct + 1
        } else {
            progressBar.nextStep(correct: false)
        }
        //sleep(3)
        nextQuestion()
        return
    }
    
    private func nextQuestion() -> Void{
        index = index + 1
        if(index == quiz.questions.count){
            let resultVc = QuizResultViewController()
            resultVc.setResult(numOfCorrect: correct, numOfSum: quiz.questions.count)
            self.navigationController?.pushViewController(resultVc, animated: true)
            return
        }
        labelCurrent.text = String(index+1)+"/"+String(quiz.questions.count)
        labelQuestion.text = quiz.questions[index].question
        for i in 0...3{
            buttonsAnswear[i].setTitle(quiz.questions[index].answers[i], for: .normal)
            buttonsAnswear[i].backgroundColor = Styles.secondColorLight
            if(quiz.questions[index].correctAnswer == i){
                buttonsAnswear[i].setBackgroundColor(Styles.correctColor, forState: .highlighted)
            } else {
                buttonsAnswear[i].setBackgroundColor(Styles.wrongColor, forState: .highlighted)
            }
        }
        return
    }
    
    override func viewDidLoad() {
        view.backgroundColor = Styles.mainColor
        view.addSubview(labelCurrent)
        view.addSubview(labelQuestion)
        view.addSubview(progressBar)
        for button in buttonsAnswear{
            view.addSubview(button)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:"Back" ,style:.done, target:self, action: #selector(backToQuizzes))
        let labelTitle = UILabel()
        labelTitle.text = "Quiz"
        labelTitle.textColor = Styles.secondColor
        navigationItem.titleView = labelTitle
        
        self.navigationController?.navigationBar.tintColor = Styles.secondColor
        self.navigationController?.navigationBar.barTintColor = Styles.mainColor
        
        leadingMargin = view.frame.size.width * 0.1
        widthOfComponents = view.frame.size.width * 0.8
        
        labelCurrent.autoPinEdge(toSuperviewEdge: .top,withInset: titleMargin)
        labelCurrent.autoPinEdge(toSuperviewEdge: .leading,withInset: leadingMargin)
        
        progressBar.autoPinEdge(toSuperviewEdge: .leading,withInset: leadingMargin)
        progressBar.autoPinEdge(toSuperviewEdge: .trailing,withInset: leadingMargin)
        progressBar.autoPinEdge(.top, to: .bottom, of: labelCurrent,withOffset: topMargin)
        progressBar.autoSetDimensions(to: CGSize(width:widthOfComponents,height: 20))
        progressBar.setNumberOfQuestions(numOfQuestions: quiz.questions.count)
        
        labelQuestion.autoPinEdge(.top, to: .bottom, of: progressBar,withOffset: topMargin)
        labelQuestion.autoPinEdge(toSuperviewEdge: .leading,withInset: leadingMargin)
        labelQuestion.autoPinEdge(toSuperviewEdge: .trailing,withInset: leadingMargin)
        
        var prev = labelQuestion as UIView
        var cur:UIButton!
        for i in 0...3{
            cur = buttonsAnswear[i]
            cur.autoPinEdge(.top, to: .bottom, of: prev,withOffset:topMargin)
            cur.autoPinEdge(toSuperviewEdge: .leading,withInset: leadingMargin)
            cur.autoPinEdge(toSuperviewEdge: .trailing,withInset: leadingMargin)
            cur.autoSetDimensions(to: CGSize(width: widthOfComponents, height: heightOfComponents))
            prev = cur
        }
        nextQuestion()
    }
    
    override func viewDidLayoutSubviews() {
        leadingMargin = view.frame.size.width * 0.1
        widthOfComponents = view.frame.size.width * 0.8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc func backToQuizzes(){
        navigationController?.popViewController(animated: false)
    }
    
}
