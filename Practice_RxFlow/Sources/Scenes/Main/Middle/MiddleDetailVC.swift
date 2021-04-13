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
    
    // MARK: Initializers
    
    init() {
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

private extension MiddleDetailVC {
    private func setUI() {
        view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    }
}
