//
//  SearchViewController.swift
//  QuizApp
//
//  Created by Lovre on 29/05/2021.
//

import Foundation
import PureLayout

class SearchViewController:UIViewController, UITableViewDelegate{
    
    private let buttonSearch:UIButton = {
        let button = UIButton()
        button.backgroundColor = Styles.secondColorLight
        button.setTitleColor(Styles.mainColor, for: .normal)
        button.setBackgroundColor(Styles.secondColor, forState: .highlighted)
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action:#selector(getQuizzes), for: .touchUpInside)
        return button
    }()
    
    private let textSearch:UITextField = {
        let text = UITextField()
        text.backgroundColor = Styles.secondColorLighter
        text.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: Styles.secondColor!])
        text.textColor = Styles.secondColor
        text.borderStyle = UITextField.BorderStyle.roundedRect
        return text
    }()
    
    private var leadingMargin:CGFloat!
    private var titleMargin:CGFloat = 30
    private var topMargin:CGFloat = 10
    private var heightOfComponents:CGFloat = 50
    private var widthOfComponents:CGFloat!
    private var heighOfCell:CGFloat! = 170
    
    var quizzes:[[Quiz]]!
    private var router:AppRouter!
    private var presenter:SearchPresenter!
    
    init(router: AppRouter){
        super.init(nibName: nil, bundle: nil)
        self.router = router
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let viewOfQuizzes:UITableView = {
        let view = UITableView()
        view.backgroundColor = Styles.mainColor
        view.rowHeight = 170
        return view
    }()
    
    @objc func showQuizzes(){
        view.addSubview(viewOfQuizzes)
        viewOfQuizzes.register(QuizCellView.self, forCellReuseIdentifier: "QuizCell")
        viewOfQuizzes.dataSource = self
        viewOfQuizzes.delegate = self
        
        viewOfQuizzes.autoPinEdge(.top, to: .bottom, of: buttonSearch,withOffset: titleMargin)
        viewOfQuizzes.autoPinEdge(toSuperviewEdge: .leading, withInset: leadingMargin)
        
        let minusHeight = 2*topMargin + titleMargin + 2*heightOfComponents
        let heightOfTableView:CGFloat = self.view.frame.height - minusHeight
        
        viewOfQuizzes.autoSetDimensions(to: CGSize(width: widthOfComponents, height: heightOfTableView))
    }
    
    @objc func getQuizzes()->Void{
        quizzes = []
        presenter = SearchPresenter(viewController: self)
        let currentText = textSearch.text
        DispatchQueue.global(qos: .userInitiated).async {
            self.presenter.searchQuizzes(condition:currentText)
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = Styles.mainColor
        view.addSubview(textSearch)
        view.addSubview(buttonSearch)
        
        leadingMargin = view.frame.size.width * 0.1
        widthOfComponents = view.frame.size.width * 0.8
        
        textSearch.autoPinEdge(toSuperviewEdge: .top,withInset: titleMargin)
        textSearch.autoPinEdge(toSuperviewEdge: .leading,withInset: leadingMargin)
        textSearch.autoPinEdge(toSuperviewEdge: .trailing,withInset: leadingMargin)
        
        buttonSearch.autoPinEdge(toSuperviewEdge: .leading,withInset: leadingMargin)
        buttonSearch.autoPinEdge(toSuperviewEdge: .trailing,withInset: leadingMargin)
        buttonSearch.autoPinEdge(.top, to: .bottom, of: textSearch,withOffset: topMargin)
        
        textSearch.autoSetDimensions(to: CGSize(width: widthOfComponents, height:heightOfComponents))
        buttonSearch.autoSetDimensions(to: CGSize(width: widthOfComponents, height:heightOfComponents))

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        leadingMargin = view.frame.size.width * 0.1
        widthOfComponents = view.frame.size.width * 0.8
    }
}

extension SearchViewController: UITableViewDataSource {
    
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

        let url = NSURL(string: quizzes[indexPath.section][indexPath.row].imageUrl)! as URL
        if let imageData: NSData = NSData(contentsOf: url) {
            cell.imageQuiz.image = UIImage(data: imageData as Data)
        }
        
        //cell.imageQuiz.image = UIImage(named: quizzes[indexPath.section][indexPath.row].imageUrl)
        cell.viewLevel.setLevel(levelOfQuestion: quizzes[indexPath.section][indexPath.row].level)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        router.showQuiz(myQuiz: quizzes[indexPath[0]][indexPath[1]])
    }
    
}
