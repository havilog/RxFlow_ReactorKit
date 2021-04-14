//
//  MiddleDetailVC.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/13.
//

import UIKit

import RxCocoa
import ReactorKit

final class MiddleDetailVC: UIViewController {
    
    // MARK: Property
    
    var disposeBag: DisposeBag = .init()
    
    private let dismissButton: UIButton = UIButton().then {
        $0.setTitle("dismiss", for: .normal)
        $0.backgroundColor = .black
    }
    
    // MARK: Initializers
    
    init(with reactor: MiddleDetailReactor) {
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

// MARK: UIs

private extension MiddleDetailVC {
    private func setUI() {
        view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        
        view.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { 
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
            $0.centerY.equalToSuperview()
        }
    }
}

// MARK: Bind

extension MiddleDetailVC: View {
    func bind(reactor: MiddleDetailReactor) {
        dismissButton.rx.tap
            .map { Reactor.Action.dismissButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
