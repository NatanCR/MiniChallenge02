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
        
        let button = StartButton(image: image) {
        } actionEnded: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let transition = SKTransition.moveIn(with: .right, duration: 0.3)
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
        image.setScale(0.4)
        
        button.position = CGPoint(x: 425, y: 185)
        
        addChild(button)
    }
    
    func homeButton() {
        let image = SKSpriteNode(imageNamed: "botaoTelaIncial")
        
        let button = StartButton(image: image) {
        } actionEnded: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let transition = SKTransition.moveIn(with: .right, duration: 0.3)
                let mainVC = MainVC(fileNamed: "MainScene")
                self.view?.presentScene(mainVC!, transition: transition)
            }
        }
        image.setScale(0.4)
        
        button.position = CGPoint(x: 425, y: 105)
        
        addChild(button)
    }
}

