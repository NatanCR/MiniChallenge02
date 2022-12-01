//
//  MainViewController.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 11/11/22.
//

import SpriteKit

class MainVC: SKScene {
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        createPlayButton()
    }
    
    func createPlayButton() {
        let image = SKSpriteNode(imageNamed: "jogar")
        let button = StartButton(image: image) {
            
        } actionEnded: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let transition = SKTransition.moveIn(with: .right, duration: 0.4)
                let tutorialScene = TutorialScene(size: self.size)
                self.view?.presentScene(tutorialScene, transition: transition)
            }
            
        }
        //x 405, y 185 fica no meio da tela
        button.position = CGPoint(x: 405, y: 185)
        addChild(button)
    }
    
    public func buttonPressed() {
        let sequenceAnim = SKAction.sequence([
            ButtonAnimation.pressed(0.3)])
        self.run(sequenceAnim)
    }
}






