//
//  PersonNode.swift
//  Formation
//
//  Created by Xinran on 1/20/18.
//  Copyright © 2018 xinran. All rights reserved.
//

import SpriteKit

class Person {
    private let id: String = UUID().uuidString
    var name: String = ""
    
    var initials: String {
        let name = self.name
        if name.contains(" ") {
            let nameComponents = name.split(separator: " ")
            let initials = nameComponents
                .compactMap { $0.first }
                .map { String($0) }
                .joined()
                .uppercased()
            return initials
        } else {
            return String(name.prefix(2))
                .capitalized
        }
    }
}
extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
}
extension Person: Hashable {
    var hashValue: Int {
        return self.id.hashValue
    }
}

class PersonNode: SKShapeNode {
    var person: Person {
        didSet {
            self.name = person.name
            self.nameLabel.text = person.initials
        }
    }
    var isSelected: Bool = false
    
    private let nameLabel: SKLabelNode = SKLabelNode()
    
    init(person: Person, radius: CGFloat = 10.0) {
        self.person = person
        
        super.init()
        self.path = CGPath(ellipseIn: CGRect(origin: CGPoint(x: -radius, y: -radius), size: CGSize(width: radius * 2, height: radius * 2)), transform: nil)
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        
        self.nameLabel.fontName = StyleGuide.personLabelFont
        self.nameLabel.text = self.person.initials
        self.nameLabel.fontSize = 12
        self.nameLabel.fontColor = StyleGuide.personLabelColor
        self.nameLabel.position = CGPoint(x: self.frame.midX, y: 10)
        self.addChild(self.nameLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var description: String {
        return "\(String(describing:self.person.name)) at \(position)"
    }
}
