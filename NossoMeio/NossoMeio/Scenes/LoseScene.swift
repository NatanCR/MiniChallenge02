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
        background.scale(to: CGSize(width: 1, height: 1))
        background.zPosition = -1
        self.addChild(background)
    }

    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        tryAgainButton()
        homeButton()
    }

    
    func tryAgainButton() {
        let image = SKSpriteNode(imageNamed: "botaoTentarNovamente")
        image.size = CGSize(width: 0.2, height: 0.15)
        
        let button = StartButton(image: image) {
        } actionEnded: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                let transition = SKTransition.moveIn(with: .right, duration: 0.3)
                let transition = SKTransition.crossFade(withDuration: 0.8)
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
        button.position = CGPoint(x: 0.02, y: 0)
        addChild(button)
    }
    
    func homeButton() {
        let image = SKSpriteNode(imageNamed: "botaoTelaIncial")
        image.size = CGSize(width: 0.2, height: 0.15)
        
        let button = StartButton(image: image) {
        } actionEnded: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let transition = SKTransition.moveIn(with: .right, duration: 0.3)
                let startScene = StartScene(size: self.size)
                self.view?.presentScene(startScene, transition: transition)
            }
        }
        button.position = CGPoint(x: 0.02, y: -0.2)
        addChild(button)
    }
}

