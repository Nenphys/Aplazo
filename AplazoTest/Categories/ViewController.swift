//
//  ViewController.swift
//  AplazoTest
//
//  Created by Jorge Chavez on 27/12/21.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

  var allCategories = [Category]()
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
    view.addSubview(collectionView)
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    AllRequests.shared.getAllCategories { categories in
      self.allCategories.append(contentsOf: categories)
      AllRequests.shared.getRandomMeal { radomMeal in
        let random = Category.init(idCategory: radomMeal.first?.idMeal ?? "", strCategory: radomMeal.first?.strCategory ?? "", strCategoryThumb: radomMeal.first?.strMealThumb ?? "", strCategoryDescription: radomMeal.first?.strInstructions ?? "")
        self.allCategories.append(random)
        self.collectionView.reloadData()
      }
    }
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    allCategories.removeAll()
    AllRequests.shared.allCategories.removeAll()
    AllRequests.shared.mealDetail.removeAll()
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return allCategories.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as! CategoriesCollectionViewCell
    cell.imageView.load(url: getImageUrl(url: allCategories[indexPath.row].strCategoryThumb))
    cell.title.text = allCategories[indexPath.row].strCategory
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(
      width: (view.frame.size.width/3)-3,
      height: (view.frame.size.width/3)-3
    )
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    let mealsVc = MealsViewController()
    mealsVc.category = allCategories[indexPath.row].strCategory
    self.navigationController?.pushViewController(mealsVc, animated: true)
  }

  private func getImageUrl(url:String) -> URL {
    return URL(string: url) ?? URL(fileURLWithPath:"")
  }
}

