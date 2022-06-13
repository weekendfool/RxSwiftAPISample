//
//  WikipediaAPI.swift
//  RxSwiftAPISample
//
//  Created by Oh!ara on 2022/06/13.
//

import Foundation
import RxSwift

protocol WikipediaAPI {
    func serch(from word: String) -> Observable<[WikipediaPage]>
}


class WikipediaDefaultAPI: WikipediaAPI {
    
    private let host = URL(string: "https://ja.wikipedia.org")!
    private let path = "/w/api.php"
    
    private let URLSession: Foundation.URLSession
    
    init(URLSession: Foundation.URLSession) {
        self.URLSession = URLSession
    }
    
    func serch(from word: String) -> Observable<[WikipediaPage]> {
        var components = URLComponents(url: host, resolvingAgainstBaseURL: false)!
        components.path = path
        
        let items = [
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "action", value: "query"),
            URLQueryItem(name: "list", value: "search"),
            URLQueryItem(name: "search", value: word)
        ]
        
        components.queryItems = items
        
        let request = URLRequest(url: components.url!)
        
        return URLSession.rx.response(request: request)
            .map { pair in
                do {
                    let response = try JSONDecoder().decode(
                        WikipediaSearchResponse.self,
                        from: pair.data
                    )
                    return response.query.search
                } catch {
                    throw error
                }
            }
    }
}
