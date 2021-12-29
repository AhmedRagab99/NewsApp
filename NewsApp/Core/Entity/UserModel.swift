//
//  User.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 23/12/2021.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userModel = try? newJSONDecoder().decode(UserModel.self, from: jsonData)

import Foundation

// MARK: - UserModel
struct UserModel: Codable {
    let user: User?
    let token: String?
    
    static let storage = CoreDataStorage.shared
    
    
    func addUserToCacheStore(data:UserModel){

        guard let userCacheModel =
                CoreDataStorage.shared.add(UserCache.self)  else {
            print("user cannot geet the model")
            return
            
            
        }
        
        
        
        userCacheModel.id = user?.id ?? ""
        userCacheModel.name = user?.name ?? ""
        userCacheModel.email = user?.email ?? ""
        userCacheModel.createdAt = user?.createdAt ??   ""
        
        userCacheModel.token =  token ?? ""
        print(userCacheModel)
        
        
             UserModel.storage.save()
      
        
        
    }
}

// MARK: - User
struct User: Codable {
    let id, name, email : String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email
        case createdAt = "created_at"
    }
    
    
}


