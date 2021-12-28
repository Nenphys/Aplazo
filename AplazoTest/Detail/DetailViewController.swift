//
//  DetailViewController.swift
//  AplazoTest
//
//  Created by Jorge Chavez on 27/12/21.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var mealName: UILabel!
  @IBOutlet weak var mealImage: UIImageView!
  @IBOutlet weak var mealInstructions: UILabel!
  var mealDetailArray = MealsDetail()
  var detailId = ""
  override func viewDidLoad() {
        super.viewDidLoad()
    }

  func setup() {
    guard let mealDetail = mealDetailArray.first else { return }
    mealName.text = mealDetail.strMeal
    mealImage.load(url: getImageUrl(url: mealDetail.strMealThumb ?? ""))
    mealInstructions.adjustsFontSizeToFitWidth = true
    mealInstructions.text = mealDetail.strInstructions ?? ""

  }
  override func viewWillAppear(_ animated: Bool) {
    AllRequests.shared.getMealsDetail(id: detailId) { meal in
      self.mealDetailArray.append(contentsOf: meal)
      self.setup()
    }
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    AllRequests.shared.mealDetail.removeAll()
    mealDetailArray.removeAll()
  }

  @IBAction func youtubeBtn(_ sender: Any) {
    guard let mealDetail = mealDetailArray.first,
    let youtubeUrl = mealDetail.strYoutube else { return }
    UIApplication.shared.open(getImageUrl(url: youtubeUrl))
  }

  @IBAction func sourceBtn(_ sender: Any) {
    guard let mealDetail = mealDetailArray.first,
          let sourceUrl = mealDetail.strSource else { return }
    UIApplication.shared.open(getImageUrl(url: sourceUrl))
  }
  
  private func getImageUrl(url:String) -> URL {
    return URL(string: url) ?? URL(fileURLWithPath:"")
  }
}
