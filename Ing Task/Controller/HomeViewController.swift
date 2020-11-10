//
//  HomeViewController.swift
//  Ing Task
//
//  Created by Bilgehan Senay on 7.11.2020.
//  Copyright © 2020 Bilgehan Senay. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var itemSize:CGSize = .zero
    var movieList: [Result] = []   // hold all movies that fetched
    var filteredMovieList: [Result] = []

    var pageNumber: Int = 1
    
    var isShowTypeList: Bool = false // other option is grid
    var isUserSearch: Bool = false
    @IBOutlet weak var showTypeBarButton: UIBarButtonItem!
    @IBOutlet weak var searchBarButton: UIBarButtonItem!
    @IBOutlet weak var collectionViewTopNS: NSLayoutConstraint!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //fetch movie list from backend
    func loadMovieData(){
        NetworkManager.getMovieList(pageNumber: pageNumber) { (movieResult) in
            self.movieList += movieResult!.results
            self.filteredMovieList = self.movieList
            
            if(!self.searchBar.text!.isEmpty){
                self.filteredMovieList = self.movieList.filter {
                    return $0.title.range(of: self.searchBar.text!, options: .caseInsensitive) != nil
                }
            }
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        GlobalVariables.fetchFavoriteMovieDBItems() //read all favourite move list from local database
        loadMovieData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateMovieFavouriteSituation(notification:)), name: NSNotification.Name(rawValue: NotificationCenterKeys.MOVIE_FAVOURITE_SITUATION_CHANGED.rawValue), object: nil)
    }
    
    func initViews(){
        let itemWidth = (screenWidth - 32)/2
        itemSize = CGSize.init(width: itemWidth, height: 282)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCollectionViewCell")
        collectionView.register(UINib(nibName: "LoadMoreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "loadMoreCollectionViewCell")

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        searchBar.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboardWhenTapAround))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

    }
    
    @objc func dismissKeyboardWhenTapAround() {
        view.endEditing(true)
        self.searchBar.endEditing(true)
    }
    
    @objc func updateMovieFavouriteSituation(notification: NSNotification){
        let movieID = notification.userInfo?["movieID"] as! Int
        let isAddedFavouriteList = notification.userInfo?["isAddedFavouriteList"] as! Bool

        let favSituationChangedMovieIndex = movieList.firstIndex { ($0.id == movieID)}
        if let index = favSituationChangedMovieIndex{
            movieList[index].isAddedFavouriteList = isAddedFavouriteList
            
            if(searchBar.text!.isEmpty){
                filteredMovieList = movieList
                let indexPath = IndexPath(item: index, section: 0)
                collectionView.reloadItems(at: [indexPath])
            }else{
                if let filteredMovieIndex = filteredMovieList.firstIndex(where: { ($0.id == movieID)}){
                    filteredMovieList[filteredMovieIndex].isAddedFavouriteList = isAddedFavouriteList
                    let indexPath = IndexPath(item: filteredMovieIndex, section: 0)
                    collectionView.reloadItems(at: [indexPath])
                }
            }
        }
    }
    
    @IBAction func searchBarButtonTapped(_ sender: Any) {
        isUserSearch = isUserSearch ? false : true
        playSelectAnimation()
    }
    
    
    func playSelectAnimation() {
        if(isUserSearch){
            collectionViewTopNS.constant = 5
            searchBar.isHidden = false
        }else{
            collectionViewTopNS.constant = (-1 * searchBar.frame.height)
            searchBar.isHidden = true
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        
    }
    

    @IBAction func showTypeBarButtonTapped(_ sender: Any) {
        if(isShowTypeList){
            let itemWidth = (screenWidth - 32)/2
            itemSize = CGSize.init(width: itemWidth, height: 282)
        }else{
            let itemWidth = screenWidth - 20
            itemSize = CGSize.init(width: itemWidth, height: 500)
        }
        self.collectionView.reloadData()

        isShowTypeList = isShowTypeList ? false : true
        showTypeBarButton.image = isShowTypeList ? UIImage(named: "list") : UIImage(named: "grid")

    }
    
}

extension HomeViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 0){
            if(isShowTypeList){
                return itemSize
            }else{
                //I calculate title height in here and expand cell according to this height in grid mode
                let labelHeight = filteredMovieList[indexPath.row].title.calculateTitleHeight(labelWidth: itemSize.width - 4)
                let heightWithChangedLabelHeight = CGFloat(itemSize.height + CGFloat(labelHeight))
                let cellSize = CGSize.init(width: itemSize.width, height: heightWithChangedLabelHeight)
                return cellSize
            }
        }else{//for load more button
            return CGSize(width:collectionView.frame.width, height:60)
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedMovie = self.filteredMovieList[indexPath.row]
        let movieDetailNavViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailNavigationViewController") as! UINavigationController
        (movieDetailNavViewController.viewControllers[0] as! MovieDetailViewController).selectedMovie = selectedMovie
        movieDetailNavViewController.modalPresentationStyle = .fullScreen
        self.present(movieDetailNavViewController, animated: true){

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 10, bottom: 1.0, right:10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return filteredMovieList.count
        }
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            let movie = filteredMovieList[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
            cell.setMovie(movie: movie)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loadMoreCollectionViewCell", for: indexPath) as! LoadMoreCollectionViewCell
            cell.loadMoreDelegate = self
            return cell
        }
        
    }
    
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        self.searchBar.becomeFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text{
            if(searchText.isEmpty){
                filteredMovieList = movieList
            }else{
                filteredMovieList = movieList.filter {
                    return $0.title.range(of: searchText, options: .caseInsensitive) != nil
                }
            }
        }
        collectionView.reloadData()
    }

    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        searchBar.text = nil
        searchBar.resignFirstResponder()
        self.navigationItem.setHidesBackButton(false, animated:true)
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
}


extension HomeViewController: LoadMoreCollectionViewCellDelegate{
    //when user tap load mode button at indexPath.section 1, page number is incremented by one and call the function movie fetch
    func LoadMore() {
        self.pageNumber += 1
        loadMovieData()
    }
}
