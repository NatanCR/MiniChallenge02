//
//  Copyright.swift
//  NossoMeio
//
//  Created by Natan de Camargo Rodrigues on 02/12/22.
//

import SpriteKit

class Copyright: SKScene {
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.size = CGSize(width: 1920, height: 1080)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backButton()
        createCopy()
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "fundo")
        background.anchorPoint = self.anchorPoint
        background.scale(to: scene!.size)
        background.zPosition = -1
        self.addChild(background)
    }
    
    func createCopy() {
        let text = SKLabelNode(fontNamed: "SF-Pro-Rounded")
        text.text = """
                    Happy and Joyful Children by Free Music | https://soundcloud.com/fm_freemusic
                    Music promoted by https://www.chosic.com/free-music/all/
                    Creative Commons CC BY 3.0
                    https://creativecommons.org/licenses/by/3.0/
                    """
        text.position = CGPoint(x: 0, y: 0)
        text.fontSize = 30
        text.fontColor = SKColor(ciColor: .black)
        text.lineBreakMode = NSLineBreakMode.byWordWrapping
        text.numberOfLines = 0
        text.preferredMaxLayoutWidth = 700
        
        
        let direitoAutoral = SKLabelNode(fontNamed: "SF-Pro-Rounded")
        direitoAutoral.text = "Direitos Autorais"
        direitoAutoral.position = CGPoint(x: 0, y: 275)
        direitoAutoral.fontSize = 70
        direitoAutoral.fontColor = SKColor(ciColor: .black)
        
        addChild(direitoAutoral)
        addChild(text)
    }
    
    func backButton() {
        let image = SKSpriteNode(imageNamed: "botaoTelaIncial")
        image.setScale(1)
        
        let button = StartButton(image: image) {
        } actionEnded: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let transition = SKTransition.moveIn(with: .right, duration: 0.3)
                let startScene = StartScene(size: self.size)
                self.view?.presentScene(startScene, transition: transition)
            }
        }
        button.position = CGPoint(x: 0, y: -250)
        addChild(button)
    }
}

