//
//  RecipeByIngredients.swift
//  WhatToEat
//
//  Created by Nadyah Abdulrahman on 29/12/1441 AH.
//  Copyright © 1441 Sarah Alhabib. All rights reserved.
//

import Foundation

struct RecipeByIngredients {
    let id: Int
    let image: String
    let likes: Int
    let missedIngredientCount: Int
    let missedIngredients: [MissedIngredients]
}

struct MissedIngredients {
    let aisle: String
    
}
