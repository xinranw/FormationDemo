//
//  PersonNode.swift
//  Formation
//
//  Created by Xinran on 1/20/18.
//  Copyright © 2018 xinran. All rights reserved.
//

import SpriteKit

class PersonNode: SKShapeNode {
    
    var personName: String = ""
    var isSelected: Bool = false
    
    init(radius: CGFloat, fillColor: SKColor, strokeColor: SKColor) {
        super.init()
        self.path = CGPath(ellipseIn: CGRect(origin: CGPoint(x: -radius, y: -radius), size: CGSize(width: radius * 2, height: radius * 2)), transform: nil)
        self.fillColor = fillColor
        self.strokeColor = strokeColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var description: String {
        return "\(personName) at \(position)"
    }
}
