//
//  StartButton.swift
//  NossoMeio
//
//  Created by Natan Rodrigues on 19/11/22.
//

import Foundation
import SpriteKit

class StartButton: SKNode {
    
    var image: SKSpriteNode?
    var label: SKLabelNode?
    var action: (() -> Void)?
    
    init(image: SKSpriteNode, label: SKLabelNode, action: @escaping () -> Void) {
        self.image = image
        self.label = label
        self.action = action
        super.init()
        //pode receber interação com o usuário
        self.isUserInteractionEnabled = true
        
        self.addChild(image)
        self.addChild(label)
    }
    
    //inicializador para ajudar a criar o botao pela cena
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.action?()
        
    }
}
