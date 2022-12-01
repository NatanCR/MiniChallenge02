//
//  ButtonAnimation.swift
//  NossoMeio
//
//  Created by Barbara Argolo on 29/11/22.
//

import SpriteKit

class ButtonAnimation {
    public static func pressed(_ scaleFactor: CGFloat) -> SKAction {
        let scaleDown = SKAction.scale(by: scaleFactor, duration: 0.06)
        let scaleUp = SKAction.scale(by: 1.8, duration: 0.06)
        return SKAction.sequence([ scaleDown, scaleUp ])
    }
}
