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

final class HomeDetailVC: UIViewController, Stepper {
    
    // MARK: Property
    
    var steps: PublishRelay<Step> = .init()
    private let movieTitle: String
    
    // MARK: UI Properties
    
    private let titleLabel: UILabel = UILabel().then {
        $0.font = .systemFont(ofSize: 30)
        $0.textAlignment = .center
    }
    
    // MARK: Initializers
    
    init(with title: String) {
        self.movieTitle = title
        
        super.init(nibName: nil, bundle: nil)
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
        
        setNav()
        
        view.addSubview(titleLabel)
        titleLabel.text = movieTitle
        titleLabel.snp.makeConstraints {
            $0.edges.equalTo(view.safeArea.edges)
        }
    }
    
    private func setNav() {
        
    }
}
