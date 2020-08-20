//
//  InstructionsResult.swift
//  WhatToEat
//
//  Created by Nadyah Abdulrahman on 29/12/1441 AH.
//  Copyright © 1441 Sarah Alhabib. All rights reserved.
//

import Foundation

struct Instructions: Decodable{
    let name:String
    let steps:[Step]
}

struct Step: Decodable{
    let equipment:[Equipment]
    let ingredients:[Equipment]
    let number: Int
    let step: String
}

struct Equipment: Decodable{
    let id:Int
    let image:String
    let name: String
    let temperature: Temperature?
}

struct Temperature: Decodable {
    let number: Float
    let unit: String
}
