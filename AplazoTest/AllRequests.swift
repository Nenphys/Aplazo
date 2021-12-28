//
//  AllCategories.swift
//  AplazoTest
//
//  Created by Jorge Chavez on 27/12/21.
//

import Foundation
import Alamofire
import SwiftyJSON


typealias AllCategoresCompletion = ([Category]) -> Void
typealias AllMealsCompletion = ([Meal]) -> Void
typealias MealsDetailCompletion = ([MealDetail]) -> Void
class AllRequests: NSObject {
  private override init() {}
  static let shared = AllRequests()

  var allCategories =  Categories()
  var allMeals =  Meals()
  var mealDetail = MealsDetail()

  func getAllCategories(complition:@escaping AllCategoresCompletion) {
    let url = "https://www.themealdb.com/api/json/v1/1/categories.php"
    AF.request(url).responseJSON(completionHandler: {
      Response in
      do{
        let json =  try JSON(data: Response.data!)
        let categoriesData =  json.dictionary
        let categories = categoriesData!["categories"]


        let dt = try? JSONEncoder().encode(categories)
        let category = try JSONDecoder().decode([Category].self, from: dt!)
        category.forEach { category in
          self.allCategories.append(category)
        }
        complition(self.allCategories)
      }catch{
        print("ERROR")
      }
    })
  }

  func getAllMeals(category: String, complition:@escaping AllMealsCompletion) {
    let url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)"
    AF.request(url).responseJSON(completionHandler: {
      Response in
      do{
        let json =  try JSON(data: Response.data!)
        let mealsData =  json.dictionary
        let meals = mealsData!["meals"]


        let dt = try? JSONEncoder().encode(meals)
        let mealsArray = try JSONDecoder().decode([Meal].self, from: dt!)
        mealsArray.forEach { meal in
          self.allMeals.append(meal)
        }
        complition(self.allMeals)
      }catch{
        print("ERROR")
      }
    })
  }

  func getMealsDetail(id: String, complition:@escaping MealsDetailCompletion ) {
    let url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
    AF.request(url).responseJSON(completionHandler: {
      Response in
      do{
        let json =  try JSON(data: Response.data!)
        let mealsData =  json.dictionary
        let mealsDetail = mealsData!["meals"]


        let dt = try? JSONEncoder().encode(mealsDetail)

        let mealDetailArray = try JSONDecoder().decode([MealDetail].self, from: dt!)
        mealDetailArray.forEach{ mealDetail in
          self.mealDetail.append(mealDetail)
        }
        complition(self.mealDetail)
      }catch{
        print("ERROR")
      }
    })
  }

  func getRandomMeal(complition:@escaping MealsDetailCompletion) {
    let url = "https://www.themealdb.com/api/json/v1/1/random.php"
    AF.request(url).responseJSON(completionHandler: {
      Response in
      do{
        let json =  try JSON(data: Response.data!)
        let mealsData =  json.dictionary
        let mealsDetail = mealsData!["meals"]


        let dt = try? JSONEncoder().encode(mealsDetail)

        let mealDetailArray = try JSONDecoder().decode([MealDetail].self, from: dt!)
        mealDetailArray.forEach{ mealDetail in
          self.mealDetail.append(mealDetail)
        }
        complition(self.mealDetail)
      }catch{
        print("ERROR")
      }
    })
  }
}
