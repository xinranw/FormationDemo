//
//  Grid.swift
//  Formation
//
//  Created by Xinran on 1/20/18.
//  Copyright © 2018 xinran. All rights reserved.
//

import SpriteKit

class Grid: SKSpriteNode {
    
    private var rows: Int!
    private var cols: Int!
    private var blockSize: CGFloat!
    private var gridColor: SKColor! {
        didSet {
            if let texture = Grid.gridTexture(gridColor: gridColor, blockSize: blockSize,rows: rows, cols:cols) {
                self.texture = texture
            }
        }
    }
    
    convenience init?(gridColor: SKColor, blockSize:CGFloat, rows:Int, cols:Int) {
        guard let texture = Grid.gridTexture(gridColor: gridColor, blockSize: blockSize, rows: rows, cols:cols) else {
            return nil
        }
        self.init(texture: texture, color:SKColor.clear, size: texture.size())
        self.gridColor = gridColor
        self.blockSize = blockSize
        self.rows = rows
        self.cols = cols
    }
    
    class func gridTexture(gridColor: SKColor, blockSize:CGFloat, rows:Int, cols:Int) -> SKTexture? {
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
    
    func snapToGrid(node: SKNode, tolerance: CGFloat) {
        let currentCoordinates = coordinate(for: node.position)
        // todo: finish this function
    }
    
    func position(for coordinate: CGPoint) -> CGPoint {
        let offset = blockSize / 2.0 + 0.5
        let x = (coordinate.x - 0.5) * blockSize - (blockSize * CGFloat(cols)) / 2.0 + offset
        let actualCol = CGFloat(rows) - coordinate.y - 0.5
        let y = actualCol * blockSize - (blockSize * CGFloat(rows)) / 2.0 + offset
        return CGPoint(x:x, y:y)
    }
    
    func coordinate(for point: CGPoint) -> CGPoint {
        let offset = blockSize / 2.0 + 0.5
        let row = (point.x - offset + (blockSize * CGFloat(cols)) / 2.0) / blockSize + 0.5
        let column = CGFloat(rows) - ((point.y - offset + (blockSize * CGFloat(rows)) / 2.0) / blockSize) - 0.5
        return CGPoint(x: row, y: column)
    }
}

