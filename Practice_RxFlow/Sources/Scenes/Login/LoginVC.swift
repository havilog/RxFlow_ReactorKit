//
//  LoginVC.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

import UIKit

import RxFlow
import RxSwift
import RxCocoa

class LoginVC: UIViewController {
    
    private let viewModel: LoginVM
    var disposeBag = DisposeBag()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("login", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(with viewModel: LoginVM) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(with: viewModel)
        setUI()
    }
    
    func bind(with viewModel: LoginVM) {
        loginButton.rx.tap.subscribe(onNext: {
            viewModel.steps.accept(SampleStep.dashboardIsRequired)
        })
        .disposed(by: disposeBag)
        
        bindAction(with: viewModel)
        bindState(with: viewModel)
    }
}

private extension LoginVC {
    func setUI() {
        self.title = "Login"
        view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

private extension LoginVC {
    func bindAction(with viewModel: LoginVM) {
        let loginTapped = loginButton.rx.tap.map { _ in }
        let input = LoginVM.Input(buttonTapped: loginTapped)
        
        let output = viewModel.transform(input: input)
        
        output.changeText
            .drive(loginButton.rx.title(for: .normal))
            .disposed(by: disposeBag)

    }
    
    func bindState(with viewModel: LoginVM) {
        
    }
}
