//
//  TutorialScene.swift
//  NossoMeio
//
//  Created by rebeca rodrigues on 18/11/22.
//

import SpriteKit

class TutorialScene: SKScene {
    let background = SKSpriteNode()
    override func didMove(to view: SKView) {
        let backgroundTexture = SKTexture(imageNamed: "tutorialUm")
        background = SKSpriteNode(texture: backgroundTexture)
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
        let imageTexture = SKTexture(imageNamed: "seta")
        let image = SKSpriteNode(texture: imageTexture)
//        var cont = 0
        image.setScale(1)
        
        let button = StartButton(image: image) {
        } actionEnded: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let transition = SKTransition.crossFade(withDuration: 0.8)
                let tutorialScene2 = TutorialScene2(size: self.size)
                self.view?.presentScene(tutorialScene2, transition: transition)
                
                //                self.background.run(SKAction.setTexture(SKTexture(imageNamed: "tutorialDois")))
                //                image.run(SKAction.setTexture(SKTexture(imageNamed: "botaoComecar")))
                //                cont += 1
                //
                //                if cont == 2 {
                //                    let transition = SKTransition.crossFade(withDuration: 0.8)
                //                    let gameScene = GameScene(size: self.size)
                //                    self.view?.presentScene(gameScene, transition: transition)
                //                }
            }
        }
        button.position = CGPoint(x: 570, y: 0)
        addChild(button)
    }
}

