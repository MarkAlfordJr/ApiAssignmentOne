//
//  WeatherData.swift
//  AssignmentOne
//
//  Created by Mark Alford on 7/22/21.
//

import Foundation

//create a data model to get/access data from JSON
//acces the object
struct WeatherData: Codable {
    let current: Current
}

//access the members of the current object
struct Current: Codable {
    let temp_c: Double
    let temp_f: Double
    let condition: Condition
}

//access the members of the condiotn object
struct Condition: Codable {
    let text: String
    let icon: String
}
