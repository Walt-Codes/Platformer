//
//  Types.swift
//  MandelbrotZoom
//
//  Created by Walt Semrau on 2/18/23.
//

import Foundation
import MetalKit
import simd

struct Vertex{
    var position: SIMD3<Float>
    var color: SIMD4<Float>
    var texture: SIMD2<Float>
}

struct ModelConstants{
    var parentViewMatrix = matrix_identity_float4x4
    var modelViewMatrix =  matrix_identity_float4x4
}

enum Colors{
    static let weirdGreen = MTLClearColor(red: 0.0, green: 0.4, blue: 0.21, alpha: 1.0)
    static let white = MTLClearColor(red: 1, green: 1, blue: 1, alpha: 1)
    static let black = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 1)
    static let skyblue = MTLClearColor(red: 0.527, green: 0.805, blue: 0.917, alpha: 1)
}


