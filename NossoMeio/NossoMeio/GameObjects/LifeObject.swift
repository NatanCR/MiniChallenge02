//
//  LifeObject.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 27/11/22.
//

import SpriteKit

class LifeObject: SKNode {
    private var heart: SKSpriteNode
    
    override init() {
        self.heart = SKSpriteNode(imageNamed: "vidaCheia")
        super.init()
        createHeart()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createHeart() {
        heart.anchorPoint = CGPoint(x: 0, y: 0)
        heart.position = CGPoint(x: 685, y: 300)
        heart.size = CGSize(width: 50, height: 50)
        heart.zPosition = 3
        self.addChild(heart)
    }
    
}
