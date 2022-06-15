//
//  AlamofireModel.swift
//  RxSwiftAPISample
//
//  Created by Oh!ara on 2022/06/16.
//

import Foundation
import Alamofire

class AlamofireModel {
    
    func getData() {
        
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=isbn:9784101801636"
        let encodeUrlStiring: String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodeUrlStiring)!
        print("url: \(url)")
        
        let decoder: JSONDecoder = JSONDecoder()
        
        AF.request(url).responseJSON { response in
            switch response.result {
                
            case .success:
                do {
                    guard  let data = response.data else { return }
                    let book: BookData = try decoder.decode(BookData.self, from: data)
                    print("book: \(book.self)")
                } catch let error {
                    print("error: -----------------------")
                    print(error)
    //                fatalError()
                }
                
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}
