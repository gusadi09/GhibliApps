//
//  Film.swift
//  GhibliApps
//
//  Created by Gus Adi on 22/07/21.
//

import Foundation

struct Film: Equatable, Hashable, Decodable {
    var title: String
    var description: String
    var release_date: String
    var director: String
}

extension Film {
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case release_date
        case director
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        release_date = try container.decode(String.self, forKey: .release_date)
        director = try container.decode(String.self, forKey: .director)
    }
}


