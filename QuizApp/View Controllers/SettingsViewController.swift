//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by Lovre on 01/05/2021.
//

import Foundation
import UIKit
import PureLayout

class SettingsViewController: UIViewController{
    
    private let labelUsername:UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.textColor = Styles.secondColor
        label.font = Styles.textFont
        return label
    }()
    
    private let labelMyUsername:UILabel = {
        let label = UILabel()
        label.text = "labelMyUsername"
        label.textColor = Styles.secondColor
        label.font = Styles.subtitleFont
        return label
    }()
    
    private let buttonLogOut:UIButton = {
        let button = UIButton()
        button.backgroundColor = Styles.secondColorLight
        button.setTitleColor(Styles.mainColor, for: .normal)
        button.setBackgroundColor(Styles.secondColor, forState: .highlighted)
        button.setTitle("Log Out", for: .normal)
        button.addTarget(self, action:#selector(logOut), for: .touchUpInside)
        return button
    }()
    
    private var leadingMargin:CGFloat!
    private var topMargin:CGFloat = 10
    private var titleMargin:CGFloat = 50
    private var heightOfComponents:CGFloat = 50
    private var widthOfComponents:CGFloat!
    
    @objc
    private func logOut()->Void{
        dismiss(animated: false, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Styles.mainColor
        view.addSubview(labelUsername)
        view.addSubview(labelMyUsername)
        view.addSubview(buttonLogOut)
        
        leadingMargin = view.frame.size.width * 0.1
        widthOfComponents = self.view.frame.size.width * 0.8
        
        labelUsername.autoPinEdge(toSuperviewEdge: .leading,withInset: leadingMargin)
        labelUsername.autoPinEdge(toSuperviewEdge: .top,withInset: titleMargin)
        
        labelMyUsername.autoPinEdge(.top, to: .bottom, of: labelUsername,withOffset: topMargin)
        labelMyUsername.autoPinEdge(toSuperviewEdge: .leading,withInset: leadingMargin)
        
        buttonLogOut.autoPinEdge(toSuperviewEdge: .leading,withInset: leadingMargin)
        buttonLogOut.autoPinEdge(toSuperviewEdge: .trailing,withInset: leadingMargin)
        buttonLogOut.autoPinEdge(.top, to: .bottom, of: labelMyUsername,withOffset: topMargin)
        buttonLogOut.autoSetDimensions(to: CGSize(width: widthOfComponents, height: heightOfComponents))
    }
    
    override func viewDidLayoutSubviews() {
        leadingMargin = view.frame.size.width * 0.1
        widthOfComponents = view.frame.size.width * 0.8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}
