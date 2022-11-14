//
//  GameScene.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 11/11/22.
//
import Foundation
import SpriteKit
import GameplayKit

struct physicsCategory {
    static let player : UInt32 = 0x1 << 1
    static let ground : UInt32 = 0x1 << 2
    static let stone : UInt32 = 0x1 << 3
}

class GameScene: SKScene {
    
    var ground = SKSpriteNode()
    var player = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        ground = SKSpriteNode(imageNamed: "ground")
        ground.size = CGSize(width: 880, height: 150)
        ground.setScale(0.5)
        ground.position = CGPoint(x: self.frame.width / 2, y: 0 + ground.frame.height / 2)
        self.addChild(ground)
        
        player = SKSpriteNode(imageNamed: "Run (1)")
        player.size = CGSize(width: 100, height: 100)
        player.position = CGPoint(x: self.frame.width / 2 - 20 , y: 30 + ground.frame.height)
        self.addChild(player)
        player.run(.repeatForever(.animate(with: .init(format: "Run (%@)", frameCount: 1...8), timePerFrame: 0.1)))
        
        createStones()
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
