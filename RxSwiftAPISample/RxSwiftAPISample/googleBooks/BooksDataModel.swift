//
//  BooksDataModel.swift
//  RxSwiftAPISample
//
//  Created by Oh!ara on 2022/06/14.
//

import Foundation
import UIKit

struct BookData: Codable {
    

    var kind: String
    var items: [Items]
    
}
    
    
struct Items: Codable {

    var id: String
    var kind: String
    var etag: String
    var selfLink: String
    var volumeInfo: VolumeInfo
//    var title: String
    }

struct VolumeInfo: Codable {
        var title: String
//        var authors: [String]
    var industryIdentifiers: [IndustryIdentifier]
}

struct IndustryIdentifier: Codable {
    var type: String
    var identifier: String
}
        

