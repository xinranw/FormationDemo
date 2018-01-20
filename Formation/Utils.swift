//
//  Utils.swift
//  Formation
//
//  Created by Xinran on 1/20/18.
//  Copyright © 2018 xinran. All rights reserved.
//

import UIKit

func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}
