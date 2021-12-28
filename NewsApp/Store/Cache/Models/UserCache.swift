//
//  UserCache.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 27/12/2021.
//

import Foundation

import CoreData


@objc
public class UserCache:NSManagedObject{
    @NSManaged var id:String
    @NSManaged var name:String
    @NSManaged var email:String
    @NSManaged var token:String
    @NSManaged var createdAt:String
}


