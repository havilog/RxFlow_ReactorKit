//
//  LoginVC.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

import UIKit

import RxFlow
import RxCocoa
import ReactorKit

final class LoginVC: UIViewController {
    var disposeBag: DisposeBag = .init()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("login", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(with reactor: LoginReactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
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

extension LoginVC: View {
    func bind(reactor: LoginReactor) {
        bindView(reactor)
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindView(_ reactor: LoginReactor) {
        loginButton.rx.tap
            .subscribe(onNext: {
                reactor.steps.accept(SampleStep.mainTabBarIsRequired)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindAction(_ reactor: LoginReactor) {
        
    }
    
    private func bindState(_ reactor: LoginReactor) {
        
    }
}
