//
//  DataController.swift
//  WhatToEat
//
//  Created by Nadyah Abdulrahman on 29/12/1441 AH.
//  Copyright © 1441 Sarah Alhabib. All rights reserved.
//

import Foundation
import CoreData

class DataController{
    let persistentContainer:NSPersistentContainer
    
    var viewContext:NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    var backgroundContext:NSManagedObjectContext!
    
    init(modelName:String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func configureContexts(){
        backgroundContext = persistentContainer.newBackgroundContext()
        
        backgroundContext.automaticallyMergesChangesFromParent = true
        viewContext.automaticallyMergesChangesFromParent = true
        
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        
    }
    
    func load(completion: (()->Void)?=nil){
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            self.configureContexts()
            completion?()
            }
        }
    
    static let shared = DataController(modelName: "WhatToEat")
    }
        
    


