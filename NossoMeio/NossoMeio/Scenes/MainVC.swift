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
                let transition = SKTransition.crossFade(withDuration: 0.2)
                // .fade(withDuration: 0.3) da um apagão na tela atual e clarea com a proxima tela
                // .crossFade(withDuration: 0.2) a tela atual desaparece mostrando a proxima
                // .moveIn(with: .right, duration: 0.3) a proxima tela vem por cima da direita
                // .reveal(with: .left, duration: 0.3) joga a tela que esta para a esquerda e mostra a nova
                let tutorialScene = TutorialScene(size: self.size)
                self.view?.presentScene(tutorialScene, transition: transition)
            }
        }
    }
}
