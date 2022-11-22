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
    
    let trashCategory: UInt32 = 1
    let plasticCategory: UInt32 = 2
    let organicCategory: UInt32 = 4
    let glassCategory: UInt32 = 8
    let metalCategory: UInt32 = 16
    let paperCategory: UInt32 = 32
    
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
        createPlasticJunk()
        createOrganicJunk()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contacting: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contacting == trashCategory | plasticCategory {
            print("CONTATO COM PLASTICO")
            //mudanca de estado entra aqui
        } else if contacting == trashCategory | organicCategory {
            print("CONTATO COM ORGANICO")
            //mudanca de estado entra aqui
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        print("acabou contato")
    }
    
    func createTrash() {
        let trash = SKSpriteNode(imageNamed: "lixeira")
        trash.position = CGPoint(x: 385, y: 240)
        trash.size = CGSize(width: 200, height: 200)
        trash.zPosition = -1
        trash.physicsBody = createTrashPhysicsBody(trash: trash)
        
        self.addChild(trash)
    }
    
    func createPlasticJunk() {
        let image = SKSpriteNode(imageNamed: "garrafinha")
        let junk = JunkObject(image: image, width: 50, height: 50, type: .plastic)
        junk.position = .init(x: 330, y: 70)
        junk.zPosition = 1
        
        junk.setActionMoved(action: .moved) { touches in
            for touch in touches {
                self.touchLocation = touch.location(in: self)
                junk.position = self.touchLocation
            }
        }
        
        junk.physicsBody = createJunkPhysicsBody(junk: junk, type: .plastic)
        self.addChild(junk)
    }
    
    func createOrganicJunk() {
        let image = SKSpriteNode(imageNamed: "papel")
        let junk = JunkObject(image: image, width: 2, height: 2, type: .organic)
        junk.position = .init(x: 460, y: 70)
        junk.zPosition = 1
        
        junk.setActionMoved(action: .moved) { touches in
            for touch in touches {
                self.touchLocation = touch.location(in: self)
                junk.position = self.touchLocation
            }
        }
        
        junk.setActionMoved(action: .endMoved) { touches in
            junk.position = CGPoint(x: 460, y: 70)
        }
        
        junk.physicsBody = createJunkPhysicsBody(junk: junk, type: .organic)
        self.addChild(junk)
    }
    
    func createJunkPhysicsBody(junk: SKSpriteNode, type: JunkObject.JunkType) -> SKPhysicsBody {
        body = SKPhysicsBody(rectangleOf: junk.size) //corpo a partir de uma forma
        body.affectedByGravity = false
        body.allowsRotation = false
        body.isDynamic = true
        
        switch type {
        case .plastic:
            body.categoryBitMask = plasticCategory
        case .organic:
            body.categoryBitMask = organicCategory
        case .glass:
            body.categoryBitMask = glassCategory
        case .metal:
            body.categoryBitMask = metalCategory
        case .paper:
            body.categoryBitMask = paperCategory
        }
        
        body.contactTestBitMask = trashCategory
        body.collisionBitMask = 0
        
        return body
    }
    
    func createTrashPhysicsBody(trash: SKSpriteNode) -> SKPhysicsBody {
        body = SKPhysicsBody(rectangleOf: trash.size)
        body.affectedByGravity = false
        body.allowsRotation = false
        body.isDynamic = false
        body.contactTestBitMask = plasticCategory | organicCategory | metalCategory | glassCategory | paperCategory
        body.categoryBitMask = trashCategory
        body.collisionBitMask = 0
        
        return body
    }
}
