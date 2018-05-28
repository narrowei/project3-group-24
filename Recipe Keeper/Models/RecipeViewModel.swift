//
//  RecipeViewModel.swift
//  Reciper Keeper
//
//  Created by Alice Mai Tu on 14/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import Foundation
import RealmSwift

/*
 https://medium.com/@stasost/ios-how-to-build-a-table-view-with-multiple-cell-types-2df91a206429
 */

// Define types of items for recipe view
enum RecipeViewModelItemType {
    case ingredients
    case instruction
}

protocol RecipeViewModelItem {
    var type: RecipeViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
}

class RecipeIngredientView: RecipeViewModelItem {
    var type: RecipeViewModelItemType {
        return .ingredients
    }
    var sectionTitle: String {
        return "Ingredients"
    }
    var rowCount: Int {
        return ingredients.count
    }
    var ingredients: List<String>
    init(ingredients: List<String>) {
        self.ingredients = ingredients
    }
}

class RecipeInstructionView: RecipeViewModelItem {
    var type: RecipeViewModelItemType {
        return .instruction
    }
    var sectionTitle: String {
        return "Instruction"
    }
    var rowCount: Int {
        return steps.count
    }
    var steps: List<Step>
    init(steps: List<Step>) {
        self.steps = steps
    }
}

class RecipeViewModel {
    var items = [RecipeViewModelItem]()
    
    init(recipe: Recipe) {
        
        if let ingredients = recipe.ingredients {
            let ingredientSection = RecipeIngredientView(ingredients: ingredients)
            items.append(ingredientSection)
        }
        
        if let instruction = recipe.instruction {
            let instructionSection = RecipeInstructionView(steps: instruction)
            items.append(instructionSection)
        }
    }
}
 
