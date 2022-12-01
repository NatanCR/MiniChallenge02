//
//  MainViewController.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 11/11/22.
//

import SpriteKit

class MainVC: SKScene {
    
//        override func didMove(to view: SKView) {
//            let background = SKSpriteNode(imageNamed: "jogar")
//            background.anchorPoint = self.anchorPoint
//            background.scale(to: scene!.size)
//            background.zPosition = -1
//
//            self.addChild(background)
//
//        }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            if nodesArray.first?.name == "botaoJogar" {
                let transition = SKTransition.crossFade(withDuration: 0.2)
                let tutorialScene = TutorialScene(size: self.size)
                self.view?.presentScene(tutorialScene, transition: transition)
            }
        }
        
        //x 405, y 185 fica no meio da tela
        button.position = CGPoint(x: 405, y: 185)
        button.zPosition = 10
        addChild(button)
    }
    
    public func buttonPressed() {
        let sequenceAnim = SKAction.sequence([
            ButtonAnimation.pressed(0.3)])
        self.run(sequenceAnim)
    }
}






