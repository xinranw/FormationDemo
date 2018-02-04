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
    var persons: [Person] {
        return Array(personNodes.keys)
    }
    var nodes: [PersonNode] {
        return Array(personNodes.values)
    }
    private(set) var personNodes: [Person: PersonNode] = [:]
    
    var selectedPersons: [PersonNode] {
        return personNodes.values.filter { return $0.isSelected }
    }
    
    func addPerson(person: Person, at position: CGPoint) {
        let newPersonNode = PersonNode(person: person)
        newPersonNode.position = position
        personNodes[person] = newPersonNode
    }
    
    func deselectAll() {
        self.selectedPersons.forEach { person in
            person.isSelected = false
        }
    }
    
    func reset() {
        personNodes.values.forEach { personNode in
            personNode.removeFromParent()
        }
    }
}

extension Formation: CustomStringConvertible {
    var description: String {
        let personsStr = self.personNodes.values
            .map { $0.description }
            .joined(separator: ", ")
        return "Formation index: \(self.index) \(personsStr)\n"
    }
}
