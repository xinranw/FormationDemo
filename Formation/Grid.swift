//
//  Grid.swift
//  Formation
//
//  Created by Xinran on 1/20/18.
//  Copyright © 2018 xinran. All rights reserved.
//

import SpriteKit

class Grid: SKSpriteNode {
    private typealias GridColors = (lineColor: SKColor, backgroundColor: SKColor)
    
    private var rows: Int?
    private var cols: Int?
    private var blockSize: CGFloat?
    private var colors: GridColors? {
        didSet {
            if let colors = colors, let blockSize = blockSize, let rows = rows, let cols = cols,
                let texture = Grid.gridTexture(gridColor: colors.lineColor,
                                              gridBackgroundColor: colors.backgroundColor,
                                              blockSize: blockSize,
                                              rows: rows,
                                              cols:cols) {
                self.texture = texture
            }
        }
    }
    
    convenience init?(gridLineColor: SKColor, gridBackgroundColor: SKColor, blockSize:CGFloat, rows:Int, cols:Int) {
        guard let texture = Grid.gridTexture(gridColor: gridLineColor,
                                             gridBackgroundColor: gridBackgroundColor,
                                             blockSize: blockSize,
                                             rows: rows,
                                             cols:cols) else {
            return nil
        }
        self.init(texture: texture, color:gridBackgroundColor, size: texture.size())
        self.colors = GridColors(lineColor: gridLineColor, backgroundColor: gridBackgroundColor)
        self.blockSize = blockSize
        self.rows = rows
        self.cols = cols
    }
    
    private class func gridTexture(gridColor: SKColor, gridBackgroundColor: SKColor, blockSize:CGFloat, rows:Int, cols:Int) -> SKTexture? {
        // Add 1 to the height and width to ensure the borders are within the sprite
        let size = CGSize(width: CGFloat(cols) * blockSize + 1.0,
                          height: CGFloat(rows) * blockSize + 1.0)
        UIGraphicsBeginImageContext(size)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        let bezierPath = UIBezierPath()
        let offset:CGFloat = 0.5
        // Draw vertical lines
        for i in 0...cols {
            let x = CGFloat(i)*blockSize + offset
            bezierPath.move(to: CGPoint(x: x, y: 0))
            bezierPath.addLine(to: CGPoint(x: x, y: size.height))
        }
        // Draw horizontal lines
        for i in 0...rows {
            let y = CGFloat(i)*blockSize + offset
            bezierPath.move(to: CGPoint(x: 0, y: y))
            bezierPath.addLine(to: CGPoint(x: size.width, y: y))
        }
        gridColor.setStroke()
        bezierPath.lineWidth = 1.0
        bezierPath.stroke()
        context.addPath(bezierPath.cgPath)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return SKTexture(image: image!)
    }
    
    // can improve by diff-ing
    func update(with formation: Formation) {
        self.removeAllChildren()
        for person in formation.nodes {
            self.addChild(person)
        }
    }
    
    func closestCoordinatePosition(for position: CGPoint, tolerance: CGFloat) -> CGPoint? {
        guard let currentCoordinates = coordinate(for: position) else { return nil }
        let roundedX = round(currentCoordinates.x, toNearest: tolerance)
        let roundedY = round(currentCoordinates.y, toNearest: tolerance)
        return self.position(for: CGPoint(x: roundedX, y: roundedY))
    }
    
    private func position(for coordinate: CGPoint) -> CGPoint? {
        guard let blockSize = blockSize, let rows = rows, let cols = cols else { return nil }
        
        let offset = blockSize / 2.0 + 0.5
        let x = (coordinate.x - 0.5) * blockSize - (blockSize * CGFloat(cols)) / 2.0 + offset
        let actualCol = CGFloat(rows) - coordinate.y - 0.5
        let y = actualCol * blockSize - (blockSize * CGFloat(rows)) / 2.0 + offset
        return CGPoint(x:x, y:y)
    }
    
    private func coordinate(for point: CGPoint) -> CGPoint? {
        guard let blockSize = blockSize, let rows = rows, let cols = cols else { return nil }
        
        let offset = blockSize / 2.0 + 0.5
        let row = (point.x - offset + (blockSize * CGFloat(cols)) / 2.0) / blockSize + 0.5
        let column = CGFloat(rows) - ((point.y - offset + (blockSize * CGFloat(rows)) / 2.0) / blockSize) - 0.5
        return CGPoint(x: row, y: column)
    }
}

