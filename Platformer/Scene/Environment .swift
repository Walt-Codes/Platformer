//
//  environment .swift
//  Platformer
//
//  Created by Walt Semrau on 3/12/23.
//

import Foundation
import MetalKit

class Envirionment{
    
    var platforms: [[Platform]]
    var averageHeight: Float = 0.0
    
    init(device: MTLDevice){
        platforms = [[Platform]].init(repeating: [Platform].init(repeating: Platform(device: device), count: 10), count: 10)
    }
    
    func newfirstRow(){
        for platform in platforms[0] {
            let factor = Float.random(in: -0.5...2.5)
            let delta = averageHeight - platform.position.y
            platform.addTranslation(x: 0, y: delta*factor, z: 0, next: false)
            averageHeight += delta*factor/100
            
        }
    }
    
        
    
    
}

