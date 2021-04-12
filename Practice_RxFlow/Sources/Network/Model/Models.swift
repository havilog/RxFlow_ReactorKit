//
//  ResultBase.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/12.
//

struct ResultBase {
    let metaData: MetaData
    let movie: [Movie]
}

struct MetaData {
    let isEnd: Bool
    let page: Int
}

struct Movie {
    let name: String
    let description: String
}
