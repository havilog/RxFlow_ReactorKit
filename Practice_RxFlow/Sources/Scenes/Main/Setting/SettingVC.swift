//
//  SettingVC.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/12.
//

import UIKit

import RxFlow
import RxCocoa
import ReactorKit

final class SettingVC: UIViewController {
    
    // MARK: Constants
    
    // MARK: Properties
    
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: UI Properties
    
    private let logoutButton: UIButton = UIButton().then {
        $0.setTitle("logout", for: .normal)
        $0.backgroundColor = .black
    }
    
    private let alertButton: UIButton = UIButton().then {
        $0.setTitle("showAlert", for: UIControl.State())
        $0.backgroundColor = .black
    }
    
    // MARK: Initializers
    
    init(with reactor: SettingReactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
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
//        logoutButton.rx.tap
//            .subscribe(onNext: {
//                reactor.steps.accept(SampleStep.loginIsRequired)
//            })
//            .disposed(by: disposeBag)
    }
    
    private func bindAction(_ reactor: SettingReactor) {
        logoutButton.rx.tap
            .map { Reactor.Action.logoutButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        alertButton.rx.tap
            .map { Reactor.Action.alertButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: SettingReactor) {
    }
}

// MARK: UIs

private extension SettingVC {
    private func setUI() {
        self.title = "Setting"
        view.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { 
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.bottom.equalTo(view.safeArea.bottom).inset(50)
            $0.height.equalTo(50)
        }
        
        view.addSubview(alertButton)
        alertButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.bottom.equalTo(logoutButton.snp.top).offset(-50)
            $0.height.equalTo(50)
        }
    }
}
