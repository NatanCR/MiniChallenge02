//
//  GameScene.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 11/11/22.
//
import Foundation
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ground = SKSpriteNode()
    var player = SKSpriteNode()
    
    override func sceneDidLoad() {
        
        do {
            ground = SKSpriteNode(imageNamed: "ground")
            ground.size = CGSize(width: 880, height: 150)
            ground.setScale(0.5)
            ground.position = CGPoint(x: self.frame.width / 2, y: 0 + ground.frame.height / 2)
            
            let body = SKPhysicsBody(rectangleOf: ground.size)
            body.affectedByGravity = true
            body.allowsRotation = false
            body.isDynamic = false
            
            ground.physicsBody = body
            
            self.addChild(ground)
            
            createStones()
        }
        
        do {
            player = SKSpriteNode(imageNamed: "Run (1)")
            player.size = CGSize(width: 100, height: 100)
            player.position = CGPoint(x: self.frame.width / 2 - 50 , y: ground.frame.height)
            
            let body = SKPhysicsBody(rectangleOf: player.size)
            body.affectedByGravity = true
            body.allowsRotation = false
            
            player.physicsBody = body
            
            self.addChild(player)
        }
        
    }
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            player.physicsBody?.applyImpulse(.init(dx: player.size.width, dy: player.size.height * 2))
        player.run(.repeatForever(.animate(with: .init(format: "Run (%@)", frameCount: 1...8), timePerFrame: 0.1)))
    }
    
    func createStones() {
        let stonePair = SKNode()
        let stone = SKSpriteNode(imageNamed: "Stone")
        stone.size = CGSize(width: 60, height: 60)
        
        stone.position = CGPoint(x: self.frame.width / 2 + 120, y: self.frame.height / 2 - 285)
        stone.setScale(0.5)
        
        stonePair.addChild(stone)
        self.addChild(stonePair)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

//criando um atalho para percorrer todos os frames de imagens do SKTexture
extension Array where Element == SKTexture {
    init(format: String, frameCount: ClosedRange<Int>) {
        self = frameCount.map({ (index) in
            let imageName = String(format: format, "\(index)")
            return SKTexture(imageNamed: imageName)
        })
    }
}
