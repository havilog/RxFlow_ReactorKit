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

class MainVC: UIViewController {
    
    private let viewModel: MainVM
    var disposeBag = DisposeBag()
    
    var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("logout", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(with viewModel: MainVM) {
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
}

private extension MainVC {
    func setUI() {
        self.title = "Main"
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
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
    func bind(with viewModel: MainVM) {
        logoutButton.rx.tap
            .subscribe(onNext: {
                viewModel.steps.accept(SampleStep.loginIsRequired)
            })
            .disposed(by: disposeBag)
    }
}
