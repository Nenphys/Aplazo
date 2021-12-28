//
//  MealsViewController.swift
//  AplazoTest
//
//  Created by Jorge Chavez on 27/12/21.
//

import UIKit

class MealsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var category = ""
    var allMeals = Meals()
    override func viewDidLoad() {
        super.viewDidLoad()
      collectionView.register(MealsCollectionViewCell.self, forCellWithReuseIdentifier: MealsCollectionViewCell.identifier)
      collectionView.delegate = self
      collectionView.dataSource = self
      view.addSubview(collectionView)
       
    }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    AllRequests.shared.getAllMeals(category: category) { meals in
      self.allMeals.append(contentsOf: meals)
      self.collectionView.reloadData()
    }
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    //clear arrays
    allMeals.removeAll()
    AllRequests.shared.allMeals.removeAll()
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return allMeals.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealsCollectionViewCell.identifier, for: indexPath) as! MealsCollectionViewCell
    cell.imageView.load(url: getImageUrl(url: allMeals[indexPath.row].strMealThumb))
    cell.title.text = allMeals[indexPath.row].strMeal


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
    let mealsDetailVc = DetailViewController()
    mealsDetailVc.detailId = allMeals[indexPath.row].idMeal
    self.navigationController?.pushViewController(mealsDetailVc, animated: true)
  }

  private func getImageUrl(url:String) -> URL {
    return URL(string: url) ?? URL(fileURLWithPath:"")
  }
    
}
