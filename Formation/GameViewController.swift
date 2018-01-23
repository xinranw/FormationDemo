//
//  GameViewController.swift
//  Formation
//
//  Created by Xinran on 1/20/18.
//  Copyright © 2018 xinran. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    @IBOutlet private weak var skView: SKView?
    @IBOutlet private weak var addPersonButton: UIButton?
    
    private var scene: GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let skView = self.skView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                self.scene = scene
                
                scene.size = skView.bounds.size
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                scene.reset()
                
                // Present the scene
                skView.presentScene(scene)
            }
            
            skView.ignoresSiblingOrder = true
            
            skView.showsFPS = true
            skView.showsNodeCount = true
        }
    }
    
    @IBAction func addPerson() {
        scene?.addPerson(PersonNode(radius: 10, fillColor: SKColor.red, strokeColor: SKColor.black))
    }
    
    @IBAction func debug() {
        print("debug")
    }
    
    @IBAction func allFormations() {
        print(String(describing: self.scene?.formations))
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

