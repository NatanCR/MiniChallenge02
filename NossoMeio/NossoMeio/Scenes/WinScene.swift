//
//  WinScene.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 28/11/22.
//

import SpriteKit

class WinScene: SKScene {
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.backgroundColor = SKColor.white
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        createNewGameButton()
    }
    
    func createNewGameButton() {
        let image = SKSpriteNode(imageNamed: "comecar")
        
        let button = StartButton(image: image) {
            let transition = SKTransition.moveIn(with: .right, duration: 0.2)
            let gameScene = GameScene(size: self.size)
            self.view?.presentScene(gameScene, transition: transition)
        }
        
        button.position = CGPoint(x: 405, y: 185)
        
        addChild(button)
    }
}
