//
//  Scene.swift
//  MandelbrotZoom
//
//  Created by Walt Semrau on 2/18/23.
//
//  The Scene controls the various objects you will be rendering on the screen.
//  It does not suggest an order of heirachy, "light->room->larger/brighter objects" but it does provide heirerarchy
//
//
import Foundation
import MetalKit

class Scene{
    
    var root: RootNode
    var commandEncoder: MTLRenderCommandEncoder?
    
    init(device: MTLDevice){
        root = RootNode()
    }
    
    func add(childNode: Renderable){
        root.children.append(childNode)
        childNode.parent = root
    }
    func update(commandEncoder: MTLRenderCommandEncoder, fps: Float){
        self.commandEncoder = commandEncoder
        
        for node in root.children{
            node.render(commandEncoder: commandEncoder)
        }
        
    }
}
