//
//  SearchViewController.swift
//  WhatToEat
//
//  Created by Nadyah Abdulrahman on 29/12/1441 AH.
//  Copyright © 1441 Sarah Alhabib. All rights reserved.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var searchRecipeResults = [RecipeByIngredients]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var selectedIndex:Int!
    var currentSearchTask: URLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate=self
        tableView.delegate=self
        tableView.dataSource=self
        // Do any additional setup after loading the view.
    }
    
    //MARK:-Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchText.replacingOccurrences(of: " ", with: ",")
        currentSearchTask?.cancel()
        activityIndicator.startAnimating()
        currentSearchTask = SpoonacularClient.getRecipesByIngredients(ingredients: searchText, completion: { (results, error) in
            if error != nil && error?.localizedDescription != "cancelled"{
                self.showAlert(dataType: "Recipes")
            }
            else{
            self.searchRecipeResults=results
            self.tableView.reloadData()
            }
            self.activityIndicator.stopAnimating()
        })
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    

}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate{
    
    //MARK: -Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchRecipeResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = searchRecipeResults[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
        cell.textLabel?.text = recipe.title
        
        //kingFisher framework
        let image = UIImage(named: "placeHolder")
        cell.imageView?.kf.setImage(with: URL(string: recipe.image), placeholder: image)
        return cell
    }
    
    //MARK: -Table View Delegat
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex=indexPath.row
        performSegue(withIdentifier: "searchResultDetail", sender: self)
    }
    
    //MARK: -Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! RecipeDetailViewController
        vc.searchRecipe=searchRecipeResults[selectedIndex]
        vc.isSaved = false
    }
}

//MARK: -View Conrollers' Alert
extension UIViewController{
    //MARK: Alert
    func showAlert(dataType:String) {
        let alert = UIAlertController(title: "Ops!", message: "\(dataType) could not be downloaded, check your connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
