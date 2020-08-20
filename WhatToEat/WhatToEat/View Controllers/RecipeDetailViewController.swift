//
//  ViewController.swift
//  WhatToEat
//
//  Created by Nadyah Abdulrahman on 28/12/1441 AH.
//  Copyright © 1441 Sarah Alhabib. All rights reserved.
//

import UIKit
import Kingfisher


class RecipeDetailViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var isSaved:Bool!
    var searchRecipe:RecipeByIngredients!
    var savedRecipe:Recipe!
    var storage:NSTextStorage!
    var image:UIImage!
    var ingredientsString:String=""
    var instructionsString:String=""
    
    let titleAtributes: [NSAttributedString.Key:Any] = [
        .font: UIFont.preferredFont(forTextStyle: .title1)
    ]
    let bodyAtribbutes: [NSAttributedString.Key:Any] = [
        .font: UIFont.preferredFont(forTextStyle: .body)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isEditable = false
        storage = textView.textStorage
        
        
        if !isSaved{
            saveButton.isEnabled=true
            navigationItem.title=searchRecipe.title
            createIngriedentsString()
            addImageToTextView()
            addIngredientsToTextView()
            handleGetInstructionsRequest()
        }
        else {
            saveButton.isEnabled=false
            ingredientsString=savedRecipe.ingredients ?? ""
            instructionsString=savedRecipe.instructions ?? ""
            navigationItem.title=savedRecipe.name
            
            addImageToTextView()
            addIngredientsToTextView()
            addInstructionsToTextView()
        }
    }

    //MARK: -Text View
    fileprivate func addImageToTextView() {
        if isSaved{
            image = UIImage(data: savedRecipe.image!)
        }
        else{
            let url = URL(string: searchRecipe.image)
            
            //kingFisher framework
            KingfisherManager.shared.retrieveImage(with: url!) { result in
                try? self.image = result.get().image
            }
        }
        if let image=image{
        let attachment = NSTextAttachment(image: image)
        attachment.adjustsImageSizeForAccessibilityContentSizeCategory = true
        let attachmentstring = NSMutableAttributedString(attachment: attachment)
        storage.append(attachmentstring)
        }
    }
    
    fileprivate func addIngredientsToTextView() {
        let ingredientsTitle = NSAttributedString(string: "Ingredients\n", attributes: titleAtributes)
        storage.append(ingredientsTitle)
        
        let ingredientsText = NSAttributedString(string: ingredientsString+"\n", attributes: bodyAtribbutes)
        storage.append(ingredientsText)
    }
    
    fileprivate func addInstructionsToTextView() {
        let instructionsTitle = NSAttributedString(string: "Instructions\n", attributes: titleAtributes)
        storage.append(instructionsTitle)
        
        let instructionsText = NSAttributedString(string:instructionsString+"\n", attributes: bodyAtribbutes)
        storage.append(instructionsText)
    }
    
    func createIngriedentsString(){
        ingredientsString=""
        for ingredient in searchRecipe.usedIngredients{
            ingredientsString.append(ingredient.original + "\n")
        }
        for ingredient in searchRecipe.missedIngredients{
            ingredientsString.append(ingredient.original+"\n")
        }
        
    }

    //MARK: -Network Request Handler
    //to get instruction for the selected recipe if it is not saved yet
    func handleGetInstructionsRequest(){
        instructionsString=""
        activityIndicator.startAnimating()
        SpoonacularClient.getRecipeInstructions(id: searchRecipe.id, completion: { (steps, error) in
            if error != nil {
                self.showAlert(dataType: "Instructions")
            }
            else{
                for step in steps{
                    self.instructionsString.append("-"+step.step+"\n\n")
                }
                self.addInstructionsToTextView()
            }
            self.activityIndicator.stopAnimating()
        })
    }
    
    //MARK: -Store Recipe
    @IBAction func saveRecipe(_ sender: Any) {
        let recipeToSave:Recipe = Recipe(context: DataController.shared.viewContext)
        recipeToSave.name=navigationItem.title
        recipeToSave.id=Int32(exactly: searchRecipe.id) ?? 0
        recipeToSave.image=image.jpegData(compressionQuality: 1)
        recipeToSave.ingredients=ingredientsString
        recipeToSave.instructions=instructionsString
        try? DataController.shared.viewContext.save()
        navigationController?.popViewController(animated: true)
    }
    
    
}


