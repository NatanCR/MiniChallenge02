//
//  GameCreators.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 28/11/22.
//

import Foundation
import SpriteKit

class GameCreators: SKNode {
    
    private var touchLocation = CGPoint()
    private var body = SKPhysicsBody()
    private let x_points = [85, 185, 285, 385, 485, 585, 685]
    private var heartArray = [HeartObject]()
    let trashCategory: UInt32 = 1
    let plasticCategory: UInt32 = 2
    let organicCategory: UInt32 = 4
    let glassCategory: UInt32 = 8
    let metalCategory: UInt32 = 16
    let paperCategory: UInt32 = 32
    var junkCounter = 0
    var isActive = false
    var heartCounter = 0
    
    func createHearts() {
        for i in 0...2 {
            let heartObj = HeartObject()
            heartArray.append(heartObj)
            heartArray[i].name = "coracao\(i)"
            heartArray[i].setPosition(heart: 750-(CGFloat((2-i))*35))
            heartCounter += 1
            self.addChild(heartArray[i])
        }
    }
    
    func changeHearts() {
        let changeTexture = SKAction.setTexture(SKTexture(imageNamed: "copo"))
        for i in 0...2 {
            if heartArray[i].isActive == true {
                heartArray[i].setTexture(heart: changeTexture)
                heartArray[i].isActive = false
                break
            }
        }
    }
    
    func createFinalJunkArray(_ plasticJunkArray: [JunkObject], _ organicJunkArray: [JunkObject]) {
        var finalJunkArray = [JunkObject]()
        var newPlasticJunkArray = plasticJunkArray
        var newOrganicJunkArray = organicJunkArray
        
        var randomPositions = CGPoint()
        var positions_x = [Int: Int]()
        var randomRange: Int
        
            newPlasticJunkArray.shuffle()
            for i in 0..<4 {
                finalJunkArray.append(newPlasticJunkArray[i])
                junkCounter += 1
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
            randomPositions = CGPoint(x: x_points[randomRange], y: 70)
            
            let junkObj = JunkObject(image: SKSpriteNode(imageNamed: arrayImagePlastic[i]), positionPoint: randomPositions, junkType: .plastic, body: createJunkPhysicsBody(type: .plastic))
            
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
            randomPositions = CGPoint(x: x_points[randomRange], y: 70)
            
            let junkObj = JunkObject(image: SKSpriteNode(imageNamed: arrayImageOrganic[i]), positionPoint: randomPositions, junkType: .organic, body: createJunkPhysicsBody(type: .organic))
            
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


