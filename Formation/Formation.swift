//
//  Formation.swift
//  Formation
//
//  Created by Xinran on 1/22/18.
//  Copyright © 2018 xinran. All rights reserved.
//

import UIKit

class Formation {
    var index: Int = 0
    private(set) var persons: [PersonNode] = []
    var selectedPersons: [PersonNode] {
        return persons.filter { return $0.isSelected }
    }
    
    func addPerson(person: PersonNode) {
        persons.append(person)
    }
    
    func deselectAllpeople() {
        persons.forEach { person in
            person.isSelected = false
        }
    }
    
    func reset() {
        for person in persons {
            person.removeFromParent()
        }
        persons.removeAll()
    }
}

extension Formation: CustomStringConvertible {
    var description: String {
        let personsStr = self.persons.map { person in
            return person.description
            }.joined(separator: ", ")
        return "Formation index: \(self.index) \(personsStr)\n"
    }
}
