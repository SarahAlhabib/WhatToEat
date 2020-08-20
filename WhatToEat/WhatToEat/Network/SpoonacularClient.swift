//
//  SpoonacularClient.swift
//  WhatToEat
//
//  Created by Nadyah Abdulrahman on 29/12/1441 AH.
//  Copyright © 1441 Sarah Alhabib. All rights reserved.
//

import Foundation

class SpoonacularClient{
    static let apiKey = "66a99d99fa8a4742b9042596cb6a4ab2"
    
    //MARK:- Get Recipes anr Their ingredients
    class func getRecipesByIngredients(ingredients:String, completion:@escaping ([RecipeByIngredients],Error?)->Void)->URLSessionDataTask{
        let urlString = "https://api.spoonacular.com/recipes/findByIngredients?apiKey=\(apiKey)&ingredients=\(ingredients)&number=30"
        let url = URL(string:urlString)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, respone, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion([],error)
                }
                return
            }
            let decoder = JSONDecoder()
            do{
                let result = try decoder.decode([RecipeByIngredients].self, from: data)
                DispatchQueue.main.async {
                    completion(result,nil)
                }
            }catch{
                DispatchQueue.main.async {
                    completion([],nil)
                }
                return
            }
        }
        task.resume()
        return task
    }
    
    //MARK:- Get Selected Recipe's Instructions
    class func getRecipeInstructions(id:Int, completion: @escaping ([Step],Error?)->Void){
        let urlString = "https://api.spoonacular.com/recipes/\(id)/analyzedInstructions?apiKey=\(apiKey)"
        let url = URL(string: urlString)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data=data else {
                DispatchQueue.main.async {
                    completion([],error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do{
                let result = try decoder.decode([Instructions].self, from: data)
                DispatchQueue.main.async {
                    if result.count>0{
                        completion(result[0].steps,nil)
                    }
                    else{
                        completion([],nil)
                    }
                }
            }catch{
                print(error)
                DispatchQueue.main.async {
                    completion([],error)
                }
                return
            }
        }
        task.resume()
    }
}
