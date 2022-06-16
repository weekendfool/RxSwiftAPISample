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
    
    private let book: BookData
    
    // 1
    private let scheduler: SchedulerType
    
    private let model: AlamofireModel
    
    init(book: BookData, scheduler: SchedulerType = ConcurrentMainScheduler.instance, model: AlamofireModel) {
        self.book = book
        self.scheduler = scheduler
        self.model = model
    }
}

//extension ViewModel2: ViewModel2Type {
//
//    struct Input2 {
//        let searchText: Observable<String>
//    }
//
//    struct Output2 {
//        let resultTitle: Observable<String>
//        let error: Observable<Error>
//    }
//
//    func transform(input: Input2) -> Output2 {
//        let filterdText = input.searchText
//            .debounce(.milliseconds(300), scheduler: scheduler)
//            .share(replay: 1)
//
//        let sequence = filterdText
//            .map { [weak self] text in
//                return  self?.model.getData()
//            }
//    }
//
//
//}


