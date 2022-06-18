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
                print("data:\(response.data)")
//                let book: BookData = try decoder.decode(BookData.self, from: response.data!)
                observer.onNext(response.data!)
//                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func getBookData2(title: String) -> Data {
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(title)"
        
        let encodeUrlStiring: String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = URL(string: encodeUrlStiring)!
        
        var data1: Data?
        
//        let decoder: JSONDecoder = JSONDecoder()
        
//        return
        AF.request(url).responseJSON { response in
            switch response.result {
                
            case .success:
                do {
                    guard  let data = response.data else { return }
                    data1 = data
//                    print("book: \(book.self)")
//                    return data
                } catch let error {
                    print("error: -----------------------")
                    print(error)
    //                fatalError()
                }
                
            case .failure(let error):
                print("error: \(error)")
            }
        }
        return data1!
    }

//    func changeJson(data: Data) -> Observable<String> {
//       
//            
//            return Observable.create { observer in
//                let decoder: JSONDecoder = JSONDecoder()
//                let book: BookData = try decoder.decode(BookData.self, from: data)
//                
//                observer.onNext(book.items[0].volumeInfo.title)
//            }
//       
//    }
    
}
