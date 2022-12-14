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
    private let x_points = [-750, -500, -250, 0, 250, 500, 750]
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
        background.size = CGSize(width: 1920, height: 1080)
        self.addChild(background)
    }
    
    func createGround() {
        let groundTexture = SKTexture(imageNamed: "chao")
        let ground = SKSpriteNode(texture: groundTexture)
        ground.position = CGPoint(x: 0, y: -400)
        ground.setScale(1.5)
        ground.zPosition = -1
        addChild(ground)
    }
    
    func createHearts() {
        for i in 0...2 {
            let heartObj = HeartObject()
            heartArray.append(heartObj)
            heartArray[i].name = "coracao\(i)"
            heartArray[i].zPosition = 0
            heartArray[i].setPosition(heart: 10-(CGFloat((-4-Double(i)))*120))
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
                randomPositions = CGPoint(x: x_points[randomRange], y: -300)
                
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
                        finalJunkArray[i].setPosition(positionPoint: value)
                    }
                }
                self.addChild(finalJunkArray[i])
            }
    }
    
    
    func createTrash() {
        let trash = SKSpriteNode(imageNamed: "lixeira")
        trash.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        trash.position = CGPoint(x: 0, y: 80)
        trash.setScale(1)
        trash.zPosition = -2
        trash.physicsBody = createTrashPhysicsBody(trash: trash)
        
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
            randomPositions = CGPoint(x: x_points[randomRange], y: -300)
            
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
            randomPositions = CGPoint(x: x_points[randomRange], y: -300)
            
            let junkObj = JunkObject(image: arrayImageOrganic[i], positionPoint: randomPositions, junkType: .organic, body: createJunkPhysicsBody(type: .organic))
            organicJunk.append(junkObj)
        }
        return organicJunk
    }
    
    func createJunkPhysicsBody(type: JunkObject.JunkType) -> SKPhysicsBody {
        body = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100)) //corpo a partir de uma forma
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
        body = SKPhysicsBody(circleOfRadius: 200, center: CGPoint(x: 0, y: 150))
        body.affectedByGravity = false
        body.allowsRotation = false
        body.isDynamic = false
        body.contactTestBitMask = plasticCategory | organicCategory | metalCategory | glassCategory | paperCategory
        body.categoryBitMask = trashCategory
        body.collisionBitMask = 0
        
        return body
    }
}


