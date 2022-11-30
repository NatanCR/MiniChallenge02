//
//  TutorialScene.swift
//  NossoMeio
//
//  Created by rebeca rodrigues on 18/11/22.
//

import Foundation
import SpriteKit

class TutorialScene: SKScene {
    override func didMove(to view: SKView) {
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.backgroundColor = SKColor.white
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        createStartButton()
    }
    
     func createStartButton() {
        let image = SKSpriteNode(imageNamed: "comecar")
         let button = StartButton(image: image) {
             
             let transition = SKTransition.moveIn(with: .right, duration: 0.2)
             let gameScene = GameScene(size: self.size)
             
             self.view?.presentScene(gameScene, transition: transition)
         }
        //x 405, y 185 fica no meio da tela
        button.position = CGPoint(x: 405, y: 185)
        addChild(button)
    }
}

