//
//  APIFoundationModel.swift
//  RxSwiftAPISample
//
//  Created by Oh!ara on 2022/06/14.
//

import Foundation
import UIKit

class  APIFoundationModel {
// APIのリクエスト
    func searchGitHabUser() {
    
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=isbn:9784101801636"
        let encodeUrlStiring: String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodeUrlStiring)!
        print("url: \(url)")
    
        let request = URLRequest(url: url)
//        let books = BookData
        
        let decoder: JSONDecoder = JSONDecoder()
    
        var retunValue: String?
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // データ受信後の処理をかく
            print("data: \(data)")
            print("response: \(response)")
            guard let data = data else { return }
            
            do {
                
                let book: BookData = try decoder.decode(BookData.self, from: data)
                retunValue = book.items[0].volumeInfo.title
                
                print("book: \(retunValue)")
            } catch let error {
                print("error: -----------------------")
                print(error)
//                fatalError()
                retunValue = "error"
            }
//            return retunValue
    }
    
        task.resume()
//        print("retunValue: \(retunValue)")
//        return retunValue!
       
    }
}
