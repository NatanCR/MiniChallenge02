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
    var particleEmitter: SKEmitterNode!
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.size = CGSize(width: 1920, height: 1080)
        self.physicsWorld.contactDelegate = self
    }
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.showsPhysics = true
        
        gameCreators.createTrash()
        gameCreators.createFinalJunkArray(gameCreators.createPlasticJunk(), gameCreators.createOrganicJunk())
        gameCreators.createHearts()
        gameCreators.createGround()
        gameCreators.createBackground()
        self.addChild(gameCreators)
        self.addChild(displayBackgroundSound())
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        
        let contacting: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contacting == gameCreators.trashCategory | gameCreators.plasticCategory {
            gameCreators.junkCounter -= 1
//            setEmitter()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                contact.bodyA.node?.removeFromParent()
                self.run(self.soundRight)
            }
            

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [self] in
                if gameCreators.junkCounter == 0 {
                    gameCreators.isActive = true
                    winGame(isActive: gameCreators.isActive)
                    displayBackgroundSound().run(SKAction.stop())
                }
            }
            
        } else if contacting == gameCreators.trashCategory | gameCreators.organicCategory {
            run(soundWrong)
            gameCreators.changeHearts()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [self] in
                if gameCreators.heartCounter == 0 {
                    gameCreators.isActive = true
                    loseGame(isActive: gameCreators.isActive)
                    displayBackgroundSound().run(SKAction.stop())
                }
            }
        }
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
            let loseScene = LoseScene(size: self.size)
            self.view?.presentScene(loseScene, transition: transition)
        }
    }
    
    func setEmitter() {
            particleEmitter = SKEmitterNode(fileNamed: "spark")
            particleEmitter.position.x = 0
            particleEmitter.position.y = 0.06
            particleEmitter.zPosition = -3
            self.addChild(particleEmitter)
        }
    
    func displayBackgroundSound() -> SKAudioNode {
        let backgroundSound = SKAudioNode(fileNamed: "happy-children")
        let randomRange = Int.random(in: 0...1)
        if randomRange == 0 {
            return backgroundSound
        } else {
            return backgroundSound
        }
    }
    
    
}
