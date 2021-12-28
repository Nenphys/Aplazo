//
//  Meals.swift
//  AplazoTest
//
//  Created by Jorge Chavez on 27/12/21.
//

import Foundation
typealias Meals = [Meal]

struct Meal: Codable {

  var strMeal: String
  var strMealThumb: String
  var idMeal: String


  enum CodingKeys: String, CodingKey {
    case strMeal
    case strMealThumb
    case idMeal
  }
}


