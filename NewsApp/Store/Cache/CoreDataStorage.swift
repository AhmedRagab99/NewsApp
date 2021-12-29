//
//  CoreDataStorage.swift
//  NewsApp
//
//  Created by Ahmed Ragab on 27/12/2021.
//

import Foundation

import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "NewsApp")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }
        
        return container
    }()
    
    @discardableResult
    func CreateUser(user:UserModel) -> UserCache? {
        let context = persistentContainer.viewContext
        
        // old way
        // let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee // NSManagedObject
        
        // new way
        //        let employee = Employee(context: context)
        let userCache = UserCache(context: context)
        
        userCache.name = user.user?.name ?? ""
        userCache.email = user.user?.email ?? ""
        userCache.token = user.token ?? ""
        userCache.createdAt = user.user?.createdAt ?? ""
        userCache.id = user.user?.id ?? ""
        
        
        
        do {
            try context.save()
            return userCache
        } catch let error {
            print("Failed to create: \(error)")
        }
        
        return nil
    }
    
    func fetchUsers() -> [UserCache]? {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<UserCache>(entityName: "UserCache")
        
        do {
            let userCache = try context.fetch(fetchRequest)
            return userCache
        } catch let error {
            print("Failed to fetch companies: \(error)")
        }
        
        return nil
    }
    
    func fetchUser(withName name: String) -> UserCache? {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<UserCache>(entityName: "UserCache")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let userCache = try context.fetch(fetchRequest)
            return userCache.first
        } catch let error {
            print("Failed to fetch: \(error)")
        }
        
        return nil
    }
    
    func deleteUser(user:UserCache)->Bool{
        let context = persistentContainer.viewContext
        do {
            try context.delete(user)
            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }
    
    //    func updateEmployee(employee: Employee) {
    //        let context = persistentContainer.viewContext
    //
    //        do {
    //            try context.save()
    //        } catch let error {
    //            print("Failed to update: \(error)")
    //        }
    //    }
    
    //    func deleteEmployee(user: UserModel) {
    //        let context = persistentContainer.viewContext
    //        context.delete(employee)
    //
    //        do {
    //            try context.save()
    //        } catch let error {
    //            print("Failed to delete: \(error)")
    //        }
    //    }
    
}


