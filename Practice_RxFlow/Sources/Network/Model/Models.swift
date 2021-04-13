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

// for Test
struct JokeReponse: Decodable {
    let type: String
    let value: Joke
}

struct Joke: Decodable {
    let id: Int
    let joke: String
    let categories: [String]
}
