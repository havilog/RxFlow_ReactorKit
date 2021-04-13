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
    
    private let tableView: UITableView = UITableView().then {
        $0.register(HomeCell.self, forCellReuseIdentifier: HomeCell.reusableID)
        $0.rowHeight = 50
        $0.separatorStyle = .none
    }
    
    init(with reactor: HomeReactor) {
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

private extension HomeVC {
    func setUI() {
        self.title = "Home"
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { 
            $0.edges.equalTo(view.safeArea.edges)
        }
    }
}

extension HomeVC: View {
    func bind(reactor: HomeReactor) {
        bindView(reactor)
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindView(_ reactor: HomeReactor) {
//        tableView.rx.itemSelected
//            .withUnretained(self)
//            .map { owner, index -> String? in
//                return owner.fetchCellTitleText(index: index)
//            }
//            .compactMap { $0 }
//            .map { Reactor.Action.itemSelected(title: $0) }
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
        
        // modelSelected를 사용하면 더 쉽게 가져올 수 있네
        tableView.rx.modelSelected(Movie.self)
            .map { $0.description }
            .map { Reactor.Action.itemSelected(title: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindAction(_ reactor: HomeReactor) {
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.loadData }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: HomeReactor) {
        let sharedState = reactor.state.share(replay: 1).subscribe(on: MainScheduler.instance)
        
        sharedState
            .compactMap { $0.movies }
            .bind(to:
                tableView.rx.items(
                    cellIdentifier: HomeCell.reusableID, 
                    cellType: HomeCell.self
                )
            ) { index, item, cell in
                cell.bind(with: item)
            }
            .disposed(by: disposeBag)
        
        reactor.errorSubject
            .asDriverOnErrorJustComplete()
            .drive(onNext: {
                // AlertController를 띄워줌
                print("error ! : \($0)")
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchCellTitleText(index: IndexPath) -> String? {
        guard let cell = self.tableView.cellForRow(at: index) as? HomeCell else { return nil }
        
        return cell.titleLabel.text
    }
}
