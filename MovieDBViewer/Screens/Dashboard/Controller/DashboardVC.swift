//
//  DashboardVC.swift
//  MovieDBViewer
//
//  Created by Tausif Murtaza
//

import UIKit

class DashboardVC: MasterVC {
    
    //MARK:- Outlets
    @IBOutlet weak var welcome: UILabel!
    @IBOutlet weak var subHeadingLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- Properties
    var viewModel = DashboardViewModel()
    var popularMoviesList: PopularMoviesModel? = nil
    var currentPage = 1
    var isLoadingData = false
    var offsetY = 0.0
    var lastScrollPosition = 0.0
    var intialScrollPosition = 0.0
    var isScrollViewInitialPositionNotGet = true
    var lastContentOffset: CGFloat = 0
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchPopularMovies(page: currentPage)
        setUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLabels()
    }
    func setUp() {
        
        self.navigationController?.navigationBar.isHidden = true
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "dashboardMoviesCell", bundle: nil), forCellWithReuseIdentifier: "dashboardMoviesCell")
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10)
    }
    func showLabels() {
        welcome.isHidden = false
        subHeadingLbl.isHidden = false
    }
    func hideLabels() {
        welcome.isHidden = true
        subHeadingLbl.isHidden = true
    }
    
}
extension DashboardVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        popularMoviesList?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = popularMoviesList?.results[indexPath.row]
        let cell:dashboardMoviesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardMoviesCell", for: indexPath) as! dashboardMoviesCell
        if let model = model {
            cell.configCell(model: model)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 3 - 20, height: collectionView.bounds.height / 4 + 30 )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = popularMoviesList?.results[indexPath.row] {
            navigateToDetailVC(model: model)
        } else {
            //handle Empty
        }
    }
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("****\(indexPaths)")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isScrollViewInitialPositionNotGet {
            intialScrollPosition = scrollView.frame.origin.y
            isScrollViewInitialPositionNotGet = false
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let currentOffset = scrollView.contentOffset.y
        if currentOffset > lastContentOffset {
            // Scrolling downward
            currentPage += 1
            fetchMoreData()
            print("Scrolling downward")
            
        } else if currentOffset < lastContentOffset {
            
            print("Scrolling upward")
        } else {
            // Content offset hasn't changed
        }
        lastContentOffset = currentOffset
        print("scrollView Y: \(scrollView.frame.origin.y)")
        print("Total Found: \(popularMoviesList?.results.count ?? 0)")
        
        print("intialScrollPosition: \(intialScrollPosition)")
        print("lastScrollPosition: \(lastScrollPosition)")
    }
    func fetchMoreData() {
        isLoadingData = true
        viewModel.fetchPopularMovies(page: currentPage)
        
    }
    
}
extension DashboardVC: DashboardViewModelDelegate {
    
    func successfulFetchMovies(moviesList: PopularMoviesModel) {
        if currentPage > 1 {
            for i in 0..<moviesList.results.count {
                popularMoviesList?.results.append(moviesList.results[i])
            }
            self.isLoadingData = false
        } else {
            
            popularMoviesList = moviesList
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func failToFetchMovies(errorMessage: String) {
        print(errorMessage)
    }
}

extension DashboardVC {
    
    func navigateToDetailVC(model: PopularMoviesList) {
        
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailViewController.model = model
            hideLabels()
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
