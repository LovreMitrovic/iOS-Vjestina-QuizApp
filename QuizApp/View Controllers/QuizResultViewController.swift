//
//  QuizResultViewController.swift
//  QuizApp
//
//  Created by Lovre on 02/05/2021.
//

import Foundation
import PureLayout
import UIKit

class QuizResultViewController: UIViewController{
    
    private let labelResult:UILabel = {
        let label = UILabel()
        label.text = "x/y"
        label.textAlignment = .center
        label.textColor = Styles.secondColor
        label.font = Styles.titleFont
        return label
    }()
    
    private let buttonFinish:UIButton = {
        let button = UIButton()
        button.backgroundColor = Styles.secondColorLight
        button.setTitleColor(Styles.mainColor, for: .normal)
        button.setBackgroundColor(Styles.secondColor, forState: .highlighted)
        button.setTitle("Finish", for: .normal)
        button.addTarget(self, action:#selector(finish), for: .touchUpInside)
        return button
    }()
    
    private var leadingMargin:CGFloat!
    private var topMargin:CGFloat = 50
    private var titleMargin:CGFloat = 50
    private var heightOfComponents:CGFloat = 50
    private var widthOfComponents:CGFloat!
    
    @objc
    private func finish() -> Void{
        navigationController?.popToRootViewController(animated: false)
    }
    
    func setResult(numOfCorrect:Int, numOfSum:Int){
        labelResult.text = "\(numOfCorrect) / \(numOfSum)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Styles.mainColor
        view.addSubview(labelResult)
        view.addSubview(buttonFinish)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:nil ,style:.done, target:self, action: nil)
        let labelTitle = UILabel()
        labelTitle.text = "Results"
        labelTitle.textColor = Styles.secondColor
        navigationItem.titleView = labelTitle
        
        leadingMargin = view.frame.size.width * 0.1
        widthOfComponents = view.frame.size.width * 0.8
        
        buttonFinish.autoPinEdge(toSuperviewEdge: .leading,withInset: leadingMargin)
        buttonFinish.autoPinEdge(toSuperviewEdge: .trailing,withInset: leadingMargin)
        buttonFinish.autoAlignAxis(toSuperviewAxis: .horizontal)
        buttonFinish.autoSetDimensions(to: CGSize(width: widthOfComponents, height: heightOfComponents))
        
        labelResult.autoPinEdge(toSuperviewEdge: .leading,withInset: leadingMargin)
        labelResult.autoPinEdge(toSuperviewEdge: .trailing,withInset: leadingMargin)
        labelResult.autoPinEdge(.bottom, to: .top, of: buttonFinish,withOffset: -topMargin)
        labelResult.autoSetDimensions(to: CGSize(width: widthOfComponents, height: heightOfComponents))
    }
    
    override func viewDidLayoutSubviews() {
        leadingMargin = view.frame.size.width * 0.1
        widthOfComponents = view.frame.size.width * 0.8
    }
    
}
