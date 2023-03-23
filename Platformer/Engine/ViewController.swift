//
//  ViewController.swift
//  Platformer
//
//  Created by Walt Semrau on 3/12/23.
//

import UIKit
import MetalKit



class ViewController: UIViewController {
    
    
    var metalView: MTKView {
        
        return view as! MTKView
    }
    
    var renderer: Renderer?

    override func viewDidLoad() {
        super.viewDidLoad()
        let device = MTLCreateSystemDefaultDevice()
        metalView.depthStencilPixelFormat = MTLPixelFormat.depth32Float
        metalView.clearColor = Colors.skyblue
        metalView.device = device
        renderer = Renderer(device: metalView.device!)
        metalView.delegate = renderer
        renderer?.scene = GameScene(device: metalView.device!)
        
        
        
        
        
        
        
    

        // Do any additional setup after loading the view.
    }
    
}


