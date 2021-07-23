//
//  FilmService.swift
//  GhibliApps
//
//  Created by Gus Adi on 22/07/21.
//

import Foundation
import Combine

enum ServiceError: Error {
    case url(URLError)
    case urlRequest
    case decode
}

protocol FilmServiceProtocol {
    func get() -> AnyPublisher<[Film], Error>
}

final class FilmService: FilmServiceProtocol {
    
    func get() -> AnyPublisher<[Film], Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        return Future<[Film], Error> { promise in
            let url = URL(string: "https://ghibliapi.herokuapp.com/films")!
            let session = URLSession.shared
            
            dataTask = session.dataTask(with: url) { (data, _, error) in
                do {
                    if let d = data {
                        let json = try JSONDecoder().decode([Film].self, from: d)
                        print(json)
                        promise(.success(json))
                   }
                }
                catch {
                    print("Error \(error)")
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
        
        
    }
    
    func apiService(completion: @escaping ([Film]) -> Void) {
        let url = URL(string: "https://ghibliapi.herokuapp.com/films")!
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, _, error) in
            do {
                if let d = data {
                    let json = try JSONDecoder().decode([Film].self, from: d)
                    completion(json)
               }
            }
            catch {
                print("Error \(error)")
                
            }
        }.resume()
        
    }
}
