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
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        passSceneButton()
    }
    
    func passSceneButton() {
        let image = SKSpriteNode(imageNamed: "botaoComecar")
        image.size = CGSize(width: 0.2, height: 0.15)
        
        let button = StartButton(image: image) {
        } actionEnded: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let transition = SKTransition.crossFade(withDuration: 0.8)
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
        //x 405, y 185 fica no meio da tela
        button.position = CGPoint(x: 0.3, y: 0)
        addChild(button)
    }
    
}


    
