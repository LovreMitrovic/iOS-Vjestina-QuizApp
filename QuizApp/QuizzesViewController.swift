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
    private var quizzes:[[Quiz]]! = []
    private var dataService:DataService!
    private var numOfNBA:Int!
    private var allCategories:[QuizCategory]!
    
    @objc func getQuizzes()->Void{
        dataService = DataService()
        let quizzesArray:[Quiz] = dataService.fetchQuizes()
        let categoriesArray:[QuizCategory] = Array(Set(quizzesArray.map({$0.category})))
        for category in categoriesArray{
            var row:[Quiz]! = []
            for quiz in quizzesArray{
                if quiz.category == category{
                    row.append(quiz)
                }
            }
            quizzes.append(row)
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
        viewOfQuizzes.register(UITableViewCell.self, forCellReuseIdentifier: "QuizCell")
        viewOfQuizzes.dataSource = self
        viewOfQuizzes.delegate = self
        
        
        labelFunFact.text = "Fun Fact"
        labelFunFact.textColor = Styles.secondColor
        numOfNBA = 3
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
        heightOfCell = 150
        
        labelTitle.autoSetDimensions(to: CGSize(width: widthOfComponents, height: heightOfTitle))
        buttonGetQuizzes.autoSetDimensions(to: CGSize(width: widthOfComponents, height:heightOfComponents))
        
        //POLOYAJ
        leadingMarginaOfComponents = self.view.frame.size.width * 0.1
        topMarginOfComponents = 10
        topMarginOfTitle = 25
        iconPasswordInset = 8
        smallMargin = 3
        
        labelTitle.autoPinEdge(toSuperviewEdge: .leading, withInset:leadingMarginaOfComponents)
        labelTitle.autoPinEdge(toSuperviewEdge: .top, withInset: topMarginOfTitle)
        
        buttonGetQuizzes.autoPinEdge(toSuperviewEdge: .leading, withInset:leadingMarginaOfComponents)
        buttonGetQuizzes.autoPinEdge(.top, to: .bottom, of: labelTitle, withOffset:topMarginOfComponents)
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath as IndexPath)
        cell.backgroundColor = Styles.secondColorLighter
        cell.textLabel!.textColor = Styles.secondColor
        
        //CREATE VIEWS
        let labelQuizTitle = UILabel()
        cell.addSubview(labelQuizTitle)
        let labelQuizDescription = UILabel()
        cell.addSubview(labelQuizDescription)
        let imageViewQuiz = UIImageView(image:UIImage(named: "picture.jpg"))
        cell.addSubview(imageViewQuiz)
        let labelLevel = UILabel()
        cell.addSubview((labelLevel))
        
        //STYLE VIEWS
        labelQuizTitle.text = quizzes[indexPath.section][indexPath.row].title
        labelQuizTitle.textColor = Styles.secondColor
        
        labelQuizDescription.text = quizzes[indexPath.section][indexPath.row].description
        labelQuizDescription.textColor = Styles.secondColor
        labelQuizDescription.lineBreakMode = .byWordWrapping
        labelQuizDescription.numberOfLines = 0
        
        imageViewQuiz.contentMode = .scaleToFill
        
        switch quizzes[indexPath.section][indexPath.row].level{
        case 1:
            labelLevel.text = "* O O"
            break
        case 2:
            labelLevel.text = "* * O"
            break
        case 3:
            labelLevel.text = "* * *"
            break
        default:
            labelLevel.text = "O O O"
        }
        labelLevel.textColor = Styles.secondColor
        
        //POSITION
        let leadingMargin:CGFloat! = 10
        let HorizontalMiddleMargin:CGFloat! = 10
        let topMargin:CGFloat! = 10
        let verticalMiddleMargin:CGFloat! = 10
        
        labelQuizTitle.autoPinEdge(toSuperviewEdge: .top, withInset: topMargin)
        labelQuizTitle.autoPinEdge(toSuperviewEdge: .leading, withInset: leadingMargin)
        
        imageViewQuiz.autoPinEdge(.top, to: .bottom, of: labelQuizTitle, withOffset: verticalMiddleMargin)
        imageViewQuiz.autoPinEdge(toSuperviewEdge: .leading, withInset: leadingMargin)
    
        labelQuizDescription.autoPinEdge(.top, to: .bottom, of: labelQuizTitle, withOffset: verticalMiddleMargin)
        labelQuizDescription.autoPinEdge(.leading, to: .trailing, of: imageViewQuiz, withOffset: HorizontalMiddleMargin)
        
        //DIMENSIONS
        let imageHeight:CGFloat! = 80
        let leftWidth:CGFloat! = 80
        let titleHeight:CGFloat! = 20
        let rightWidth:CGFloat! = widthOfComponents - leftWidth - 20
        let fullWidth:CGFloat! = widthOfComponents - 20
        let descriptionHeight:CGFloat! = 50
        
        imageViewQuiz.autoSetDimensions(to: CGSize(width: leftWidth, height: imageHeight))
        
        labelQuizTitle.autoSetDimensions(to: CGSize(width: fullWidth, height: titleHeight))
        
        labelQuizDescription.autoSetDimensions(to: CGSize(width: rightWidth, height: descriptionHeight))
        
        
        return cell
        
    }
    
}

