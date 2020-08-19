//
//  ViewController.swift
//  WhatToEat
//
//  Created by Nadyah Abdulrahman on 28/12/1441 AH.
//  Copyright © 1441 Sarah Alhabib. All rights reserved.
//

import UIKit


class RecipeDetailViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    
    //var recipe: Recipe!
    var storage:NSTextStorage!
    //modify this
    var recipeUrlString:String {
        return textView.text
    }
    
    let titleAtributes: [NSAttributedString.Key:Any] = [
        .font: UIFont.preferredFont(forTextStyle: .title1)
    ]
    let bodyAtribbutes: [NSAttributedString.Key:Any] = [
        .font: UIFont.preferredFont(forTextStyle: .body)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textView.isEditable = false
        storage = textView.textStorage
        
        saveButton.layer.cornerRadius = 8
        saveButton.tintColor = UIColor.white
        saveButton.backgroundColor = UIColor.systemBlue
        
        addImageToTextView()
        addIngredientsToTextView()
        addInstructionsToTextView()
        addResourceToTextView()
        
    }
    
    fileprivate func addImageToTextView() {
        let image = UIImage(named: "food")
        let attachment = NSTextAttachment(image: image!)
        attachment.adjustsImageSizeForAccessibilityContentSizeCategory = true
        let attachmentstring = NSMutableAttributedString(attachment: attachment)
        storage.append(attachmentstring)
    }
    
    fileprivate func addIngredientsToTextView() {
        let ingredientsTitle = NSAttributedString(string: "Ingredients \n", attributes: titleAtributes)
        storage.append(ingredientsTitle)
        
        let ingredientsText = NSAttributedString(string: "-1 cup salted butter* softened\n-1 cup white (granulated) sugar\n-1 cup light brown sugar packed\n*2 tsp pure vanilla extract\n*2 large eggs\n*3 cups all-purpose flour\n*1 tsp baking soda\n &frac12; tsp baking powder\n 1 tsp sea salt***\n 2 cups chocolate chips (or chunks, or chopped chocolate)\n\n", attributes: bodyAtribbutes)
        storage.append(ingredientsText)
    }
    
    fileprivate func addInstructionsToTextView() {
        let instructionsTitle = NSAttributedString(string: "Instructions \n", attributes: titleAtributes)
        storage.append(instructionsTitle)
        
        let instructionsText = NSAttributedString(string:"1- Preheat oven to 375 degrees F.\n2-Line a baking pan with parchment paper and set aside.\n3-In a separate bowl mix flour, baking soda, salt, baking powder.\n4-Set aside. Cream together butter and sugars until combined.\n5-Beat in eggs and vanilla until fluffy.\n6-Mix in the dry ingredients until combined.\n Add 12 oz package of chocolate chips and mix well. Roll 2-3 TBS (depending on how large you like your cookies) of dough at a time into balls and place them evenly spaced on your prepared cookie sheets. (alternately, use a small cookie scoop to make your cookies). Bake in preheated oven for approximately 8-10 minutes. Take them out when they are just BARELY starting to turn brown. Let them sit on the baking pan for 2 minutes before removing to cooling rack.\n\n", attributes: bodyAtribbutes)
        storage.append(instructionsText)
    }
    
    fileprivate func addResourceToTextView() {
        let linkAttributes: [NSAttributedString.Key:Any] = [
            .font: UIFont.preferredFont(forTextStyle: .callout),
            .link: URL(string: recipeUrlString) as Any
        ]
        
        let resource = NSAttributedString(string: "Resource", attributes: linkAttributes)
        storage.append(resource)
    }


}

