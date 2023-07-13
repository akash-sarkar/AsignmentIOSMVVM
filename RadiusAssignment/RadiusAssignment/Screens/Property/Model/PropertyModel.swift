//
//  PropertyModel.swift
//  RadiusAssignment
//
//  Created by ST-MacBookpro on 29/06/23.
//

import Foundation

struct PropertyModel: Decodable {
    let facilities: [Facilities]?
    let exclusions: [[Exclusions]]?
}

struct Facilities: Decodable {
    let facility_id: String?
    let name: String?
    let options: [Option]
}

struct Option: Decodable {
    let name: String?
    let icon: String?
    let id: String?
}

struct Exclusions : Decodable {
    let facility_id: String?
    let options_id: String?
}
