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
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchPopularMovies()
        setUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLabels()
    }
    func setUp() {
        
        self.navigationController?.navigationBar.isHidden = true
        collectionView.dataSource = self
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
extension DashboardVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
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
    
    
    
}
extension DashboardVC: DashboardViewModelDelegate {
    
    func successfulFetchMovies(moviesList: PopularMoviesModel) {
        popularMoviesList = moviesList
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
