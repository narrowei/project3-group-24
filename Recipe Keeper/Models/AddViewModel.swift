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
enum AddViewModelItemType {
    case name
    case cuisine
    case time
    case ingredients
    case instruction
    
}

protocol AddViewModelItem {
    var type: AddViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
}

extension AddViewModelItem {
    var rowCount: Int {
        return 1
    }
}

class AddNameView: AddViewModelItem {
    var type: AddViewModelItemType {
        return .name
    }
    
    var sectionTitle: String {
        return "Recipe Name"
    }
}

class SelectCuisineView: AddViewModelItem {
    var type: AddViewModelItemType {
        return .cuisine
    }
    
    var sectionTitle: String {
        return "Cuisine"
    }
}

class EstimateTimeView: AddViewModelItem {
    var type: AddViewModelItemType {
        return .time
    }
    
    var sectionTitle: String {
        return "Estimated Time"
    }
}

class AddIngredientView: AddViewModelItem {
    var type: AddViewModelItemType {
        return .ingredients
    }
    
    var sectionTitle: String {
        return "Ingredients"
    }
    var ingredients: List<String>?
    // Optional type so we can reuse view for editing
}

class AddInstructionView: AddViewModelItem {
    var type: AddViewModelItemType {
        return .instruction
    }
    var sectionTitle: String {
        return "Instruction"
    }
    var steps: List<Step>?
    // Optional type so we can reuse view for editing
}

class AddViewModel {
    var items = [AddViewModelItem]()
    
    init() {
        let addName = AddNameView()
        let selectCuisine = SelectCuisineView()
        let estimateTime = EstimateTimeView()
        let addIngredients = AddIngredientView()
        let addInstruction = AddInstructionView()
        items.append(addName)
        items.append(selectCuisine)
        items.append(estimateTime)
        items.append(addIngredients)
        items.append(addInstruction)
    }
}

