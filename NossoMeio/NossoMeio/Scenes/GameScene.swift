//
//  GameScene.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 11/11/22.
//
import Foundation
import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var touchLocation = CGPoint()
    var body = SKPhysicsBody()
    
    let objectCategory: UInt32 = 0x1 << 0 //1
    let trashCategory: UInt32 = 0x1 << 1 //2   //0x1 << 2 // 4
    
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
        
        createTrash()
        createObject()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == trashCategory | objectCategory {
            print("CONTATO CHAMA O VAR")
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        print("acabou contato")
    }
    
    func createTrash() {
        let trash = SKSpriteNode(color: .red, size: .init(width: 200, height: 100))
        trash.anchorPoint = CGPoint(x: 0, y: 0)
        trash.position = CGPoint(x: 330, y: 180)
        trash.size = CGSize(width: 200, height: 200)
        trash.name = "trash"
        
        body = SKPhysicsBody(rectangleOf: trash.size)
        body.affectedByGravity = false
        body.allowsRotation = false
        body.isDynamic = false
        body.categoryBitMask = trashCategory
        
        trash.physicsBody = body
        
        self.addChild(trash)
    }
    
    func createObject() {
        
        let image = SKSpriteNode(imageNamed: "Tree")
        let junk = JunkObject(image: image, width: 70, height: 70)
        junk.color = .red
        junk.position = .init(x: 330, y: 70)
        junk.physicsBody?.affectedByGravity = true
        
        junk.setActionMoved(action: .moved) { touches in
            for touch in touches {
                self.touchLocation = touch.location(in: self)
                junk.position = self.touchLocation
            }
        }
        
        junk.setActionMoved(action: .endMoved) { touches in
            junk.position = CGPoint(x: 330, y: 70)
        }
        
        
        body = SKPhysicsBody(rectangleOf: junk.size)
        body.affectedByGravity = false
        body.allowsRotation = false
        body.contactTestBitMask = trashCategory
        body.categoryBitMask = objectCategory
        
        junk.physicsBody = body
        junk.physicsBody?.collisionBitMask = 0
        
        self.addChild(junk)
    }
}
