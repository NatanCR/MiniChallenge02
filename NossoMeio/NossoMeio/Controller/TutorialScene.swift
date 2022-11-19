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
        
        let image = SKSpriteNode(color: .red, size: .init(width: 200, height: 80))
        let label = SKLabelNode(text: "Começar")
        
        label.fontColor = .black
        label.fontSize = 40
        label.verticalAlignmentMode = .center
         
         let button = StartButton(image: image, label: label) {
             print("vc clicou")
    
         }
        button.name = "startButton"
        //x 400, y 180 fica no meio da tela
        button.position = CGPoint(x: 600, y: 130)
         
         addChild(button)
     }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "startButton" {
                let transition = SKTransition.moveIn(with: .right, duration: 0.2)
                let tutorialScene = GameScene(size: self.size)
                self.view?.presentScene(tutorialScene, transition: transition)
            }
        }
    }
}
