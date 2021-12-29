//
//  UserCache.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 27/12/2021.
//

import Foundation

import CoreData


 @objc public class UserCache:NSManagedObject{
    @NSManaged dynamic var id:String
    @NSManaged dynamic var name:String
    @NSManaged dynamic var email:String
    @NSManaged dynamic var token:String
    @NSManaged dynamic var createdAt:String

}

extension UserCache{
    
//    public  class func fetchRequest() -> NSFetchRequest<UserCache> {
//        return NSFetchRequest<UserCache>(entityName: "UserCache")
//    }
//     public class override func fetchRequest() -> NSFetchRequest<UserCache> {
//        return NSFetchRequest<UserCache>(entityName:"UserCache")
//    }
}

//
//protocol DomainModelProtocol {
//    associatedtype DomainModelType
//    func toDomainModel() -> DomainModelType
//}
//
//@objc(UserCached)
//public class UserCashed:NSManagedObject{}
//
//extension UserCashed{
//    public func fetchRequest() -> NSFetchRequest<UserCashed>{
//        return NSFetchRequest<UserCashed>(entityName:"User")
//    }
//
//    @NSManaged public var id: String?
//    @NSManaged public var name: String?
//    @NSManaged public var email: String?
//    @NSManaged public var token: String?
//    @NSManaged public var createdAt: String?
//
//}
//
//extension UserCashed:DomainModelProtocol{
//    func toDomainModel() -> UserModel {
//        return UserModel(user: User(id:id, name:name,email: email, createdAt: createdAt), token: token)
//    }
//
//
//}
