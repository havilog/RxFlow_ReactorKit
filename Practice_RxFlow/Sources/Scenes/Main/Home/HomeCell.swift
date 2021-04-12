//
//  HomeCell.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/12.
//

import UIKit

import RxCocoa
import ReactorKit

final class HomeCell: UITableViewCell {
    
    let titleLabel: UILabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .center
    }
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
    }
}

// MARK: Binds
extension HomeCell {
    func bind(with item: Movie) {
        titleLabel.text = item.description
    }
}

// MARK: SetUI
extension HomeCell {
    private func setUI() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { 
            $0.edges.equalToSuperview()
        }
    }
}
