//
//  SettingVC.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/12.
//

import UIKit

import RxCocoa
import ReactorKit

final class SettingVC: UIViewController {
    
    // MARK: Constants
    
    // MARK: Properties
    
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: UI Properties
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("logout", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Initializers
    
    init(with reactor: SettingReactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
}

// MARK: Bind

extension SettingVC: View {
    func bind(reactor: SettingReactor) {
        bindView(reactor)
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindView(_ reactor: SettingReactor) {
        logoutButton.rx.tap
            .subscribe(onNext: {
                reactor.steps.accept(SampleStep.loginIsRequired)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindAction(_ reactor: SettingReactor) {
        
    }
    
    private func bindState(_ reactor: SettingReactor) {
        
    }
}

// MARK: UIs

private extension SettingVC {
    private func setUI() {
        view.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        setNav()
        
        view.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setNav() {
        
    }
}
