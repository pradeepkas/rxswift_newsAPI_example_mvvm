//
//  MockNews.swift
//  DemoWithNewsAPI
//
//  Created by Pradeep kumar on 30/6/23.
//

import Foundation


struct NewsList: Decodable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}


struct NewsDataResponse: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [NewsList]?
}

