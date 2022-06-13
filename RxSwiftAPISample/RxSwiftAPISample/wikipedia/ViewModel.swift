//
//  ViewModel.swift
//  RxSwiftAPISample
//
//  Created by Oh!ara on 2022/06/13.
//

import Foundation
import RxSwift
import RxCocoa

// 1
protocol ViewModelType {
    //　associatedtype　→ 後で構造体で定義するから仮に置いとくよってイメージ
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class ViewModel {
    
    private let disposeBag = DisposeBag()
    
    private let wikipediaAPI: WikipediaAPI
    // 1
    private let scheduler: SchedulerType
    
    init(wikipediaAPI: WikipediaAPI, scheduler: SchedulerType = ConcurrentMainScheduler.instance) {
        self.wikipediaAPI = wikipediaAPI
        self.scheduler = scheduler
    }
}

extension ViewModel: ViewModelType {
    // 2
    struct Input {
        let searchText: Observable<String>
    }
    
    struct Output {
        let wikipediaPages: Observable<[WikipediaPage]>
        let searchDescription: Observable<String>
        let error: Observable<Error>
    }
    
    func transform(input: Input) -> Output {
        let filterdText = input.searchText
            .debounce(.milliseconds(300), scheduler: scheduler)
            .share(replay: 1)
        
        let sequence = filterdText
            .flatMapLatest { [unowned self] text -> Observable<Event<[WikipediaPage]>> in
                return self.wikipediaAPI
                    .serch(from: text)
                    .materialize()
            }
            .share(replay: 1)
        
        let wikipediaPages = sequence.element(at: 2)
        
        // 3
        let _searchDescription = PublishRelay<String>()
        
        // 4
        wikipediaPages
            .withLatestFrom(filterdText) { (pages, word) -> String in
                return "\(word) \(pages) 件"
            }
            .bind(to: _searchDescription)
            .disposed(by: disposeBag)
        
//        return Output(
//            wikipediaPages: wikipediaPages,
//            searchDescription: _searchDescription.asObservable(),
//            error: Observable<Event<[WikipediaPage]>>.error
//        )
    }
}
