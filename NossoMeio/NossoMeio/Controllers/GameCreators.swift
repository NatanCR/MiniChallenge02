//
//  GameCreators.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 28/11/22.
//

import Foundation
import SpriteKit

class GameCreators: SKNode {
    
    private var body = SKPhysicsBody()
    private let x_points = [-0.4, -0.26, -0.13, 0, 0.13, 0.26, 0.4]
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
    
    func createBackground() {
        let backgroundTexture = SKTexture(imageNamed: "fundo")
        let background = SKSpriteNode(texture: backgroundTexture)
        background.zPosition = -4
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.scale(to: CGSize(width: 1, height: 1))
        self.addChild(background)
    }
    
    func createGround() {
        let groundTexture = SKTexture(imageNamed: "chao")
        let ground = SKSpriteNode(texture: groundTexture)
        ground.position = CGPoint(x: 0, y: -0.4)
        ground.setScale(0.0017)
        ground.zPosition = -1
        addChild(ground)
    }
    
    func createHearts() {
        for i in 0...2 {
            let heartObj = HeartObject()
            heartArray.append(heartObj)
            heartArray[i].name = "coracao\(i)"
            heartArray[i].zPosition = 0
            heartArray[i].setPosition(heart: 0.3-(CGFloat((0.1-Double(i)))*0.05))
            heartCounter += 1
            self.addChild(heartArray[i])
        }
    }
    
    func changeHearts() {
        let changeTexture = SKAction.setTexture(SKTexture(imageNamed: "coracaoCinza"))
        
        for i in 0...2 {
            if heartArray[i].isActive == true {
                heartArray[i].setTexture(heart: changeTexture)
                heartArray[i].isActive = false
                heartCounter -= 1
                break
            }
        }
    }
    
    func createFinalJunkArray(_ plasticJunkArray: [JunkObject], _ organicJunkArray: [JunkObject]) {
        var finalJunkArray = [JunkObject]()
        let newPlasticJunkArray = plasticJunkArray
        let newOrganicJunkArray = organicJunkArray
        
        var randomPositions = CGPoint()
        var positions_x = [Int: Int]()
        var randomRange: Int
        var arrayPositionObject = [String: CGPoint]()
        
            for i in 0..<4 {
                finalJunkArray.append(newPlasticJunkArray[i])
                junkCounter += 1
            }
            
            for i in 0..<3 {
                finalJunkArray.append(newOrganicJunkArray[i])
            }
            
            for i in 0...finalJunkArray.count - 1 {
                repeat {
                    randomRange = Int.random(in: 0..<7)
                } while positions_x[randomRange] != nil
                
                positions_x[randomRange] = randomRange
                randomPositions = CGPoint(x: x_points[randomRange], y: -0.3)
                
                finalJunkArray[i].setPosition(positionPoint: randomPositions)
                
                finalJunkArray[i].name = "objeto-\(i)"
                finalJunkArray[i].zPosition = 1
                
                finalJunkArray[i].setActionMoved(action: .touch) { touches in
                    for touch in touches {
                        let touchLocation = touch.location(in: self)
                        if finalJunkArray[i].contains(touchLocation) {
                            arrayPositionObject = ["objeto-\(i)": touchLocation]
                        }
                    }
                }
                
                finalJunkArray[i].setActionMoved(action: .moved) { touches in
                    for touch in touches {
                        let touchLocation = touch.location(in: self)
                        finalJunkArray[i].setPosition(positionPoint: touchLocation)
                    }
                }
                
                finalJunkArray[i].setActionMoved(action: .endMoved) { touches in
                    for (key, value) in arrayPositionObject {
                        print("key \(key) -- value \(value)")
                        finalJunkArray[i].setPosition(positionPoint: value)
                    }
                }
                self.addChild(finalJunkArray[i])
            }
    }
    
    
    func createTrash() {
        let trash = SKSpriteNode(imageNamed: "lixeira")
        trash.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        trash.position = CGPoint(x: 0, y: 0.09)
        trash.scale(to: CGSize(width: 0.22, height: 0.6))
        trash.zPosition = -2
        trash.physicsBody = createTrashPhysicsBody()
        
        self.addChild(trash)
    }
    
    func createPlasticJunk() -> [JunkObject] {
        var arrayImagePlastic = [ "balde", "copo", "frasco", "sacola", "garrafa", "saquinho", "tampinha"]
        var plasticJunk = [JunkObject]()
        var randomPositions : CGPoint
        var positions_x = [Int: Int]()
        var randomRange: Int
        
        arrayImagePlastic.shuffle()
        for i in 0..<4 {
            repeat {
                randomRange = Int.random(in: 0..<4)
            } while positions_x[randomRange] != nil
            
            positions_x[randomRange] = randomRange
            randomPositions = CGPoint(x: x_points[randomRange], y: 0.4)
            
            let junkObj = JunkObject(image: arrayImagePlastic[i], positionPoint: randomPositions, junkType: .plastic, body: createJunkPhysicsBody(type: .plastic))
            
            plasticJunk.append(junkObj)
            
        }
        
        return plasticJunk
    }
    
    func createOrganicJunk() -> [JunkObject] {
        var arrayImageOrganic = ["banana", "clips", "latinha", "maca", "ovo", "papel", "pilha"]
        var randomPositions : CGPoint
        var organicJunk = [JunkObject]()
        var positions_x = [Int: Int]()
        var randomRange: Int
        
        arrayImageOrganic.shuffle()
        for i in 0..<3 {
            repeat {
                randomRange = Int.random(in: 0..<3)
            } while positions_x[randomRange] != nil
            
            positions_x[randomRange] = randomRange
            randomPositions = CGPoint(x: x_points[randomRange], y: 0.4)
            
            let junkObj = JunkObject(image: arrayImageOrganic[i], positionPoint: randomPositions, junkType: .organic, body: createJunkPhysicsBody(type: .organic))
            organicJunk.append(junkObj)
        }
        return organicJunk
    }
    
    func createJunkPhysicsBody(type: JunkObject.JunkType) -> SKPhysicsBody {
        body = SKPhysicsBody(rectangleOf: CGSize(width: 0.08, height: 0.08)) //corpo a partir de uma forma
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
    
    func createTrashPhysicsBody() -> SKPhysicsBody {
        body = SKPhysicsBody(circleOfRadius: 0.055, center: CGPoint(x: 0, y: 0.15))
        body.affectedByGravity = false
        body.allowsRotation = false
        body.isDynamic = false
        body.contactTestBitMask = plasticCategory | organicCategory | metalCategory | glassCategory | paperCategory
        body.categoryBitMask = trashCategory
        body.collisionBitMask = 0
        
        return body
    }
}


