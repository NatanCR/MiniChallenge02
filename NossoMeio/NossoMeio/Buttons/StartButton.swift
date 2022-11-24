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
    var action: (() -> Void)?
    
    init(image: SKSpriteNode, action: @escaping () -> Void) {
        self.image = image
        self.action = action
        super.init()
        //pode receber interação com o usuário
        self.isUserInteractionEnabled = true
        self.addChild(image)
    }
    
    //inicializador para ajudar a criar o botao pela cena
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.action?()
    }
    
}
