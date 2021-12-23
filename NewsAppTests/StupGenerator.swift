//
//  stupGenerator.swift
//  NewsAppTests
//
//  Created by Ahmed Ragab on 23/12/2021.
//

import Foundation
@testable import NewsApp


class StubGenerator {
    func stubUsers() ->UserModel {
        let path = Bundle.main.path(forResource: "UserStup", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .iso8601
        let user = try! decoder.decode(UserModel.self, from: data)
        return user
    }
    
//    func stupUser()->UserModel{
//
//    }
}
