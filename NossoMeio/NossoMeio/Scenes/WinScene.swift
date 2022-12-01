//
//  WinScene.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 28/11/22.
//

import SpriteKit

class WinScene: SKScene {
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "telaParabens")
        // let background = SKSpriteNode(imageNamed: "telaParabens")
        background.anchorPoint = self.anchorPoint
        background.scale(to: scene!.size)
        background.zPosition = -1
        
        
        self.addChild(background)
        
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        //  self.backgroundColor = SKColor.white
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        
        playAgainButton()
        homeButton()
    }
    
    
    
    func playAgainButton() {
        let image = SKSpriteNode(imageNamed: "botaoJogarNoVAMENTE")
        let scale = SKAction.scale(to: 0.4, duration: 0.1)
        
        let button = StartButton(image: image) {
            self.run(scale)
        } actionEnded: {
            let transition = SKTransition.moveIn(with: .right, duration: 0.2)
            let gameScene = GameScene(size: self.size)
            self.view?.presentScene(gameScene, transition: transition)
        }
        image.setScale(0.4)
        
        button.position = CGPoint(x: 420, y: 185)
        
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
        
        button.position = CGPoint(x: 420, y: 105)
        
        addChild(button)
    }
}
