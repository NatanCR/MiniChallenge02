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
    
    var trash = SKSpriteNode()
    var object = SKSpriteNode()
    var touchLocation = CGPoint() 
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.backgroundColor = SKColor.brown
    }
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        createTrash()
        createObject()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            touchLocation = touch.location(in: self)
            object.position = touchLocation
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            touchLocation = touch.location(in: self)
            object.position = touchLocation
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func createTrash() {
        trash = SKSpriteNode(imageNamed: "Sign")
        trash.anchorPoint = CGPoint(x: 0, y: 0)
        trash.position = CGPoint(x: 330, y: 130)
        trash.size = CGSize(width: 200, height: 200)
        self.addChild(trash)
    }
    
    func createObject() {
        object = SKSpriteNode(imageNamed: "Tree")
        object.anchorPoint = CGPoint(x: 0, y: 0)
        object.position = CGPoint(x: 330, y: 50)
        object.size = CGSize(width: 70, height: 70)
        self.addChild(object)
    }
}
