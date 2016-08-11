//
//  VolunteerMatchCategories.swift
//  Discovol
//
//  Created by Carol Zhang on 8/8/16.
//  Copyright © 2016 Carol Zhang. All rights reserved.
//

import Foundation

class VolunteerMatchCategories {
    
    var filters = [
        Filter(label: "Causes", name: "cause_filter", options: [
            Option(label: "Advocacy & Human Rights", value: "23"),
            Option(label: "Animals", value: "30"),
            Option(label: "Arts & Culture", value: "34"),
            Option(label: "Board Development", value: "38"),
            Option(label: "Children & Youth", value: "22"),
            Option(label: "Community", value: "25"),
            Option(label: "Computers & Technology", value: "37"),
            Option(label: "Crisis Support", value: "14"),
            Option(label: "Disaster Relief", value: "42"),
            Option(label: "Education & Literacy", value: "15"),
            Option(label: "Emergency & Safety", value: "28"),
            Option(label: "Employment", value: "27"),
            Option(label: "Environment", value: "13"),
            Option(label: "Faith-based", value: "36"),
            Option(label: "Health & Medicine", value: "11"),
            Option(label: "Homeless & Housing", value: "7"),
            Option(label: "Hunger", value: "39"),
            Option(label: "Immigrants & Refugees", value: "41"),
            Option(label: "International", value: "29"),
            Option(label: "Justice & Legal", value: "5"),
            Option(label: "LGBT", value: "31"),
            Option(label: "Media & Broadcasting", value: "40"),
            Option(label: "Disabilities", value: "17"),
            Option(label: "Politics", value: "6"),
            Option(label: "Race & Ethnicity", value: "33"),
            Option(label: "Seniors", value: "12"),
            Option(label: "Sports & Recreation", value: "19"),
            Option(label: "Veterans & Military Families", value: "43"),
            Option(label: "Women", value: "3")
        ],
        type: .Multiple, numItemsVisible: 5
        )
    ]
   
    init(instance: VolunteerMatchCategories? = nil) {
        if instance != nil {
            self.copyStateFrom(instance!)
        }
}
    
    func copyStateFrom(instance: VolunteerMatchCategories) {
        for f in 0 ..< self.filters.count {
            for o in 0 ..< self.filters[f].options.count {
                self.filters[f].options[o].selected = instance.filters[f].options[o].selected
            }
        }
    }
    
    var parameters: Dictionary<String, String> {
        get {
            var parameters = Dictionary<String, String>()
            for filter in self.filters {
                switch filter.type {
                case .Single:
                    if filter.name != nil {
                        let selectedOption = filter.options[filter.selectedIndex]
                        if selectedOption.value != "" {
                            parameters[filter.name!] = selectedOption.value
                        }
                    }
                case .Multiple:
                    if filter.name != nil {
                        let selectedOptions = filter.selectedOptions
                        if selectedOptions.count > 0 {
                            parameters[filter.name!] = selectedOptions.map({ $0.value }).joinWithSeparator(",")
                        }
                    }
                default:
                    for option in filter.options {
                        if option.selected && option.name != nil && option.value != "" {
                            parameters[option.name!] = option.value
                        }
                    }
                }
            }
            return parameters
        }
    }
    
    class var instance: VolunteerMatchCategories {
        struct Static {
            static let instance: VolunteerMatchCategories = VolunteerMatchCategories()
        }
        return Static.instance
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