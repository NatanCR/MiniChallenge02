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
        self.backgroundColor = SKColor.brown
        self.physicsWorld.contactDelegate = self
    }
    
    override func didMove(to view: SKView) {
        
        //         var heartsArray: [SKSpriteNode] = [SKSpriteNode]()
        //
        //        let heart = SKSpriteNode(imageNamed: "vidaCheia")
        //
        //        heartsArray.append(heart)
        //
        //
        
        
        //posição da ancora na tela
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        //limite de gravidade na tela
//        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

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
            setEmitter()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                contact.bodyB.node?.removeFromParent()
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
                    winGame(isActive: gameCreators.isActive)
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
            let winScene = LoseScene(size: self.size)
            self.view?.presentScene(winScene, transition: transition)
        }
    }
    
    func setEmitter() {
            particleEmitter = SKEmitterNode(fileNamed: "spark")
            particleEmitter.position.x = 380
            particleEmitter.position.y = 245
            particleEmitter.zPosition = -1
            self.addChild(particleEmitter)
        }
    
    func displayBackgroundSound() -> SKAudioNode {
        let backgroundSound = SKAudioNode(fileNamed: "LovableClownSit.mp3")
        let backgroundSound2 = SKAudioNode(fileNamed: "AfterSchoolJamboree.mp3")
        let randomRange = Int.random(in: 0...1)
        if randomRange == 0 {
            return backgroundSound
        } else {
            return backgroundSound2
        }
    }
    
    
}
