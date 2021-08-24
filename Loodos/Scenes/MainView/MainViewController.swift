//
//  MainViewController.swift
//  Loodos
//
//  Created by Baran on 23.08.2021.
//

import UIKit

class MainViewController: UIViewController, LoadingViewPresentable {
  
  // MARK: Properties
  private var searchBar = UISearchBar().with({
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.placeholder = " Search..."
    $0.tintColor = .americanRed
    $0.barTintColor = .darkJungleGreen
    $0.sizeToFit()
  })
  
  private var resultLabel = UILabel().with({
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.textColor = .americanRed
    $0.textAlignment = .right
    $0.font = UIFont.systemFont(ofSize: 12.0)
  })
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 10
    layout.sectionInset = .zero
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.register(cellWithClass: MainCollectionViewCell.self)
    cv.backgroundColor = .clear
    cv.showsVerticalScrollIndicator = false
    return cv
  }()
  
  private lazy var viewModel = MainViewModel()
  
  // MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .charlestonGreen
    configure()
    viewModel.delegate = self
    searchBar.delegate = self
    collectionView.delegate = self
    collectionView.dataSource = self
    startAnimating()
    let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
    textFieldInsideUISearchBar?.textColor = UIColor.americanRed
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureNavigationBar()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    viewModel.fetchMovies()
  }
  
  // MARK: Functions
  private func configure() {
    view.addSubview(views: searchBar, resultLabel, collectionView)
    searchBar.fill(.horizontally)
    resultLabel.fill(.horizontally, with: 10)
    collectionView.fill(.horizontally)
    
    searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    
    resultLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 4).isActive = true
    resultLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
    
    collectionView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 2).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
  private func configureNavigationBar() {
    title = "Loodos"
    navigationController?.setNavigationBarHidden(false, animated: false)
    navigationController?.navigationBar.makeTransparent()
    navigationItem.setHidesBackButton(true, animated: false)
    navigationController?.navigationBar.setTitleFont(UIFont(name: "HelveticaNeue-Bold", size: 23)!, color: .verdigris)
  }
  
}

// MARK: - Extension
extension MainViewController: MainViewModelDelegete {
  func handleOutput(_ output: MainModelOutput) {
  
    switch output {
    case .didFetchList(let result):
      switch result {
      case .success(let data):
        stopAnimating()
        resultLabel.text = data.totalResults
        collectionView.reloadData()
      case .failure(let error):
        showErrorController(with: error)
      }
    }
    
  }
}

extension MainViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    print(searchText)
  }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.dataSource.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withClass: MainCollectionViewCell.self, for: indexPath)
    cell.configure(with: viewModel.dataSource[indexPath.item])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //    if let cell = collectionView.cellForItem(at: indexPath) as? UICollectionViewPresentable {
    //      AnalyticsEvents.selectItem.logEvent([
    //        .type: .selectItem(.challenge),
    //        .id: .value(cell.model?.id ?? ""),
    //        .title: .value(cell.model?.title ?? "")
    //      ], services: .firebase, .amplitude)
    //      let destination =  ChallengeDetailsViewController(id: cell.model?.id, ref: .categoryDetail)
    //      navigationController?.show(destination, sender: self)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.calculateWidth(for: 1)
    return CGSize(width: width, height: 180)
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    //    guard indexPath.item == presenter.dataSource.count - 1 else { return }
    //    if let path = path {
    //      presenter.getDataSource(with: path)
    //    } else if let categoryId = categoryId {
    //      presenter.getDataSource(categoryId: categoryId)
    //    }
  }
  
}
