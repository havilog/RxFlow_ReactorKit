//
//  ViewController.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

import UIKit

import RxFlow
import RxCocoa
import ReactorKit

final class HomeVC: UIViewController {
    var disposeBag: DisposeBag = .init()
    
    init(with reactor: HomeReactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
}

private extension HomeVC {
    func setUI() {
        self.title = "Main"
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)

    }
}

extension HomeVC: View {
    func bind(reactor: HomeReactor) {
        bindView(reactor)
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindView(_ reactor: HomeReactor) {
        
    }
    
    private func bindAction(_ reactor: HomeReactor) {
        
    }
    
    private func bindState(_ reactor: HomeReactor) {
        
    }
}
