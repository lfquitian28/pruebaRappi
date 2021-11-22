//
//  CoreDataRappiMoviesResponseStorage.swift
//  PruebaRappi
//
//  Created by luis quitan on 15/11/21.
//

import Foundation
import CoreData

final class CoreDataRappiMoviesResponseStorage {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }

    // MARK: - Private

    private func fetchRequest(for requestDto: RappiMoviesRequestDTO) -> NSFetchRequest<RappiMoviesRequestEntity> {
        let request: NSFetchRequest = RappiMoviesRequestEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@ AND %K = %d",
                                        #keyPath(RappiMoviesRequestEntity.query), requestDto.query,
                                        #keyPath(RappiMoviesRequestEntity.page), requestDto.page)
        return request
    }

    private func deleteResponse(for requestDto: RappiMoviesRequestDTO, in context: NSManagedObjectContext) {
        let request = fetchRequest(for: requestDto)

        do {
            if let result = try context.fetch(request).first {
                context.delete(result)
            }
        } catch {
            print(error)
        }
    }
}

extension CoreDataRappiMoviesResponseStorage: RappiMoviesResponseStorage {

    func getResponse(for requestDto: RappiMoviesRequestDTO, completion: @escaping (Result<RappiMoviesResponseDTO?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest = self.fetchRequest(for: requestDto)
                let requestEntity = try context.fetch(fetchRequest).first

                completion(.success(requestEntity?.response?.toDTO()))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }

    func save(response responseDto: RappiMoviesResponseDTO, for requestDto: RappiMoviesRequestDTO) {
        coreDataStorage.performBackgroundTask { context in
            do {
                self.deleteResponse(for: requestDto, in: context)

                let requestEntity = requestDto.toEntity(in: context)
                requestEntity.response = responseDto.toEntity(in: context)

                try context.save()
            } catch {
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataRappiMoviesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
}
