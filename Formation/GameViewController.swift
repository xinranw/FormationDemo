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
import FontAwesome_swift

class GameViewController: UIViewController {
    
    @IBOutlet private weak var skView: SKView?
    @IBOutlet private weak var addPersonButton: UIButton?
    @IBOutlet private weak var leftButton: UIButton?
    @IBOutlet private weak var rightButton: UIButton?
    
    private var scene: GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.leftButton?.titleLabel?.font = UIFont.fontAwesome(ofSize: 24)
        self.leftButton?.setTitle(String.fontAwesomeIcon(name: .chevronLeft), for: .normal)
        self.rightButton?.titleLabel?.font = UIFont.fontAwesome(ofSize: 24)
        self.rightButton?.setTitle(String.fontAwesomeIcon(name: .chevronRight), for: .normal)
        
        
        if let skView = self.skView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                self.scene = scene
                
                scene.size = skView.bounds.size
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                scene.resetScene()
                
                // Present the scene
                skView.presentScene(scene)
            }
            
            skView.ignoresSiblingOrder = true
            
            skView.showsFPS = true
            skView.showsNodeCount = true
        }
    }
    
    @IBAction func addPerson() {
        scene?.newPerson()
    }
    
    @IBAction func newFormation() {
        scene?.newFormation()
    }
    
    @IBAction func debug() {
        print("debug")
    }
    
    @IBAction func allFormations() {
        if let scene = scene {
            print(scene.formations)
        }
    }
    
    @IBAction func leftButtonTapped() {
        self.scene?.showPreviousFormation()
    }
    
    @IBAction func rightButtonTapped() {
        self.scene?.showNextFormation()
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

