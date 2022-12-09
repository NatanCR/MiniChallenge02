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
        self.size = CGSize(width: 1920, height: 1080)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        passSceneButton()
    }
    
    func passSceneButton() {
        let imageTexture = SKTexture(imageNamed: "botaoComecar")
        let image = SKSpriteNode(texture: imageTexture)
        image.setScale(1)
        
        let button = StartButton(image: image) {
        } actionEnded: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let transition = SKTransition.crossFade(withDuration: 0.8)
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
        button.position = CGPoint(x: 580, y: 40)
        addChild(button)
    }
    
}


    
