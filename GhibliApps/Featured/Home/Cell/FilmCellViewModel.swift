//
//  FilmViewModel.swift
//  GhibliApps
//
//  Created by Gus Adi on 22/07/21.
//

import Foundation
import Combine

final class FilmCellViewModel {
    @Published var title: String = ""
    @Published var release: String = ""
        
    private let film: Film
    
    init(films: Film) {
        self.film = films
        
        setUpBindings()
    }
    
    private func setUpBindings() {
        title = film.title
        release = film.release_date
    }
}
