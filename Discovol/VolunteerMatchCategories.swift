//
//  VolunteerMatchCategories.swift
//  Discovol
//
//  Created by Carol Zhang on 8/8/16.
//  Copyright © 2016 Carol Zhang. All rights reserved.
//

import Foundation

class VolunteerMatchCategories {
    init(instance: VolunteerMatchCategories? = nil) {
        if instance != nil {
            self.copyStateFrom(instance!)
        }
    }
    
    func copyStateFrom(instance: VolunteerMatchCategories) {
        for var f = 0; f < self.filters.count; f += 1 {
            for var o = 0; o < self.filters[f].options.count; o += 1 {
                self.filters[f].options[o].selected = instance.filters[f].options[o].selected
            }
        }
    }
    
}

class Filter {
    
    var label: String
    var name: String?
    var options: Array<Option>
    var type: FilterType
    var numItemsVisible: Int?
    var opened: Bool = false
    
    init(label: String, name: String? = nil, options: Array<Option>, type: FilterType, numItemsVisible: Int? = 0) {
        self.label = label
        self.name = name
        self.options = options
        self.type = type
        self.numItemsVisible = numItemsVisible
    }
    
    var selectedIndex: Int {
        get {
            for i in 0 ..< self.options.count {
                if self.options[i].selected {
                    return i
                }
            }
            return -1
        }
        set {
            if self.type == .Single {
                self.options[self.selectedIndex].selected = false
            }
            self.options[newValue].selected = true
        }
    }
    
    var selectedOptions: Array<Option> {
        get {
            var options: Array<Option> = []
            for option in self.options {
                if option.selected {
                    options.append(option)
                }
            }
            return options
        }
    }
    
}

enum FilterType {
    case Default, Single, Multiple
}

class Option {
    
    var label: String
    var name: String?
    var value: String
    var selected: Bool
    
    init(label: String, name: String? = nil, value: String, selected: Bool = false) {
        self.label = label
        self.name = name
        self.value = value
        self.selected = selected
    }
    
}