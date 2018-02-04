//
//  CoreDataStore.swift
//  iweather
//
//  Created by Гриша on 19.01.2018.
//  Copyright © 2018 sapgv. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStore: NSObject {
    
    var persistentStoreCoordinator : NSPersistentStoreCoordinator!
    var managedObjectModel : NSManagedObjectModel!
    var managedObjectContext : NSManagedObjectContext!
    
    override init() {
        
        managedObjectModel = NSManagedObjectModel.mergedModel(from: nil)
        
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        let domains = FileManager.SearchPathDomainMask.userDomainMask
        let directory = FileManager.SearchPathDirectory.documentDirectory
        
        let applicationDocumentsDirectory = FileManager.default.urls(for: directory, in: domains).first!
        let options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
        
        let storeURL = applicationDocumentsDirectory.appendingPathComponent("geoWeather.sqlite")
        
        try! persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        managedObjectContext.undoManager = nil
        
        super.init()
    }
    
    func fetchListData(_ name: String, completionBlock: (([_List]) -> Void)!) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>  = NSFetchRequest(entityName: "List")

        let description = NSEntityDescription.entity(forEntityName: "List", in: managedObjectContext)!
        fetchRequest.entity = description
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        let sort = NSSortDescriptor(key: #keyPath(_List.date), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        let queryResults = try? managedObjectContext.fetch(fetchRequest)
        let managedResults = queryResults! as! [_List]
        completionBlock(managedResults)
    }
    
    func createListData() -> _List {
        let newList = NSEntityDescription.insertNewObject(forEntityName: "List", into: managedObjectContext) as! _List
        return newList
    }
    
    func save() {
        do {
            try managedObjectContext.save()
        } catch let error {
            print(error)
        }
    }
    
    
}
