//
//  RecipeByIngredients.swift
//  WhatToEat
//
//  Created by Nadyah Abdulrahman on 29/12/1441 AH.
//  Copyright © 1441 Sarah Alhabib. All rights reserved.
//

import Foundation

struct RecipeByIngredients: Decodable {
    let id: Int
    let image: String
    let likes: Int
    let missedIngredientCount: Int
    let missedIngredients: [Ingredients]
    let title: String
    let unusedIngredients: [Ingredients]
    let usedIngredientCount: Int
    let usedIngredients: [Ingredients]
}

struct Ingredients: Decodable {
    let aisle: String
    let amount: Float
    let id: Int
    let image: String
    let meta: [String]
    let original: String
    let originalName: String
    let unit: String
    let unitLong: String
    let unitShort: String
}
