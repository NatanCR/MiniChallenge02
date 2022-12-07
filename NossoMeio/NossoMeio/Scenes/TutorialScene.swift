//
//  TutorialScene.swift
//  NossoMeio
//
//  Created by rebeca rodrigues on 18/11/22.
//

import SpriteKit

class TutorialScene: SKScene {
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "tutorialUm")
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
        let image = SKSpriteNode(imageNamed: "seta")
        image.setScale(1)
        
        let button = StartButton(image: image) {
        } actionEnded: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let transition = SKTransition.crossFade(withDuration: 0.8)
                let tutorialScene2 = TutorialScene2(size: self.size)
                self.view?.presentScene(tutorialScene2, transition: transition)
            }
        }
        //x 405, y 185 fica no meio da tela
        button.position = CGPoint(x: 570, y: 0)
        addChild(button)
    }
}

