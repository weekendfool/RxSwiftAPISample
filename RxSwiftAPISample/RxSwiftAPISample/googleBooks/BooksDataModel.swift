//
//  BooksDataModel.swift
//  RxSwiftAPISample
//
//  Created by Oh!ara on 2022/06/14.
//

import Foundation

class BookDataModel: Decodable {
    
    struct BookDataModel {
        let title: String
        let publishData: String
        let auther: String
        let thumbnail: UIImage
    }
    
}
