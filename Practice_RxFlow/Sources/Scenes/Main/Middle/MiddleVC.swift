//
//  MiddleVC.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/12.
//

import UIKit

import RxFlow
import RxCocoa
import ReactorKit

final class MiddleVC: UIViewController {
    
    // MARK: Constants
    
    // MARK: Properties
    
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: UI Properties
    
    private let detailButton: UIButton = UIButton().then {
        $0.setTitle("toMiddleDetail", for: .normal)
        $0.backgroundColor = .black
    }
    
    private let twoDepthFlow: UIButton = UIButton().then {
        $0.setTitle("twoDepthFlow", for: UIControl.State())
        $0.backgroundColor = .black
    }
    
    private let transitionButton: UIButton = UIButton().then {
        $0.setTitle("transitionButton", for: UIControl.State())
        $0.backgroundColor = .black
    }
    
    // MARK: Initializers
    
    init(with reactor: MiddleReactor) {
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

extension MiddleVC: View {
    func bind(reactor: MiddleReactor) {
        bindView(reactor)
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindView(_ reactor: MiddleReactor) {
        detailButton.rx.tap
            .map { Reactor.Action.detailButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        twoDepthFlow.rx.tap
            .map { Reactor.Action.twoFlowButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindAction(_ reactor: MiddleReactor) {
        
    }
    
    private func bindState(_ reactor: MiddleReactor) {
        
    }
}

// MARK: UIs

private extension MiddleVC {
    private func setUI() {
        self.title = "Middle"
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        
        view.addSubview(detailButton)
        detailButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.bottom.equalTo(view.safeArea.bottom).inset(50)
            $0.height.equalTo(50)
        }
        
        view.addSubview(twoDepthFlow)
        twoDepthFlow.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.bottom.equalTo(detailButton.snp.top).offset(-50)
            $0.height.equalTo(50)
        }
        
        view.addSubview(transitionButton)
        transitionButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.bottom.equalTo(twoDepthFlow.snp.top).offset(-50)
            $0.height.equalTo(50)
        }
    }
}
