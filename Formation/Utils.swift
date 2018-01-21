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

// round the value to the nearest multiple of that factor.
func round(_ value: CGFloat, toNearest: CGFloat) -> CGFloat {
    return round(value / toNearest) * toNearest
}

// Given a value to round and a factor to round to,
// round the value DOWN to the largest previous multiple
// of that factor.
func roundDown(_ value: CGFloat, toNearest: CGFloat) -> CGFloat {
    return floor(value / toNearest) * toNearest
}

// Given a value to round and a factor to round to,
// round the value DOWN to the largest previous multiple
// of that factor.
func roundUp(_ value: CGFloat, toNearest: CGFloat) -> CGFloat {
    return ceil(value / toNearest) * toNearest
}
