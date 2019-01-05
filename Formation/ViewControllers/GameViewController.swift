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
import RxSwift

final class GameViewController: UIViewController {
    @IBOutlet private weak var skView: SKView!
    @IBOutlet private weak var addPersonButton: UIButton!
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var rightButton: UIButton!
    
    private var scene: GameScene?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up initial data
        _ = FormationsManager.shared
        self.setupUI()
        self.setupSceneKitView()
        
        FormationsManager.shared.activeFormationObservable
            .subscribe(onNext: { [weak self] formation in
                self?.scene?.formation = formation
            })
            .disposed(by: self.disposeBag)
    }
    
    @IBAction func addPerson() {
        FormationsManager.shared.newPerson()
    }
    
    @IBAction func newFormation() {
        FormationsManager.shared.newFormation()
    }
    
    @IBAction func debug() {
        print("debug")
    }
    
    @IBAction func allFormations() {
        print(FormationsManager.shared.formations)
    }
    
    @IBAction func leftButtonTapped() {
        FormationsManager.shared.previousFormation()
    }
    
    @IBAction func rightButtonTapped() {
        FormationsManager.shared.nextFormation()
    }
    
    // MARK: - UIViewController overrides
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
    
    // MARK: - Private functions
    private func setupSceneKitView() {
        // Load the SKScene from 'GameScene.sks'
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            self.scene = scene
            
            scene.size = skView.bounds.size
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
//            scene.formation = FormationsManager.shared.activeFormation
            
            // Present the scene
            skView.presentScene(scene)
        }
        
        self.skView.ignoresSiblingOrder = true
        self.skView.showsFPS = true
        self.skView.showsNodeCount = true
    }
    
    private func setupUI() {
        self.leftButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 24, style: .brands)
        self.leftButton.setTitle(String.fontAwesomeIcon(name: .chevronLeft), for: .normal)
        self.rightButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 24, style: .brands)
        self.rightButton.setTitle(String.fontAwesomeIcon(name: .chevronRight), for: .normal)
    }
}
