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
    
    private let loginButton: UIButton = UIButton().then {
        $0.setTitle("login", for: .normal)
        $0.backgroundColor = .black
    }
    
    init(with reactor: LoginReactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
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
        loginButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.height.equalTo(50)
        }
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
                print($0)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindAction(_ reactor: LoginReactor) {
        loginButton.rx.tap
            .map { Reactor.Action.loginButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: LoginReactor) {

    }
}
