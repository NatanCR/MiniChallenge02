//
//  MainViewController.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 11/11/22.
//

import SpriteKit

class MainVC: SKScene {

    var newGameButton: SKSpriteNode!
    
    override func didMove(to view: SKView){
        newGameButton = self.childNode(withName: "newGameButton") as! SKSpriteNode
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //para saber onde esta tocando na tela
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "newGameButton" {
                //fará a transição para cena do jogo
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = GameScene(size: self.size)
                //realiza a transition descrita com as definições acima
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
    }
}
