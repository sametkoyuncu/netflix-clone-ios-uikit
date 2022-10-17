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
    case failedToDeleteDataWith404
    case failedToCheckDownloadedData
}

class DataPersistenceManager {
    static let shared = DataPersistenceManager()
    
    private init() {}
    
    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void) {
        let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        
        let item = TitleItem(context: context)
        
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
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToSaveData ))
        }
    }
    
    func fetchingTitlesFromDatabase(completion: @escaping (Result<[TitleItem], Error>) -> Void) {
        let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        
        let request: NSFetchRequest<TitleItem>
        
        request = TitleItem.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void) {
        let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
    
    func deleteTitleBy(id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let fetchRequest: NSFetchRequest<TitleItem> = TitleItem.fetchRequest()
        let predicate = NSPredicate(format: "(id = %@)", NSNumber(value: id))
        fetchRequest.predicate = predicate
        
        let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        
        do {
            let result = try context.fetch(fetchRequest).first
            
            if let result = result {
                context.delete(result)
                
                try context.save()
                completion(.success(()))
            }
            
            completion(.failure(DatabaseError.failedToDeleteDataWith404))
            
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
    
    func isDownloaded(_ id: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let fetchRequest: NSFetchRequest<TitleItem> = TitleItem.fetchRequest()
        let predicate = NSPredicate(format: "(id = %@)", NSNumber(value: id))
        fetchRequest.predicate = predicate
        
        let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        
        do {
            let result = try context.fetch(fetchRequest).first
            
            if let _ = result {
                completion(.success(true))
            } else {
                completion(.success(false))
            }
            
        } catch {
            completion(.failure(DatabaseError.failedToCheckDownloadedData))
        }
    }
}
