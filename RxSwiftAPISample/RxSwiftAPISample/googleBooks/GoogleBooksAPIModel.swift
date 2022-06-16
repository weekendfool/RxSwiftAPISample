//
//  GoogleBooksAPIModel.swift
//  RxSwiftAPISample
//
//  Created by Oh!ara on 2022/06/14.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire


class GoogleBooksAPIModel {
    
    private let disposebag = DisposeBag()
    
    
//    func getData(title: String) -> Observable<String> {
//        
//        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(title)"
//        
//        let encodeUrlStiring: String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        
//        let url = URL(string: encodeUrlStiring)!
//        print("url: \(url)")
//        
//        let decoder: JSONDecoder = JSONDecoder()
//        
//        AF.request(url).responseJSON { response in
//            switch response.result {
//            case .success:
//                do {
//                    guard let data = response.data else { return }
//                    let book: BookData = try decoder.decode(BookData.self, from: data)
//                    
//                    let x: Observable<String> = book.items[0].volumeInfo.title
//                    return x
//                    
//                    } catch let error {
//                        print("error: -----------------------")
//                        print(error)
//                }
//            case .failure(let error):
//                print("error: \(error)")
//            }
//        }
//    }
    


    
    func getBookData(title: String) -> Observable<Data> {
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(title)"
        
        let encodeUrlStiring: String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = URL(string: encodeUrlStiring)!
        
        let decoder: JSONDecoder = JSONDecoder()
        
        return Observable.create { observer in
            AF.request(url).responseJSON { response in
                print("通信")
//                let book: BookData = try decoder.decode(BookData.self, from: data)
                observer.onNext(response.data!)
//                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
}
