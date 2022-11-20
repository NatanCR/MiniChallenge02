//
//  MainViewController.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 11/11/22.
//

import SpriteKit

class MainVC: SKScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "playButton" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let tutorialScene = TutorialScene(size: self.size)
                self.view?.presentScene(tutorialScene, transition: transition)
            }
        }
    }
}
