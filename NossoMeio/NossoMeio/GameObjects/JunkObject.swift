
//  TrashObject.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 20/11/22.

import SpriteKit

class JunkObject: SKSpriteNode {
    
    private var actionMoved: ((_ touches: Set<UITouch>) -> Void)?
    private var actionEndMoved: ((_ touches: Set<UITouch>) -> Void)?
    private var junkType: String?
    
    enum ActionType {
        case moved, endMoved
    }
    
    enum JunkType {
        case plastic, organic, glass, metal, paper
    }
    
    init(image: SKSpriteNode, width: Double, height: Double) {
        super.init(texture: nil, color: .clear, size: CGSize(width: width, height: height))
        self.addChild(image)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoder not supported")
    }
    
    func setActionMoved(action type: ActionType, _ action: @escaping (_ touches: Set<UITouch>) -> Void) {
        switch type {
        case .moved:
            self.actionMoved = action
        case .endMoved:
            self.actionEndMoved = action
        }
    }
    
    func setTypeJunk(junkType type: JunkType, _ junkType: String) {
        switch type {
        case .plastic:
            self.junkType = junkType
        case .organic:
            self.junkType = junkType
        case .glass:
            self.junkType = junkType
        case .metal:
            self.junkType = junkType
        case .paper:
            self.junkType = junkType
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.actionMoved?(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.actionMoved?(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.actionEndMoved?(touches)
    }
}
