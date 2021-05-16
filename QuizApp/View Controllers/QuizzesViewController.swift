//
//  QuizzesViewController.swift
//  AutoLayout
//
//  Created by Lovre on 13/04/2021.
//

import PureLayout
import Foundation
import UIKit

class QuizzesViewController: UIViewController, UITableViewDelegate {
    //KOMPONENTE
    private var labelTitle: UILabel!
    private var labelFunFact: UILabel!
    private var labelNBA: UILabel!
    private var buttonGetQuizzes:UIButton!
    private var viewOfQuizzes:UITableView!
    
    //MARGINE
    private var leadingMarginaOfComponents:CGFloat!
    private var topMarginOfComponents:CGFloat!
    private var middleMargin:CGFloat!
    private var topMarginOfTitle:CGFloat!
    private var iconPasswordInset:CGFloat!
    private var smallMargin:CGFloat!
    
    //DIMENZIJE
    private var widthOfComponents:CGFloat!
    private var heightOfComponents:CGFloat!
    private var heightOfTitle:CGFloat!
    private var heightOneLiner:CGFloat!
    private var heightOfCell:CGFloat!
    
    //PODACI
    var quizzes:[[Quiz]]! = []
    private var numOfNBA:Int!
    private var allCategories:[QuizCategory]!
    
    
    private var router:AppRouter!
    private var quizzesPresenter:QuizzesPresenter!
    
    init(router: AppRouter){
        super.init(nibName: nil, bundle: nil)
        self.router = router
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func getQuizzes()->Void{
        quizzes = []
        quizzesPresenter = QuizzesPresenter(viewController: self)
        DispatchQueue.global(qos: .userInitiated).sync {
            quizzesPresenter.fetchQuizzes()
        }
        showQuizzes()
    }
    
    private func showQuizzes(){
        labelFunFact = UILabel()
        view.addSubview(labelFunFact)
        labelNBA = UILabel()
        view.addSubview(labelNBA)
        viewOfQuizzes = UITableView()
        view.addSubview(viewOfQuizzes)
        viewOfQuizzes.register(QuizCellView.self, forCellReuseIdentifier: "QuizCell")
        viewOfQuizzes.dataSource = self
        viewOfQuizzes.delegate = self
        
        
        labelFunFact.text = "Fun Fact"
        labelFunFact.textColor = Styles.secondColor
        numOfNBA = countInQuizzes(word:"NBA")
        labelNBA.text = "There are "+String(numOfNBA)+" questions that contain the word \"NBA\" "
        labelNBA.textColor = Styles.secondColor
        labelNBA.font = Styles.textFont
        labelNBA.lineBreakMode = .byWordWrapping
        labelNBA.preferredMaxLayoutWidth = widthOfComponents
        labelNBA.numberOfLines = 0
        viewOfQuizzes.backgroundColor = Styles.mainColor
        viewOfQuizzes.rowHeight = heightOfCell
        
        labelFunFact.autoPinEdge(.top, to: .bottom, of: buttonGetQuizzes, withOffset:topMarginOfComponents)
        labelFunFact.autoPinEdge(toSuperviewEdge: .leading,withInset:leadingMarginaOfComponents)
        labelNBA.autoPinEdge(.top, to: .bottom, of: labelFunFact, withOffset:smallMargin)
        labelNBA.autoPinEdge(toSuperviewEdge: .leading,withInset:leadingMarginaOfComponents)
        viewOfQuizzes.autoPinEdge(.top, to: .bottom, of: labelNBA,withOffset: smallMargin)
        viewOfQuizzes.autoPinEdge(toSuperviewEdge: .leading, withInset: leadingMarginaOfComponents)
        
        let minusHeight = 2 * (topMarginOfComponents + heightOfComponents + smallMargin)
        let heightOfTableView:CGFloat = self.view.frame.height - topMarginOfTitle - heightOfTitle - heightOneLiner - minusHeight
        
        labelFunFact.autoSetDimensions(to: CGSize(width: widthOfComponents, height: heightOneLiner))
        labelNBA.autoSetDimensions(to: CGSize(width: widthOfComponents, height: heightOfComponents))
        viewOfQuizzes.autoSetDimensions(to: CGSize(width: widthOfComponents, height: heightOfTableView))
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func buildViews(){
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    private func createViews(){
        labelTitle = UILabel()
        view.addSubview(labelTitle)
        
        
        labelFunFact = UILabel()
        view.addSubview(labelFunFact)
        
        labelNBA = UILabel()
        view.addSubview(labelNBA)
        
        buttonGetQuizzes = UIButton()
        view.addSubview(buttonGetQuizzes)
        buttonGetQuizzes.addTarget(self, action: #selector(getQuizzes), for: .touchUpInside)
        

    }

    private func styleViews(){
        
        view.backgroundColor = Styles.mainColor
        
        labelTitle.text = "Quiz App"
        labelTitle.textColor = Styles.secondColor
        labelTitle.textAlignment = .center
        labelTitle.font = Styles.titleFont
        
        buttonGetQuizzes.setTitle("Get Quiz", for: .normal)
        buttonGetQuizzes.backgroundColor = Styles.secondColorLight
        buttonGetQuizzes.setTitleColor(Styles.mainColor, for: .normal)
        buttonGetQuizzes.setBackgroundColor(Styles.secondColor, forState: .highlighted)
    }

    private func defineLayoutForViews(){
        
        //DIMENZIJE
        widthOfComponents = self.view.frame.size.width * 0.8
        heightOfComponents = 50
        heightOfTitle = 50
        heightOneLiner = 21
        heightOfCell = 170
        
        labelTitle.autoSetDimensions(to: CGSize(width: widthOfComponents, height: heightOfTitle))
        buttonGetQuizzes.autoSetDimensions(to: CGSize(width: widthOfComponents, height:heightOfComponents))
        
        //POLOYAJ
        leadingMarginaOfComponents = self.view.frame.size.width * 0.1
        topMarginOfComponents = 10
        topMarginOfTitle = 45
        iconPasswordInset = 8
        smallMargin = 3
        
        labelTitle.autoPinEdge(toSuperviewEdge: .leading, withInset:leadingMarginaOfComponents)
        labelTitle.autoPinEdge(toSuperviewEdge: .top, withInset: topMarginOfTitle)
        
        buttonGetQuizzes.autoPinEdge(toSuperviewEdge: .leading, withInset:leadingMarginaOfComponents)
        buttonGetQuizzes.autoPinEdge(.top, to: .bottom, of: labelTitle, withOffset:topMarginOfComponents)
        
        }
    
    private func countInQuizzes(word:String) -> Int{
        var ans:Int = 0
        for section in quizzes{
            for quiz in section{
                for question in quiz.questions{
                    if question.question.contains(word){
                        ans = ans + 1
                    }
                }
            }
        }
        return ans
    }
    
}

extension QuizzesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return quizzes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return quizzes[section][0].category.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:QuizCellView!
        cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath as IndexPath) as! QuizCellView
        
        cell.labelTitle.text = quizzes[indexPath.section][indexPath.row].title
        cell.labelDescription.text = quizzes[indexPath.section][indexPath.row].description
        cell.imageQuiz.image = UIImage(named: "picture.jpg")
        cell.viewLevel.setLevel(levelOfQuestion: quizzes[indexPath.section][indexPath.row].level)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        router.showQuiz(myQuiz: quizzes[indexPath[0]][indexPath[1]])
    }
    
}

