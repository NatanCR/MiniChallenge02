//
//  LoseScene.swift
//  NossoMeio
//
//  Created by Natan de Camargo Rodrigues on 30/11/22.
//

import SpriteKit

class LoseScene: SKScene {

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "ohNao")
        background.anchorPoint = self.anchorPoint
        background.scale(to: scene!.size)
        background.zPosition = -1
        self.addChild(background)
    }

    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        tryAgainButton()
        homeButton()
    }

    
    func tryAgainButton() {
        let image = SKSpriteNode(imageNamed: "botaoTentarNovamente")
        let scale = SKAction.scale(to: 0.4, duration: 0.1)
        
        let button = StartButton(image: image) {
            self.run(scale)
        } actionEnded: {
            let transition = SKTransition.moveIn(with: .right, duration: 0.2)
            let gameScene = GameScene(size: self.size)
            self.view?.presentScene(gameScene, transition: transition)
        }
        image.setScale(0.4)
        
        button.position = CGPoint(x: 430, y: 185)
        
        addChild(button)
    }
    
    func homeButton() {
        let image = SKSpriteNode(imageNamed: "botaoTelaIncial")
        let scale = SKAction.scale(to: 0.4, duration: 0.1)
        
        let button = StartButton(image: image) {
            self.run(scale)
        } actionEnded: {
            let transition = SKTransition.moveIn(with: .right, duration: 0.2)
            let mainVC = MainVC(fileNamed: "MainScene")
            self.view?.presentScene(mainVC!, transition: transition)
        }
        image.setScale(0.40)
        
        button.position = CGPoint(x: 430, y: 105)
        
        addChild(button)
    }
}

