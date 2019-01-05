//
//  FormationsManager.swift
//  Formation
//
//  Created by Xinran on 1/5/19.
//  Copyright © 2019 xinran. All rights reserved.
//

import UIKit

final class FormationsManager {
    static let shared = FormationsManager()
    
    var activeFormation: Formation {
        return FormationsManager.shared.formations[self.activeFormationIndex]
    }
    
    private(set) var formations: [Formation] = []
    private var people: [Person] = []
    private var activeFormationIndex: Int = 0

    private init() {
        self.formations = [Formation()]
    }
    
    func newPerson() {
        let person = Person()
        person.name = "Person \(self.people.count + 1)"
        self.people.append(person)
        self.activeFormation.addPerson(person: person, at: CGPoint.zero)
    }
    
    func newFormation() {
        let formation = Formation()
        for (person, node) in self.activeFormation.personNodes {
            formation.addPerson(person: person, at: node.position)
        }
        self.activeFormationIndex += 1
        self.addFormation(formation, at: self.activeFormationIndex)
    }
    
    func previousFormation() {
        guard self.activeFormationIndex > 0 else { return }
        
        self.activeFormationIndex -= 1
    }
    
    func nextFormation() {
        guard self.activeFormationIndex < self.formations.count - 1 else { return }
        
        self.activeFormationIndex += 1
    }
        
    private func addFormation(_ formation: Formation, at index: Int? = nil) {
        if let index = index {
            self.formations.insert(formation, at: index)
        } else {
            self.formations.append(formation)
        }
    }
}
