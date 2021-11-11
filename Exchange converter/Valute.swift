//
//  Valute.swift
//  Exchange converter
//
//  Created by Ярослав Акулов on 24.10.2021.
//

import Foundation

struct WebsiteDescription: Decodable {
    let Date: Date
    let Valute: [String: ValuteDescription]
}

struct ValuteDescription: Decodable {
    let CharCode: String
    let Nominal: Int
    let Name: String
    let Value: Double
    let Previous: Double
}
