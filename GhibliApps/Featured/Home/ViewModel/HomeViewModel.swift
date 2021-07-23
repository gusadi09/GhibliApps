//
//  HomeViewModel.swift
//  GhibliApps
//
//  Created by Gus Adi on 22/07/21.
//

import Foundation
import Combine

enum HomeViewModelState {
    case loading
    case finishedLoading
    case error(Error)
}

final class HomeViewModel {
    enum Section { case film }

    @Published private(set) var films: [Film] = []
    @Published private(set) var state: HomeViewModelState = .loading
    
    private let filmService: FilmServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    init(filmService: FilmServiceProtocol = FilmService()) {
        self.filmService = filmService
        
        self.fetchFilm()
    }
    
    func fetchFilm() {
        state = .loading
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case .failure(let error): self?.state = .error(error)
            case .finished: self?.state = .finishedLoading
            }
        }
        
        let valueHandler: ([Film]) -> Void = { [weak self] film in
            self?.films = film
        }
        
        filmService.get().sink(receiveCompletion: completionHandler, receiveValue: valueHandler).store(in: &bindings)
    }
}
