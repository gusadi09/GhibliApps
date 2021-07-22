//
//  PlayersService.swift
//  CombineDemo
//
//  Created by Michal Cichecki on 30/06/2019.
//

import Foundation
import Combine

enum ServiceError: Error {
    case url(URLError)
    case urlRequest
    case decode
}

protocol FilmServiceProtocol {
    func get(searchTerm: String?) -> AnyPublisher<[Film], Error>
}

let apiKey: String = ""

final class FilmService: FilmServiceProtocol {
    
    func get(searchTerm: String?) -> AnyPublisher<[Film], Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        // promise type is Result<[Player], Error>
        return Future<[Film], Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlRequest(searchTerm: searchTerm) else {
                promise(.failure(ServiceError.urlRequest))
                return
            }
            
            dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
                guard let data = data else {
                    if let error = error {
                        promise(.failure(error))
                    }
                    return
                }
                do {
                    let film = try JSONDecoder().decode(FilmData.self, from: data)
                    promise(.success(film.data))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlRequest(searchTerm: String?) -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "free-nba.p.rapidapi.com"
        components.path = "/players"
        if let searchTerm = searchTerm, !searchTerm.isEmpty {
            components.queryItems = [
                URLQueryItem(name: "search", value: searchTerm)
            ]
        }
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 10.0
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "X-RapidAPI-Host": "free-nba.p.rapidapi.com",
            "X-RapidAPI-Key": apiKey
        ]
        return urlRequest
    }
}
