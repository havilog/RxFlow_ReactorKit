//
//  Observable+Extensions'.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/12.
//

import RxCocoa
import RxSwift

extension ObservableType {
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { error in
            return Driver.empty()
        }
    }
}
