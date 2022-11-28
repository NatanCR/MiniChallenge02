//
//  LifeObject.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 27/11/22.
//

import SpriteKit

class LifeObject: SKNode {
    private var image: SKSpriteNode
    
    override init() {
        self.image = SKSpriteNode(imageNamed: "vidaCheia")
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createHeart() {
        self.addChild(image)
        
        image.position
    }
    
}
