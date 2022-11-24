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
    
    public let points = [
        CGPoint(x: 385, y: 70),
        CGPoint(x: 285, y: 70),
        CGPoint(x: 185, y: 70),
        CGPoint(x: 85, y: 70),
        CGPoint(x: 485, y: 70),
        CGPoint(x: 585, y: 70),
        CGPoint(x: 685, y: 70)]
    
    let xPoints = [85, 185, 285] //, 385, 485, 585, 685
    
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
        // createOrganicJunk()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contacting: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contacting == trashCategory | plasticCategory {
            print("CONTATO COM PLASTICO")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                contact.bodyB.node?.removeFromParent()
            }
            
        } else if contacting == trashCategory | organicCategory {
            print("CONTATO COM ORGANICO")
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
        var randomPositions : CGPoint
        var plasticJunk = [JunkObject]()
        var positions_x = [Int: Int]()
        var randomRange: Int
        
        for i in 0..<3{
            repeat{
                randomRange = Int.random(in: 0..<3)
                
            } while positions_x[randomRange] != nil
            
            positions_x[randomRange] = randomRange
            randomPositions = CGPoint(x: xPoints[randomRange], y: 70)
            
            let junkObj  = JunkObject(image: SKSpriteNode(imageNamed: arrayImagePlastic[i]), size: CGSize(width: 50, height: 50), positionPoint: randomPositions, junkType: .plastic, body: createJunkPhysicsBody(type: .plastic))
            plasticJunk.append(junkObj)
            
            plasticJunk[i].setActionMoved(action: .moved) { touches in
                for touch in touches {
                    self.touchLocation = touch.location(in: self)
                    self.touchLocation.x -= plasticJunk[i].positionPoint.x
                    self.touchLocation.y -= plasticJunk[i].positionPoint.y
                    plasticJunk[i].position = self.touchLocation
                }
            }
            
            self.addChild(plasticJunk[i])
        }
    }
    
    func createOrganicJunk() {
        //        let imageOrganic = ["papel", "maca"]
        let imageNode = SKSpriteNode(imageNamed: "papel")
        let junkOrganic = JunkObject(image: imageNode, size: CGSize(width: 50, height: 50), positionPoint: points[3], junkType: .organic, body: createJunkPhysicsBody(type: .organic))
        junkOrganic.zPosition = 1
        
        junkOrganic.setActionMoved(action: .moved) { touches in
            for touch in touches {
                self.touchLocation = touch.location(in: self)
                self.touchLocation.x -= junkOrganic.positionPoint.x
                self.touchLocation.y -= junkOrganic.positionPoint.y
                junkOrganic.position = self.touchLocation
            }
        }
        
        junkOrganic.setActionMoved(action: .endMoved) { touches in
            junkOrganic.position = CGPoint(x: 0, y: 0)
        }
        
        self.addChild(junkOrganic)
    }
    
    func createJunkPhysicsBody(type: JunkObject.JunkType) -> SKPhysicsBody {
        body = SKPhysicsBody(rectangleOf: CGSize(width: 5, height: 5)) //corpo a partir de uma forma
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
