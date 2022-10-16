//
//  DataPersistenceManager.swift
//  netflix-clone-ios-uikit
//
//  Created by Samet Koyuncu on 16.10.2022.
//

import Foundation
import CoreData

enum DatabaseError: Error {
    case failedToSaveData
    case failedToFetchData
    case failedToDeleteData
}

class DataPersistenceManager {
    static let shared = DataPersistenceManager()
    
    private init() {}
    
    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void) {
        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
                
        let item = TitleItem(context: managedContext)
        
        item.id = Int64(model.id)
        item.original_title = model.original_title
        item.original_name = model.original_name
        item.overview = model.overview
        item.poster_path = model.poster_path
        item.media_type = model.media_type
        item.release_date = model.release_date
        item.vote_average = model.vote_average
        item.vote_count = Int64(model.vote_count)
        
        do {
            try managedContext.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToSaveData ))
        }
    }
    
    func fetchingTitlesFromDatabase(completion: @escaping (Result<[TitleItem], Error>) -> Void) {
        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        
        let request: NSFetchRequest<TitleItem>
        
        request = TitleItem.fetchRequest()
        
        do {
            let titles = try managedContext.fetch(request)
            completion(.success(titles))
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void) {
        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        
        managedContext.delete(model)
        
        do {
            try managedContext.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
}
