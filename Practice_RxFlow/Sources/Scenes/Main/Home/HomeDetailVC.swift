//
//  HomeDetailVC.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/12.
//

import UIKit

import RxFlow
import RxCocoa
import ReactorKit

final class HomeDetailVC: UIViewController {
    
    // MARK: Property
    
    private let movieTitle: String
    internal var disposeBag: DisposeBag = .init()
    
    // MARK: UI Properties
    
    private let titleLabel: UILabel = UILabel().then {
        $0.font = .systemFont(ofSize: 30)
        $0.textAlignment = .center
    }
    
    private let toMiddleButton: UIButton = UIButton(type: .system).then {
        $0.setTitle("toMiddle", for: .normal)
        $0.backgroundColor = .black
    }
    
    // MARK: Initializers
    
    init(
        with reactor: HomeDetailReactor,
        title: String
    ) {
        self.movieTitle = title

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

private extension HomeDetailVC {
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.text = movieTitle
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeArea.top)
            $0.bottom.equalTo(view.safeArea.bottom).offset(-50)
        }
        
        view.addSubview(toMiddleButton)
        toMiddleButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeArea.bottom)
            $0.height.equalTo(50)
        }
    }
}

// MARK: Bind

extension HomeDetailVC: View {
    func bind(reactor: HomeDetailReactor) {
        toMiddleButton.rx.tap
            .map { Reactor.Action.toMiddleDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
