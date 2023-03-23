//
//  GameScene.swift
//  Platformer
//
//  Created by Walt Semrau on 3/12/23.
//

import MetalKit
class GameScene: Scene{
    var player: Cube
    var yvelocity: Float = 0
    var xVelocity: Float = 0
    var ypos: Float = 0
    let gravity: Float = -100
    var isjumping = false;
    var platforms: [Platform] = []
    var trajectory: [Cube] = []
    var score = 0
    
    override init(device: MTLDevice) {
        
        player = Cube(device: device)
        
        super.init(device: device)
        
        for i in 0...3{
            trajectory.append(Cube(device: device))
            player.children.append(trajectory[i])
            trajectory[i].setColor(color: [1,1,1,0.1/(Float(i)+1)])
            trajectory[i].addScale(x: 0, y: 0, z: 0, next: false)
        }
        player.addTranslation(x: 0, y: 0, z: 10, next: false)
        player.addScale(x: 0.25, y: 0.25, z: 0.25, next: false)
        add(childNode: player)
        for i in 0...4 {
            platforms.append(Platform(device: device))
            add(childNode: platforms[i])
            platforms[i].placeRight()
            platforms[i].addTranslation(x: Float(-i*5), y: 0, z: 0, next: false)
        }
        root.addPerspective(FOV: .pi/4, front: 0.1, back: 50)
        root.addTranslation(x: 0, y: -4, z: 0, next: false)
        
        
    }
    override func update(commandEncoder: MTLRenderCommandEncoder, fps: Float) {
        if(!isjumping){
            if(Interface.getTouched()){
                yvelocity = pow(abs(Interface.getDragDeltay())/13,1.5)
                xVelocity = pow(abs(Interface.getDragDeltax())/13,1.5)
                for state in trajectory.enumerated(){
                    state.element.reset()
                    let time = Float(state.offset)/7
                    state.element.addTranslation(x: time*xVelocity*4, y: (gravity*time*time)/2+yvelocity*time, z: 0, next: false)
                    state.element.addScale(x: 0.5, y: 0.5, z: 0.5, next: false)
                }
            }
            if(Interface.getWasTouched()){
                for state in trajectory{
                    state.addScale(x: 0, y: 0, z: 0, next: false)
                }
                Interface.setwasTouched(isT: false)
                isjumping = true
                
            }
        }
        
        if(isjumping){
            Interface.setwasTouched(isT: false)
            for platform in platforms{
                platform.addTranslation(x: -xVelocity/fps, y: 0, z: 0, next: false)
                if(platform.position.x < -15){platform.placeRight()}
                if(platform.position.x > 15){platform.placeLeft()}
                
            }
            player.addTranslation(x: 0, y: yvelocity/fps, z: 0, next: false)
            yvelocity += gravity/fps
            if(yvelocity<0){
                for platform in platforms{
                    if(player.position.y+yvelocity/fps <= platform.position.y + 2 && player.position.y>platform.position.y+2){
                        if(player.position.x>=platform.position.x-1.2 && player.position.x <= platform.position.x+1.2){
                            xVelocity = 0
                            yvelocity = 0
                            isjumping = false
                            score += 1
                            
                        }
                    }
                    
                }
            }
        }
        
        
        if(player.position.y <= -30){
            player.addTranslation(x: 0, y: 40, z: 0, next: false)
            isjumping = false
            score = 0
            
            
        }
        
        super.update(commandEncoder: commandEncoder, fps: fps)
    }
}

