//
//  GameViewController.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 11/11/22.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = self.view as! SKView
        //            if let scene = SKScene(fileNamed: "MainScene") {
        //            let scene = MainVC.init(fileNamed: "MainScene")
        let scene = StartScene()
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        view.presentScene(scene)
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
