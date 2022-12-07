//
//  MainViewController.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 11/11/22.
//

import SpriteKit

class MainVC: SKScene {
    var button: SKSpriteNode!
    var background: SKSpriteNode!
    var copyButton: SKSpriteNode!
    
    override func sceneDidLoad() {
                
        self.anchorPoint = CGPoint(x: 0, y: 0)
        button = self.childNode(withName: "botaoJogar") as? SKSpriteNode
        background = self.childNode(withName: "background") as? SKSpriteNode
        copyButton = self.childNode(withName: "copy") as? SKSpriteNode
    }
    
    override func didMove(to view: SKView) {
//        background.scale(to: scene!.size)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            if nodesArray.first == button {
                buttonPressed()
            }
        }
        
        if let location2 = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location2)
            if nodesArray.first == copyButton {
                let transition = SKTransition.crossFade(withDuration: 0.2)
                let tutorialScene = Copyright(size: self.size)
                self.view?.presentScene(tutorialScene, transition: transition)
            }
        }
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
    }
    
    public func buttonPressed() {
        let sequenceAnim = SKAction.sequence([
            ButtonAnimation.pressed(0.6)])
        self.button.run(sequenceAnim)
    }
}






