//
//  DetailViewModel.swift
//  GhibliApps
//
//  Created by Gus Adi on 22/07/21.
//

import Foundation
import Combine

final class DetailViewModel {
    @Published var title: String = ""
    @Published var release: String = ""
    @Published var director: String = ""
    @Published var description: String = ""
        
    let film: Film
    
    init(films: Film) {
        self.film = films
        
        setUpBindings()
    }
    
    private func setUpBindings() {
        title = film.title
        release = film.release_date
        director = film.director
        description = film.description
    }
}
