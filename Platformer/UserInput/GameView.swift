//
//  GameView.swift
//  Platformer
//
//  Created by Walt Semrau on 3/12/23.
//


import MetalKit

class GameView: MTKView{
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Interface.setTouched(isT: true)
        for touch in touches {
            Interface.setTouchStart(x: Float(touch.location(in: self).x))
            Interface.setTouchStarty(y: Float(touch.location(in: self).y))
            
        }
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        Interface.setwasTouched(isT: true)
        Interface.setTouched(isT: false)
        for touch in touches {
            Interface.setTouchEnd(x: Float(touch.location(in: self).x))
            Interface.setTouchEndy(y: Float(touch.location(in: self).y))
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        Interface.setwasTouched(isT: true)
        Interface.setTouched(isT: false)
        for touch in touches {
            Interface.setTouchEnd(x: Float(touch.location(in: self).x))
            Interface.setTouchEndy(y: Float(touch.location(in: self).y))
        }

    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            Interface.setTouchEnd(x: Float(touch.location(in: self).x))
            Interface.setTouchEndy(y: Float(touch.location(in: self).y))
        }
    }
}
