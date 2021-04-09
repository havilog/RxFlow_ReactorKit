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

class LoginVC: UIViewController, Stepper {
    var steps = PublishRelay<Step>()
    var disposeBag = DisposeBag()
    private let viewModel: ViewModelType
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("login", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(with viewModel: ViewModelType) {
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
    
    func bind(with viewModel: ViewModelType) {
        bindAction(with: viewModel)
        bindState(with: viewModel)
    }
}

private extension LoginVC {
    func setUI() {
        self.title = "Login"
        view.backgroundColor = .white
        
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
    func bindAction(with viewModel: ViewModelType) {
        loginButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.steps.accept(SampleStep.dashboardIsRequired)
            })
            .disposed(by: disposeBag)
    }
    
    func bindState(with viewModel: ViewModelType) {
        
    }
}
