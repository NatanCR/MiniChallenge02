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
    
    let x_pointsForPlastic = [85, 285, 485, 685]
    let x_pointsForOrganic = [185, 385, 585]
    
    let x_points = [85, 185, 285, 385, 485, 585, 685]
    
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
        //        createPlasticJunk()
        //        createOrganicJunk()
        
        createFinalJunkArray(plasticArray: createPlasticJunk(), organicArray: createOrganicJunk())
        
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
    
    func createFinalJunkArray(plasticArray: [JunkObject], organicArray: [JunkObject]) {
        var finalJunkArray = [JunkObject]()
        var newPlasticJunkArray = plasticArray
        var newOrganicJunkArray = organicArray
        
        var randomPositions = CGPoint()
        var positions_x = [Int: Int]()
        var randomRange: Int
        
            newPlasticJunkArray.shuffle()
            for i in 0..<4 {
                finalJunkArray.append(newPlasticJunkArray[i])
            }
            
            newOrganicJunkArray.shuffle()
            for i in 0..<3 {
                finalJunkArray.append(newOrganicJunkArray[i])
            }
            
            for i in 0...finalJunkArray.count - 1 {
                repeat {
                    randomRange = Int.random(in: 0..<7)
                } while positions_x[randomRange] != nil
                
                positions_x[randomRange] = randomRange
                randomPositions = CGPoint(x: x_points[randomRange], y: 70)
                
                finalJunkArray[i].setPosition(positionPoint: randomPositions)
                
                finalJunkArray[i].setActionMoved(action: .moved) { touches in
                    for touch in touches {
                        self.touchLocation = touch.location(in: self)
                        self.touchLocation.x -= finalJunkArray[i].positionPoint.x
                        self.touchLocation.y -= finalJunkArray[i].positionPoint.y
                        finalJunkArray[i].position = self.touchLocation
                    }
                }
                
                finalJunkArray[i].setActionMoved(action: .endMoved) { touches in
                    finalJunkArray[i].position = CGPoint(x: 0, y: 0)
                }
                self.addChild(finalJunkArray[i])
            }
    }
    
    
    func createTrash() {
        let trash = SKSpriteNode(imageNamed: "lixeira")
        trash.position = CGPoint(x: 385, y: 240)
        trash.size = CGSize(width: 200, height: 200)
        trash.zPosition = -1
        trash.physicsBody = createTrashPhysicsBody(trash: trash)
        
        self.addChild(trash)
    }
    
    func createPlasticJunk() -> [JunkObject] {
        let arrayImagePlastic = ["garrafinha", "sacola", "copo", "frasco"]
        var plasticJunk = [JunkObject]()
        var randomPositions : CGPoint
        var positions_x = [Int: Int]()
        var randomRange: Int
        
        for i in 0..<4 {
            repeat {
                randomRange = Int.random(in: 0..<4)
                
            } while positions_x[randomRange] != nil
            
            positions_x[randomRange] = randomRange
            randomPositions = CGPoint(x: x_pointsForPlastic[randomRange], y: 70)
            
            let junkObj = JunkObject(image: SKSpriteNode(imageNamed: arrayImagePlastic[i]), size: CGSize(width: 50, height: 50), positionPoint: randomPositions, junkType: .plastic, body: createJunkPhysicsBody(type: .plastic))
            
            plasticJunk.append(junkObj)
            
//            plasticJunk[i].setActionMoved(action: .moved) { touches in
//                for touch in touches {
//                    self.touchLocation = touch.location(in: self)
//                    self.touchLocation.x -= plasticJunk[i].positionPoint.x
//                    self.touchLocation.y -= plasticJunk[i].positionPoint.y
//                    plasticJunk[i].position = self.touchLocation
//                }
//            }
//
//            plasticJunk[i].setActionMoved(action: .endMoved) { touches in
//                plasticJunk[i].position = CGPoint(x: 0, y: 0)
//            }
            
            //            self.addChild(plasticJunk[i])
        }
        
        return plasticJunk
    }
    
    func createOrganicJunk() -> [JunkObject] {
        let arrayImageOrganic = ["papel", "maca", "pilha"]
        var randomPositions : CGPoint
        var organicJunk = [JunkObject]()
        var positions_x = [Int: Int]()
        var randomRange: Int
        
        for i in 0..<3 {
            repeat {
                randomRange = Int.random(in: 0..<3)
                
            } while positions_x[randomRange] != nil
            
            positions_x[randomRange] = randomRange
            randomPositions = CGPoint(x: x_pointsForOrganic[randomRange], y: 70)
            
            let junkObj = JunkObject(image: SKSpriteNode(imageNamed: arrayImageOrganic[i]), size: CGSize(width: 50, height: 50), positionPoint: randomPositions, junkType: .organic, body: createJunkPhysicsBody(type: .organic))
            organicJunk.append(junkObj)
            
//            organicJunk[i].setActionMoved(action: .moved) { touches in
//                for touch in touches {
//                    self.touchLocation = touch.location(in: self)
//                    self.touchLocation.x -= organicJunk[i].positionPoint.x
//                    self.touchLocation.y -= organicJunk[i].positionPoint.y
//                    organicJunk[i].position = self.touchLocation
//                }
//            }
//
//            organicJunk[i].setActionMoved(action: .endMoved) { touches in
//                organicJunk[i].position = CGPoint(x: 0, y: 0)
//            }
            //            self.addChild(organicJunk[i])
        }
        
        return organicJunk
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
