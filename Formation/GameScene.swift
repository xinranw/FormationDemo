//
//  GameScene.swift
//  Formation
//
//  Created by Xinran on 1/20/18.
//  Copyright © 2018 xinran. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private(set) var grid: Grid?
    private(set) var formations: [Formation] = []
    private var activeFormationIndex: Int = 0
    private var activeFormation: Formation {
        return formations[activeFormationIndex]
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        let newFormation = Formation()
        formations = [newFormation]
    }
    
    func reset() {
        if self.grid == nil, let newGrid = self.createGrid() {
            self.grid = newGrid
            self.addChild(newGrid)
        }

        self.activeFormation.reset()
       
        let person = PersonNode(radius: 10, fillColor: SKColor.red, strokeColor: SKColor.black)
        self.addPerson(person)
    }
    
    func addPerson(_ person: PersonNode) {
        self.formations[activeFormationIndex].addPerson(person: person)
        self.grid?.update(with: self.activeFormation)
    }
    
    override func didMove(to view: SKView) {
        print("did move to view: \(view)")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        
        if let touch = touches.first {
            let positionInScene = touch.location(in: self)
            let previousPosition = touch.previousLocation(in: self)
            let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
            
            panForTranslation(translation: translation)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    private func createGrid() -> Grid? {
        guard let scene = self.scene else { return nil }
        
        let offset: CGFloat = 10.0
        let gridSize: CGFloat = 30.0
        
        let width = scene.size.width - offset
        let height = scene.size.height - offset
        
        let rows = Int(height / gridSize)
        let cols = Int(width / gridSize)
        if let newGrid = Grid(gridColor: SKColor.red, blockSize: gridSize, rows:rows, cols:cols) {
            print("Creating a grid with \(rows) rows, \(cols) cols, and a grid size of \(gridSize)")
            newGrid.name = "Grid"
            newGrid.position = CGPoint(x:frame.midX, y:frame.midY)
            newGrid.color = UIColor.red
            
            return newGrid
        }
        
        return nil
    }
    
    private func touchDown(atPoint pos : CGPoint) {
        if let person = self.nodes(at: pos).first as? PersonNode {
            self.activeFormation.deselectAllpeople()
            person.isSelected = true
//            selectedPeople.removeAll()
//            selectedPeople.append(person)
        }
    }
    
    private func touchMoved(toPoint pos : CGPoint) {
    }
    
    private func touchUp(atPoint pos : CGPoint) {
        self.activeFormation.selectedPersons.forEach { person in
            if let closestCoordinatePoint = self.grid?.closestCoordinatePosition(for: person.position, tolerance: 0.5) {
                person.position = closestCoordinatePoint
            }
            person.isSelected = false
        }
//        selectedPeople.forEach { (person) in
//            if let closestCoordinatePoint = self.grid?.closestCoordinatePosition(for: person.position, tolerance: 0.5) {
//                person.position = closestCoordinatePoint
//            }
//        }
//        selectedPeople.removeAll(keepingCapacity: false)
    }
    
    private func panForTranslation(translation: CGPoint) {
        self.activeFormation.selectedPersons.forEach { person in
            let position = person.position
            person.position = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
        }
//        selectedPeople.forEach { (person) in
//            let position = person.position
//            person.position = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
//        }
    }
}

