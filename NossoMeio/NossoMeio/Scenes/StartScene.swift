//
//  StartScene.swift
//  NossoMeio
//
//  Created by Natan de Camargo Rodrigues on 06/12/22.
//

import SpriteKit

class StartScene: SKScene {
        
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "jogar")
        background.anchorPoint = self.anchorPoint
        background.scale(to: CGSize(width: 1, height: 0.5))
        background.zPosition = 0
        self.addChild(background)
   
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
        startButton()
    }
    
    func startButton() {
        let image = SKSpriteNode(imageNamed: "botaoJogar")
        image.setScale(0.0004)
        
        let button = StartButton(image: image) {
        } actionEnded: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let transition = SKTransition.crossFade(withDuration: 0.8)
                let tutorialScene = TutorialScene(size: self.size)
                self.view?.presentScene(tutorialScene, transition: transition)
            }
        }
        button.position = CGPoint(x: 0.05, y: -0.08)
        button.zPosition = 2
        self.addChild(button)
    }
}
