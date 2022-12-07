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
        background.scale(to: scene!.size)
        background.zPosition = 0
        self.addChild(background)
   
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.size = CGSize(width: 1920, height: 1080)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleMode = .aspectFill
        startButton()
        createCopyButton()
    }
    
    func startButton() {
        let image = SKSpriteNode(imageNamed: "botaoJogar")
        image.setScale(0.8)
        
        let button = StartButton(image: image) {
        } actionEnded: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let transition = SKTransition.crossFade(withDuration: 0.8)
                let tutorialScene = TutorialScene(size: self.size)
                self.view?.presentScene(tutorialScene, transition: transition)
            }
        }
        button.position = CGPoint(x: 230, y: -100)
        button.zPosition = 2
        self.addChild(button)
    }
    
    func createCopyButton() {
        let image = UIImage(systemName: "info.circle")
        let texture = SKTexture(image: image!)
        let sprite = StartButton(image: SKSpriteNode(texture: texture)) {
        } actionEnded: {
            let transition = SKTransition.crossFade(withDuration: 0.8)
            let copy = Copyright(size: self.size)
            self.view?.presentScene(copy, transition: transition)
        }
        
        sprite.setScale(4)
        sprite.position = CGPoint(x: 750, y: -370)
        sprite.zPosition = 1
        self.addChild(sprite)
    }
}
