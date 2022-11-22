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
    
    let points = [
        CGPoint(x: 385, y: 70),
        CGPoint(x: 285, y: 70),
        CGPoint(x: 185, y: 70),
        CGPoint(x: 85, y: 70),
        CGPoint(x: 485, y: 70),
        CGPoint(x: 585, y: 70),
        CGPoint(x: 685, y: 70)
    ]
    
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                contact.bodyB.node?.removeFromParent()
            }
            
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
        let arrayImagePlastic = ["garrafinha", "sacola", "copo"]
        let imageNode = SKSpriteNode(imageNamed: "sacola")
        let imageNode1 = SKSpriteNode(imageNamed: "copo")
        let imageNode2 = SKSpriteNode(imageNamed: "garrafinha")
        
//        for i in arrayImagePlastic {
//            imageNode = SKSpriteNode(imageNamed: i)
//        }
        
        let plasticJunk = [JunkObject(image: imageNode, width: 50, height: 50, type: .plastic, position: CGPoint(x: 385, y: 70)),
                           JunkObject(image: imageNode1, width: 50, height: 50, type: .plastic, position: CGPoint(x: 285, y: 70)),
                           JunkObject(image: imageNode2, width: 50, height: 50, type: .plastic, position: CGPoint(x: 185, y: 70))]
        
//        for point in points [1..<points.count] {
//            
//        }
        
//        plasticJunk.position = .init(x: 85, y: 70)
//        plasticJunk.zPosition = 1
        
        plasticJunk[0].setActionMoved(action: .moved) { touches in
            for touch in touches {
                self.touchLocation = touch.location(in: self)
                plasticJunk[0].position = self.touchLocation
            }
        }
        plasticJunk[1].setActionMoved(action: .moved) { touches in
            for touch in touches {
                self.touchLocation = touch.location(in: self)
                plasticJunk[1].position = self.touchLocation
            }
        }
        plasticJunk[2].setActionMoved(action: .moved) { touches in
            for touch in touches {
                self.touchLocation = touch.location(in: self)
                plasticJunk[2].position = self.touchLocation
            }
        }
        
        plasticJunk[0].physicsBody = createJunkPhysicsBody(junk: plasticJunk[0], type: .plastic)
        plasticJunk[1].physicsBody = createJunkPhysicsBody(junk: plasticJunk[1], type: .plastic)
        plasticJunk[2].physicsBody = createJunkPhysicsBody(junk: plasticJunk[2], type: .plastic)
        self.addChild(plasticJunk[0])
        self.addChild(plasticJunk[1])
        self.addChild(plasticJunk[2])

       
    }
    
    func createOrganicJunk() {
        let imageOrganic = ["papel", "maca"]
        let image = SKSpriteNode(imageNamed: "papel")
        let junk = JunkObject(image: image, width: 2, height: 2, type: .organic, position: points[3])
//        junk.position = .init(x: 460, y: 70)
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
