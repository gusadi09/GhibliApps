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
    
}
