//
//  HeartObject.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 28/11/22.
//

import SpriteKit

class HeartObject: SKNode {
    var heart = SKSpriteNode()
    var isActive = true
    
    override init() {
        super.init()
        self.heart = SKSpriteNode(imageNamed: "vidaCheia")
        heart.anchorPoint = CGPoint(x: 0.5, y: 1)
        heart.size = CGSize(width: 35, height: 35)
        heart.position.y = 350
        self.addChild(heart)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPosition(heart point: CGFloat) {
        self.heart.position.x = point
    }
    
    func setTexture(heart action: SKAction) {
        self.heart.run(action)
    }
    
    func deleteHeart() {
            if self.isActive == true {
                self.heart = SKSpriteNode(imageNamed: "copo")
                self.isActive = false
            }
    }
}
