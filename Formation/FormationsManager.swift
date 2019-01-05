//
//  FormationsManager.swift
//  Formation
//
//  Created by Xinran on 1/5/19.
//  Copyright © 2019 xinran. All rights reserved.
//

import RxSwift
import UIKit

final class FormationsManager {
    static let shared = FormationsManager()
    
    var activeFormationObservable: Observable<Formation> { return self.activeFormationSubject }
    private(set) var formations: [Formation] = []
    
    private var people: [Person] = []
    private var activeFormationIndex: Int = 0
    private var activeFormation: Formation { return self.formations[self.activeFormationIndex] }
    private var activeFormationSubject = BehaviorSubject<Formation>(value: Formation())

    private init() {
        self.formations = [Formation()]
        self.activeFormationSubject.onNext(self.activeFormation)
    }
    
    func newPerson() {
        let person = Person()
        person.name = "Person \(self.people.count + 1)"
        self.people.append(person)
        self.activeFormation.addPerson(person: person, at: CGPoint.zero)
        self.emitActiveFormation()
    }
    
    func newFormation() {
        let formation = Formation()
        for (person, node) in self.activeFormation.personNodes {
            formation.addPerson(person: person, at: node.position)
        }
        self.activeFormationIndex += 1
        self.addFormation(formation, at: self.activeFormationIndex)
        self.emitActiveFormation()
    }
    
    func previousFormation() {
        guard self.activeFormationIndex > 0 else { return }
        
        self.activeFormationIndex -= 1
        self.emitActiveFormation()
    }
    
    func nextFormation() {
        guard self.activeFormationIndex < self.formations.count - 1 else { return }
        
        self.activeFormationIndex += 1
        self.emitActiveFormation()
    }
    
    func updateActiveFormation(index: Int) {
        self.activeFormationIndex = index
        self.emitActiveFormation()
    }
        
    private func addFormation(_ formation: Formation, at index: Int? = nil) {
        if let index = index {
            self.formations.insert(formation, at: index)
        } else {
            self.formations.append(formation)
        }
    }
    
    private func emitActiveFormation() {
        self.activeFormationSubject.onNext(self.activeFormation)
    }
}
