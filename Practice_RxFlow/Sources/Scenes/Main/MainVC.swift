//
//  ViewController.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

import UIKit

import RxFlow
import RxSwift
import RxCocoa

class MainVC: UIViewController, Stepper {
    var steps = PublishRelay<Step>()
    var disposeBag = DisposeBag()
    private let viewModel: ViewModelType
    
    var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("logout", for: .normal)
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

private extension MainVC {
    func setUI() {
        self.title = "Main"
        view.backgroundColor = .white
        
        view.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

private extension MainVC {
    func bindAction(with viewModel: ViewModelType) {
        logoutButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.steps.accept(SampleStep.loginIsRequired)
            })
            .disposed(by: disposeBag)
    }
    
    func bindState(with viewModel: ViewModelType) {
        
    }
}
