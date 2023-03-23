//
//  Renderer.swift
//  MandelbrotZoom
//
//  Created by Walt Semrau on 2/13/23.
//  Do as little as a you can in this file. consider this the expensive gpu ground. setting up the states.
//  bugs here will really slow down your computer


import Foundation
import MetalKit

class Renderer: NSObject{
    
    public static var ScreenSize = SIMD2<Float>(0,0)
    
    var commandeQueue: MTLCommandQueue
    var device: MTLDevice
    
    var scene: Scene?
    
    var samplerState: MTLSamplerState?
    
    var depthStencilState: MTLDepthStencilState?
    var depthAttachment: MTLRenderPassDepthAttachmentDescriptor?
    
    init(device: MTLDevice) {
        self.device = device
        self.commandeQueue = device.makeCommandQueue()!
        super.init()
        buildSamplerState()
        buildStencilState()

    }
    
    private func buildStencilState(){
        let descriptor =  MTLDepthStencilDescriptor()
        descriptor.depthCompareFunction = .less
        descriptor.isDepthWriteEnabled = true
        depthStencilState = device.makeDepthStencilState(descriptor: descriptor)
    }
    
    private func buildSamplerState(){
        let descriptor = MTLSamplerDescriptor()
        descriptor.minFilter = .linear
        descriptor.magFilter = .linear
        samplerState = device.makeSamplerState(descriptor: descriptor)
    }
    
}
extension Renderer: MTKViewDelegate {
    public func updateScreenSize(view: MTKView){
        Renderer.ScreenSize = SIMD2<Float>(Float(view.bounds.width), Float(view.bounds.height))
    }
        
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        updateScreenSize(view: view)
    }
    
    func draw(in view: MTKView) {
        
        let commandBuffer = commandeQueue.makeCommandBuffer()
        
        guard let drawable = view.currentDrawable,
                      let descriptor = view.currentRenderPassDescriptor else{
                    return
                }
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: descriptor)
    
        commandEncoder?.setFragmentSamplerState(samplerState, index: 0)
        commandEncoder?.setDepthStencilState(depthStencilState)
        
        let framesPerSecond = view.preferredFramesPerSecond
        scene?.update(commandEncoder:commandEncoder!, fps: Float(framesPerSecond))
        
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
