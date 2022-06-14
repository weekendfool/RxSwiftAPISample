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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        "https://ww.googleapis.com/books/v1/volumes?q=9784101801636"
//        model.searchGitHabUser(query: "9784101801636")
        model.searchGitHabUser()
    }


}

