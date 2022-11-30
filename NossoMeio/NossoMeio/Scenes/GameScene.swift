//
//  GameScene.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 11/11/22.
//
import SpriteKit
import GameplayKit
import AVKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    private var healthHeart = HeartObject()
    private var gameCreators = GameCreators()
    let soundRight = SKAction.playSoundFileNamed("cheeringSound.mp3", waitForCompletion: false)
    let soundWrong = SKAction.playSoundFileNamed("wrongSound.mp3", waitForCompletion: false)
    let backgroundSound = SKAudioNode(fileNamed: "LovableClownSit.mp3")
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.backgroundColor = SKColor.brown
        self.physicsWorld.contactDelegate = self
    }
    
    override func didMove(to view: SKView) {
        //posição da ancora na tela
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        //limite de gravidade na tela
//        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
//        if let musicURL = Bundle.main.url(forResource: "LovableClown", withExtension: "mp3") {
//            backgroundMusic = SKAudioNode(url: musicURL)
//            addChild(backgroundMusic)
//            backgroundMusic.run(SKAction.play())
//        }
        
        
        
        
        
        gameCreators.createTrash()
        gameCreators.createFinalJunkArray(gameCreators.createPlasticJunk(), gameCreators.createOrganicJunk())
        gameCreators.createHearts()
        self.addChild(gameCreators)
        self.addChild(backgroundSound)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contacting: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contacting == gameCreators.trashCategory | gameCreators.plasticCategory {
            print("CONTATO COM PLASTICO")
            gameCreators.junkCounter -= 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                contact.bodyB.node?.removeFromParent()
                self.run(self.soundRight)
            }
            

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [self] in
                if gameCreators.junkCounter == 0 {
                    gameCreators.isActive = true
                    winGame(isActive: gameCreators.isActive)
                    backgroundSound.run(SKAction.stop())
                }
            }
            
            
        } else if contacting == gameCreators.trashCategory | gameCreators.organicCategory {
            print("CONTATO COM ORGANICO")
            run(soundWrong)
            
            gameCreators.changeHearts()
            gameCreators.heartCounter -= 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [self] in
                if gameCreators.heartCounter == 0 {
                    gameCreators.isActive = true
                    winGame(isActive: gameCreators.isActive)
                    backgroundSound.run(SKAction.stop())
                }
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        print("acabou contato")
    }
    
    func winGame(isActive: Bool) {
        if isActive == true {
            let transition = SKTransition.crossFade(withDuration: 0.2)
            let winScene = WinScene(size: self.size)
            self.view?.presentScene(winScene, transition: transition)
        }
    }
    
    func loseGame(isActive: Bool) {
        if isActive == true {
            let transition = SKTransition.crossFade(withDuration: 0.2)
            let winScene = LoseScene(size: self.size)
            self.view?.presentScene(winScene, transition: transition)
        }
    }
}
