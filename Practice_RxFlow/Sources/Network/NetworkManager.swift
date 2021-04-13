//
//  NetworkManager'.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/12.
//

import Foundation

enum JokesAPI {
    case randomJokes
    
    static let baseURL = "https://api.icndb.com/"
    var path: String { "jokes/random" }
    var url: URL { URL(string: JokesAPI.baseURL + path)! }
    
    var sampleData: Data {
        Data(
            """
            {
                "type": "success",
                    "value": {
                    "id": 459,
                    "joke": "Chuck Norris can solve the Towers of Hanoi in one move.",
                    "categories": []
                }
            }
            """.utf8
        )
    }
}

enum APIError: LocalizedError {
    case unknownError
    var errorDescription: String? { "unknownError" }
}

protocol URLSessionProtocol {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

protocol NetworkManagerType {
    func fetchMovies() -> Result<ResultBase, Error>
}

final class NetworkManager: NetworkManagerType {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    // for test
    func fetchRandomJoke(completion: @escaping (Result<Joke, Error>) -> Void) {
        let request = URLRequest(url: JokesAPI.randomJokes.url)
        
        let task: URLSessionDataTask = session
            .dataTask(with: request) { data, urlResponse, error in
                guard let response = urlResponse as? HTTPURLResponse,
                      (200...399).contains(response.statusCode) else {
                    completion(.failure(error ?? APIError.unknownError))
                    return
                }
                
                if let data = data,
                   let jokeResponse = try? JSONDecoder().decode(JokeReponse.self, from: data) {
                    completion(.success(jokeResponse.value))
                    return
                }
                completion(.failure(APIError.unknownError))
            }
        
        task.resume()
    }
    
    // for UI
    func fetchMovies() -> Result<ResultBase, Error> {
        let meta: MetaData = .init(isEnd: false, page: 10)
        
        let movies: [Movie] = [
            Movie(name: "ironMan", description: "아이언맨"),
            Movie(name: "SpiderMan", description: "스파이더맨"),
            Movie(name: "BatMan", description: "배트맨"),
            Movie(name: "SuperMan", description: "슈퍼맨"),
            Movie(name: "Thor", description: "토르"),
            Movie(name: "Hurk", description: "헐크"),
            Movie(name: "WonderWoman", description: "원더우먼"),
            Movie(name: "BlackPanther", description: "블랙팬서"),
            Movie(name: "Havi", description: "하비"),
            Movie(name: "Sangjin", description: "상진")
        ]
        
        let resultBase: ResultBase = ResultBase(metaData: meta, movie: movies)
        
        return .success(resultBase)
    }
}
