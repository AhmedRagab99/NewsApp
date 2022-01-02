//
//  CoreDataStorage.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 27/12/2021.
//

import Foundation

import CoreData

class CoreDataMangerStack{
    static let shared = CoreDataMangerStack()
    
    let persistentContainer: NSPersistentContainer
    let backgroundContext: NSManagedObjectContext
    let mainContext: NSManagedObjectContext
    
    
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "NewsApp")
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSSQLiteStoreType
        
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
        }
        mainContext = persistentContainer.viewContext
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        backgroundContext.parent = self.mainContext
        
    }
    
}

struct UserCoreDataStorage {
    
    static let shared = UserCoreDataStorage()
//
//    let persistentContainer: NSPersistentContainer = {
//
//        let container = NSPersistentContainer(name: "NewsApp")
//        container.loadPersistentStores { (storeDescription, error) in
//            if let error = error {
//                fatalError("Loading of store failed \(error)")
//            }
//        }
//
//        return container
//    }()
    
    let mainContext: NSManagedObjectContext

    init(mainContext: NSManagedObjectContext = CoreDataMangerStack.shared.mainContext) {
           self.mainContext = mainContext
       }
    
    @discardableResult
    func CreateUser(user:UserModel) -> UserCache? {
//        let context = persistentContainer.viewContext
        
        // old way
        // let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee // NSManagedObject
        
        // new way
        //        let employee = Employee(context: context)
        
        let userCache = UserCache(context: mainContext)
        
        userCache.name = user.user?.name ?? ""
        userCache.email = user.user?.email ?? ""
        userCache.token = user.token ?? ""
        userCache.createdAt = user.user?.createdAt ?? ""
        userCache.id = user.user?.id ?? ""
        
        
        
        do {
            try mainContext.save()
            return userCache
        } catch let error {
            print("Failed to create: \(error)")
        }
        
        return nil
    }
    
    func fetchUser() -> [UserCache]? {
        
        
        let fetchRequest = NSFetchRequest<UserCache>(entityName: "UserCache")
        
        do {
            var userCache = try mainContext.fetch(fetchRequest)
            
            //            print("before delete \(userCache.count)")
            //
            //            let names = ["Jim", "Jenny", "Earl"]
            //
            //            for i in userCache.indices.dropLast() {
            //                deleteUser(user: userCache[i])
            //            }
            //
            //            print("after delete \(userCache.count)")
            
            
            return userCache
            
        } catch let error {
            print("Failed to fetch companies: \(error)")
        }
        
        return nil
    }
    
    func fetchUser(withName name: String) -> UserCache? {
//        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<UserCache>(entityName: "UserCache")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let userCache = try mainContext.fetch(fetchRequest)
            return userCache.first
        } catch let error {
            print("Failed to fetch: \(error)")
        }
        
        return nil
    }
    
    func deleteUser(user:UserCache){
//        let context = persistentContainer.viewContext
            
        
        
        do {
            mainContext.delete(user)
            try mainContext.save()
        } catch let error {
            print(error.localizedDescription)
            
        }
    }
  
    
}


