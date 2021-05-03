//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Lovre on 09/04/2021.
//
import PureLayout
import Foundation
import UIKit

class LoginViewController: UIViewController {
    //KOMPONENTE
    private var labelTitle: UILabel!
    private var textEmail:UITextField!
    private var textPassword:UITextField!
    private var buttonLogIn:UIButton!
    private var buttonPassword: UIButton!
    
    //MARGINE
    private var leadingMarginaOfComponents:CGFloat!
    private var topMarginOfComponents:CGFloat!
    private var middleMargin:CGFloat!
    private var topMarginOfTitle:CGFloat!
    private var iconPasswordInset:CGFloat!
    
    //DIMENZIJE
    private var widthOfComponents:CGFloat!
    private var heightOfComponents:CGFloat!
    private var heightOfTitle:CGFloat!
    
    //IKONE
    private var iconEye:UIImage!
    //PODACI
    private var email:String!
    private var password:String!
    private var dataService:DataService!
    private var loginStatus:LoginStatus!
    private var passwordVisible:Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    @objc private func logIn()->Void{
        dataService = DataService()
        email = textEmail.text
        password = textPassword.text
        loginStatus = dataService.login(email: email, password: password)
        print("Username:",email!,"Password",password!)
        switch loginStatus {
            case .error(let num, let message):
                print("\(message)")
                break
            case .success:
                let quizzesVc = QuizzesViewController()
                let settingsVc = SettingsViewController()
                let tabBarCon = UITabBarController()
                quizzesVc.tabBarItem = UITabBarItem(title: "Quizzes", image: .add, selectedImage: .actions)
                settingsVc.tabBarItem = UITabBarItem(title: "Settings", image: .actions, selectedImage: .actions)
                tabBarCon.viewControllers = [quizzesVc,settingsVc]
                let navCon = UINavigationController(rootViewController: tabBarCon)
                navCon.modalPresentationStyle = .fullScreen
                present(navCon, animated: true, completion: nil)
            default:break
        }
    }
    
    @objc private func passwordShowHide()->Void {
        if(passwordVisible){
            passwordVisible = false
            textPassword.isSecureTextEntry = true
        } else {
            passwordVisible = true
            textPassword.isSecureTextEntry = false
        }
    }
    
    private func buildViews(){
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    private func createViews(){
        labelTitle = UILabel()
        view.addSubview(labelTitle)
        
        
        textEmail = UITextField()
        view.addSubview(textEmail)
        
        textPassword = UITextField()
        view.addSubview((textPassword))
        
        buttonLogIn = UIButton()
        view.addSubview(buttonLogIn)
        buttonLogIn.addTarget(self, action:#selector(logIn), for: .touchUpInside)
        
        buttonPassword = UIButton()
        textPassword.addSubview(buttonPassword)
        buttonPassword.addTarget(self, action: #selector(passwordShowHide), for: .touchUpInside)
        

    }

    private func styleViews(){
        view.backgroundColor = Styles.mainColor
        
        labelTitle.text = "Quiz App"
        labelTitle.textColor = Styles.secondColor
        labelTitle.textAlignment = .center
        labelTitle.font = Styles.titleFont
        
        textPassword.backgroundColor = Styles.secondColorLighter
        textPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: Styles.secondColor!])
        textPassword.textColor = Styles.secondColor
        textPassword.isSecureTextEntry = true
        passwordVisible = false
        textPassword.borderStyle = UITextField.BorderStyle.roundedRect
        
        textEmail.backgroundColor = Styles.secondColorLighter
        textEmail.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: Styles.secondColor!])
        textEmail.textColor = Styles.secondColor
        textEmail.borderStyle = UITextField.BorderStyle.roundedRect
        
        buttonLogIn.backgroundColor = Styles.secondColorLight
        buttonLogIn.setTitleColor(Styles.mainColor, for: .normal)
        buttonLogIn.setBackgroundColor(Styles.secondColor, forState: .highlighted)
        buttonLogIn.setTitle("Log In", for: .normal)
        
        iconEye = UIImage(systemName: "eye")?.withTintColor(Styles.secondColor, renderingMode: .alwaysOriginal)
        buttonPassword.setImage(iconEye, for: .normal)
    }

    private func defineLayoutForViews(){
        
        //DIMENZIJE
        widthOfComponents = self.view.frame.size.width * 0.8
        heightOfComponents = 50
        heightOfTitle = 100
        
        labelTitle.autoSetDimensions(to: CGSize(width: widthOfComponents, height: heightOfTitle))
        textEmail.autoSetDimensions(to: CGSize(width: widthOfComponents, height: heightOfComponents))
        textPassword.autoSetDimensions(to: CGSize(width: widthOfComponents, height: heightOfComponents))
        buttonLogIn.autoSetDimensions(to: CGSize(width: widthOfComponents, height: heightOfComponents))
        buttonPassword.autoSetDimensions(to: CGSize(width: 26, height:22))
        
        //POLOYAJ
        leadingMarginaOfComponents = self.view.frame.size.width * 0.1
        middleMargin = 100
        topMarginOfComponents = 10
        topMarginOfTitle = 50
        iconPasswordInset = 8
        
        
        labelTitle.autoPinEdge(toSuperviewEdge: .leading, withInset:leadingMarginaOfComponents)
        labelTitle.autoPinEdge(toSuperviewEdge: .top, withInset: topMarginOfTitle)
        
        
        textEmail.autoPinEdge(.top, to: .bottom, of: labelTitle, withOffset: middleMargin)
        textEmail.autoPinEdge(toSuperviewEdge: .leading, withInset:leadingMarginaOfComponents)
        
        textPassword.autoPinEdge(.top, to: .bottom, of: textEmail, withOffset:topMarginOfComponents)
        textPassword.autoPinEdge(toSuperviewEdge: .leading, withInset:leadingMarginaOfComponents)
        
        buttonLogIn.autoPinEdge(.top, to: .bottom, of: textPassword, withOffset:topMarginOfComponents)
        buttonLogIn.autoPinEdge(toSuperviewEdge: .leading, withInset:leadingMarginaOfComponents)
        
        buttonPassword.autoPinEdge(toSuperviewEdge: .top, withInset:(heightOfComponents-22)/2)
        buttonPassword.autoPinEdge(toSuperviewEdge: .trailing, withInset:iconPasswordInset)
        
        
        
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        widthOfComponents = self.view.frame.size.width * 0.8
        leadingMarginaOfComponents = self.view.frame.size.width * 0.1
    }
    

}

