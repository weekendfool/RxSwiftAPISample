//
//  ViewModel2.swift
//  RxSwiftAPISample
//
//  Created by Oh!ara on 2022/06/14.
//

import Foundation
import RxCocoa
import RxSwift

protocol ViewModel2Type {
    associatedtype Input2
    associatedtype Output2
    
    func transform(input: Input2) -> Output2
}

class ViewModel2 {
    
    private let disposeBag = DisposeBag()
    
//    private let book: BookData = BookData()
    
    // 1
    private let scheduler: SchedulerType
    
    private let model: AlamofireModel
    
    private let bookModel: GoogleBooksAPIModel
    
    init(scheduler: SchedulerType = ConcurrentMainScheduler.instance, model: AlamofireModel, bookModel: GoogleBooksAPIModel) {
//        self.book = book
        self.scheduler = scheduler
        self.model = model
        self.bookModel = bookModel
    }
    
   
}

extension ViewModel2: ViewModel2Type {

    struct Input2 {
        let searchText: Observable<String>
    }

    struct Output2 {
        let resultTitle: Observable<String>
//        let error: Observable<Error>
    }

    func transform(input: Input2) -> Output2 {
        let filterdText = input.searchText
            .debounce(.milliseconds(300), scheduler: scheduler)
            .share(replay: 1)
        
        let decoder: JSONDecoder = JSONDecoder()

//        let x = filterdText
//            .map { [weak self] text -> Observable<Data> in
//                print("text: \(text)")
//                return  self?.bookModel.getBookData(title: "isbn:9784101801636")
//            }
        
       let data = bookModel.getBookData(title: "isbn:9784101801636")
        
//        var observable: Observable<String>?
//        var bookData: String?
        
        let searchDescription = PublishRelay<String>()

        
        let output = data.map { data -> String in
            print("data: \(data)")
            
            let book: BookData = try decoder.decode(BookData.self, from: data)
            print("output: \(book.items[0].volumeInfo.title)")
            return book.items[0].volumeInfo.title
            
        }
    
//        let output = data.subscribe { data in
//
//            data.map { jsonData -> String in
//                let book: BookData = try decoder.decode(BookData.self, from: jsonData)
//                print("output: \(book.items[0].volumeInfo.title)")
//                return book.items[0].volumeInfo.title
//            }
////            return bookData
//        }.disposed(by: disposeBag)
//
        
        return Output2(resultTitle: output)

    }


}


