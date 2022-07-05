//
//  ChuckClasses.swift
//  ChuckNorrisFacts
//
//  Created by Lorhany Moraes on 29/06/22.
//

import Foundation

struct ChuckJoke : Encodable {
    
    var categories: [String] = []
    let id: String
    let url: String
    let value: String
    
    init (categories: [String], id: String, url: String, value:String ) {
        self.categories = categories
        self.id = id
        self.url = url
        self.value = value
    }
}

struct Categorys: Encodable {
    let categories: String!

    init(categories: String) {
        self.categories = categories
    }
}
