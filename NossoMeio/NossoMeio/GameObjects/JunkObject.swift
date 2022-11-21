import SpriteKit
//
//  TrashObject.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 20/11/22.
//
//
//import Foundation
//import SpriteKit
//
//class TrashObject: SKSpriteNode {
//    
//    enum ActionType {
//        case moved, endMoved
//    }
//    
//    private var image: SKSpriteNode?
//    private var label: SKLabelNode?
//    private var actionMoved: (() -> Void)?
//    private var actionEndMoved: (() -> Void)?
//    
//    init(image: SKSpriteNode?, label: SKLabelNode? = nil, size: CGSize) {
//        self.image = image
//        self.label = label
//        super.init(color: .clear, size: size)
//        
//        //pode receber interação com o usuário
//        self.isUserInteractionEnabled = true
//        
//        if let image = image {
//            self.addChild(image)
//        }
//        
//        if let label = label {
//            self.addChild(label)
//        }
//    }
//    
//    public func setActionMoved(action type: ActionType, _ action: @escaping () -> Void) {
//        switch type {
//        case .moved:
//            self.actionMoved = action
//        case .endMoved:
//            self.actionEndMoved = action
//        }
//    }
//    
//    //inicializador para ajudar a criar o botao pela cena
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.actionMoved?()
//
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.actionMoved?()
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.actionEndMoved?()
//    }
//}

class JunkObject: SKSpriteNode {
    
    private var actionMoved: ((_ touches: Set<UITouch>) -> Void)?
    private var actionEndMoved: ((_ touches: Set<UITouch>) -> Void)?
    
    enum ActionType {
        case moved, endMoved
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
