//
//  SavedRecipesTableViewController.swift
//  WhatToEat
//
//  Created by Nadyah Abdulrahman on 29/12/1441 AH.
//  Copyright © 1441 Sarah Alhabib. All rights reserved.
//

import UIKit
import CoreData

class SavedRecipesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var savedRecipes:[Recipe]!
    var selectedIndex:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "My Recipes"
        navigationItem.rightBarButtonItem = editButtonItem
        
        tableView.delegate=self
        tableView.dataSource=self
        
        fetchRecipes()
        tableView.reloadData()
        
    }
    
    func fetchRecipes(){
        let fetchRequest:NSFetchRequest<Recipe>=Recipe.fetchRequest()
        do{
            self.savedRecipes = try DataController.shared.viewContext.fetch(fetchRequest)
        }
        catch{
            fatalError("the fetch could not be performed \(error.localizedDescription)")
        }
    }
    
    func deleteRecipe(index: Int){
        let recipeToDelete = savedRecipes[index]
        DataController.shared.viewContext.delete(recipeToDelete)
        try? DataController.shared.viewContext.save()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedRecipes.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = savedRecipes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath)
        cell.textLabel?.text = recipe.name

        cell.imageView?.image=UIImage(data: recipe.image!)

        return cell
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the recipe from the store
            deleteRecipe(index: indexPath.row)
            // Delete the row from the data source
            savedRecipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    //MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex=indexPath.row
        performSegue(withIdentifier: "savedRecipeDetail", sender: self)
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! RecipeDetailViewController
        vc.savedRecipe=savedRecipes[selectedIndex]
        vc.isSaved = true}

}
