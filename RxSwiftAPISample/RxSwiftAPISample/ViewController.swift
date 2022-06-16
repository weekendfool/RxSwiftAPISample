//
//  ViewController.swift
//  RxSwiftAPISample
//
//  Created by Oh!ara on 2022/06/13.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var sampleSearchBar: UISearchBar!
    @IBOutlet weak var sampleTableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    
    var model = APIFoundationModel()
    let af = AlamofireModel()
    
    let book = GoogleBooksAPIModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
//        model.searchGitHabUser(query: "9784101801636")
//        model.searchGitHabUser()
        
//        af.getData()
        
        let decoder: JSONDecoder = JSONDecoder()
        
        
        let x = book.getBookData(title: "isbn:9784101801636")
        
        x.subscribe { data in
//            print(data)
                data.map { data in
                print("data:\(data)")
                    print("data:\(data)")
                var book: BookData = try decoder.decode(BookData.self, from: data)
//                print("Book1: \(book)")
                print("Book: \(book.items[0].volumeInfo.title)")
        }
        }.disposed(by: disposeBag)

        
        
    }


}

