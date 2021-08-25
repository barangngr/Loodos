//
//  MainViewController.swift
//  Loodos
//
//  Created by Baran on 23.08.2021.
//

import UIKit

class MainViewController: BaseUIViewController, LoadingViewPresentable {
  
  // MARK: Properties
  private var searchBar = UISearchBar().with({
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.placeholder = " Search..."
    $0.tintColor = .americanRed
    $0.barTintColor = .darkJungleGreen
    $0.sizeToFit()
    let textFieldInsideUISearchBar = $0.value(forKey: "searchField") as? UITextField
    textFieldInsideUISearchBar?.textColor = UIColor.americanRed
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
  private var totalResult: Int = 0
  
  // MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .charlestonGreen
    fetchData()
    viewModel.delegate = self
    searchBar.delegate = self
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureNavigationBar()
    AnalyticEvents.viewScreen.logEvent(["id" : "main_view"])
  }
  
  // MARK: Functions
  override func configureViews() {
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
  
  private func fetchData() {
    // Yanlış anlamadıysam Case notlarında istenen loading animasyonunun gösterilmesi için bu kısmı ekledim.
    startAnimating()
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
      self.viewModel.fetchMovies("")
    }
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
        totalResult = Int(data.totalResults ?? "0") ?? 0
        resultLabel.text = "Total result: \(data.totalResults ?? "0")"
        collectionView.reloadData {
          self.viewModel.dataSource.count == 0 ? self.collectionView.setEmptyMessage("Uppps :(") : self.collectionView.restore()
        }
      case .failure(let error):
        showErrorController(with: error)
      }
    }
    
  }
}

extension MainViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.fetchMovies(searchText)
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
    let title = viewModel.dataSource[indexPath.item].Title ?? ""
    AnalyticEvents.selectItem.logEvent(["select_item": title])
    let targetController = DetailViewController()
    targetController.id = viewModel.dataSource[indexPath.item].imdbID
    navigationController?.show(targetController, sender: nil)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.calculateWidth(for: 1)
    return CGSize(width: width, height: 180)
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let endScrolling = (scrollView.contentOffset.y + scrollView.frame.size.height)
    let id = (viewModel.dataSource.count / 10 ) + 1
    let shouldPagination = viewModel.dataSource.count < totalResult
    if endScrolling >= scrollView.contentSize.height && endScrolling >= scrollView.frame.size.height && shouldPagination {
      viewModel.fetchMovies(searchBar.text ?? "", page: "\(id)")
    }
  }

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    searchBar.resignFirstResponder()
  }
  
}
