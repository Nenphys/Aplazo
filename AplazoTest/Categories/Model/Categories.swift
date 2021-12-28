//
//  Categories.swift
//  AplazoTest
//
//  Created by Jorge Chavez on 27/12/21.
//

import Foundation

typealias Categories = [Category]

struct Category: Codable {
  
  var idCategory: String
  var strCategory: String
  var strCategoryThumb: String
  var strCategoryDescription:String

  enum CodingKeys: String, CodingKey {
    case idCategory
    case strCategory
    case strCategoryThumb
    case strCategoryDescription
  }
}


