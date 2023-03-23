//
//  MatrixMath.swift
//  MandelbrotZoom
//
//  Created by Walt Semrau on 2/18/23.
//

import Foundation
import simd

func toRadians(degrees: Float)->Float{
    return degrees / 180 * .pi
}

func toDegrees(radians: Float)->Float{
    return radians * 180 / .pi
}

extension Float{
    
    var radiansToDegrees: Float{
        return toDegrees(radians: self)
    }
    
    var DegreestoRadians: Float{
        return toRadians(degrees: self)
    }
}
extension matrix_float4x4{
    init(translationX x: Float, y: Float, z: Float){
        self.init()
        columns = (
        [1,0,0,0],
        [0,1,0,0],
        [0,0,1,0],
        [x,y,z,1])
    }
    
    func translatedBy(x: Float, y: Float, z: Float, next:Bool)->matrix_float4x4{
        let translateMatrix = matrix_float4x4(translationX: x, y: y, z: z)
        if(next){
            return matrix_multiply(translateMatrix, self)
        }
        return matrix_multiply(self, translateMatrix)
    }
    init(scaleX x: Float, y: Float, z: Float){
        self.init()
        columns = (
        [x,0,0,0],
        [0,y,0,0],
        [0,0,z,0],
        [0,0,0,1])
    }
    func ScaleBy(x: Float, y: Float, z: Float, next: Bool)->matrix_float4x4{
        let scaleMatrix = matrix_float4x4(scaleX: x, y: y, z: z)
        if(next){
            return matrix_multiply(scaleMatrix, self)
        }
        return matrix_multiply(self, scaleMatrix)
    }
    init(rotateX theta: Float){
        self.init()
        columns = (
        [1,0,0,0],
        [0,cos(theta),-sin(theta),0],
        [0,sin(theta),cos(theta),0],
        [0,0,0,1])
    }
    func RotateByX(theta: Float, next: Bool)->matrix_float4x4{
        let rotateMatrix = matrix_float4x4(rotateX: theta)
        if(next){
            return matrix_multiply(rotateMatrix, self)
        }
        return matrix_multiply(self, rotateMatrix)
    }
    
    init(rotateZ theta: Float){
        self.init()
        columns = (
        [cos(theta),-sin(theta),0,0],
        [sin(theta),cos(theta),0,0],
        [0,0,1,0],
        [0,0,0,1])
    }
    func RotateByZ(theta: Float, next: Bool)->matrix_float4x4{
        let rotateMatrix = matrix_float4x4(rotateZ: theta)
        if(next){
            return matrix_multiply(rotateMatrix, self)
        }
        return matrix_multiply(self, rotateMatrix)
    }
    
    init(rotateY theta: Float){
        self.init()
        columns = (
        [cos(theta),0,sin(theta),0],
        [0,1,0,0],
        [-sin(theta),0,cos(theta),0],
        [0,0,0,1])
    }
    func RotateByY(theta: Float, next: Bool)->matrix_float4x4{
        let rotateMatrix = matrix_float4x4(rotateY: theta)
        if(next){
            return matrix_multiply(rotateMatrix, self)
        }
        return matrix_multiply(self, rotateMatrix)
    }
    init(projectionFov theta: Float, front: Float, back: Float){
        self.init()
        columns = (
        [1/tan(theta),0,0,0],
        [0,1/tan(theta),0,0],
        [0,0,back/(back - front),1],
        [0,0,back*front/(front-back),0])
    }
    
    
    
    
}
