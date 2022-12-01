//
//  TutorialScene2.swift
//  NossoMeio
//
//  Created by Barbara Argolo on 30/11/22.
//

import SpriteKit

class TutorialScene2: SKScene {
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "tutorialDois")
        background.anchorPoint = self.anchorPoint
        background.scale(to: scene!.size)
        background.zPosition = -1
        
        self.addChild(background)

    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
      passSceneButton()
    }
    
    func passSceneButton() {
        let image = SKSpriteNode(imageNamed: "botaoComecar")
        let scale = SKAction.scale(to: 0.4, duration: 0.1)
        image.setScale(0.4)
        
        let button = StartButton(image: image) {
            self.run(scale)
        } actionEnded: {
            let transition = SKTransition.reveal(with: .left, duration: 0.3)
            let gameScene = GameScene(size: self.size)
            self.view?.presentScene(gameScene, transition: transition)
        }
        //x 405, y 185 fica no meio da tela
        button.position = CGPoint(x: 655, y: 185)
        
        addChild(button)
    }
    
}


    
