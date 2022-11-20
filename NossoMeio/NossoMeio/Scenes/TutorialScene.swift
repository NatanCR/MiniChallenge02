//
//  TutorialScene.swift
//  NossoMeio
//
//  Created by rebeca rodrigues on 18/11/22.
//

import Foundation
import SpriteKit

class TutorialScene: SKScene {
    override func didMove(to view: SKView) {
        
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.backgroundColor = SKColor.white
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        createStartButton()
    }
    
    func createStartButton() {
        let image = SKSpriteNode(color: .red, size: .init(width: 200, height: 80))
        let label = SKLabelNode(text: "Começar")
        
        label.fontColor = .black
        label.fontSize = 40
        label.verticalAlignmentMode = .center
        
        let button = StartButton(image: image, label: label) {
            let transition = SKTransition.moveIn(with: .right, duration: 0.2)
            let tutorialScene = GameScene(size: self.size)
            self.view?.presentScene(tutorialScene, transition: transition)
        }
        
        //x 400, y 185 fica no meio da tela
        button.position = CGPoint(x: 400, y: 185)
        
        addChild(button)
    }
    
}
