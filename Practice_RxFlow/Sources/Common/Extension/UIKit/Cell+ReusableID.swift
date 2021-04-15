//
//  Cell+ReusableID.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/12.
//

import UIKit

protocol ReuseIdentifiable {
    static var reusableID: String { get }
}

extension ReuseIdentifiable {
    static var reusableID: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}
extension UICollectionViewCell: ReuseIdentifiable {}
