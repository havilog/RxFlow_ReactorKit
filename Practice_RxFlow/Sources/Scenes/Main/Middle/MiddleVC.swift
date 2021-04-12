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

final class MiddleVC: UIViewController, Stepper {
    
    var steps: PublishRelay<Step> = .init()
    
    // MARK: Constants
    
    // MARK: Properties
    
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: UI Properties
    
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
        
        setNav()
    }
    
    private func setNav() {
        
    }
}
