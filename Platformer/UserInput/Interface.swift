//
//  Interface.swift
//  Platformer
//
//  Created by Walt Semrau on 3/12/23.
//

class Interface{
    private static var touchCount = 2
    private static var touches = [Bool].init(repeating: false, count: touchCount)
    private static var touchstartx: Float = 0.0
    private static var touchEndx: Float = 0.0
    private static var touchstarty: Float = 0.0
    private static var touchEndy: Float = 0.0
    private static var wasTouched = false
    private static var isTouched = false
    
    
    public static func setLeftTouch(){
        touches[0] = true
    }
    public static func setRightTouch(){
        touches[1] = true
    }
    public static func setNoLeftTouch(){
        touches[0] = false
    }
    public static func setNoRightTouch(){
        touches[1] = false
    }
    public static func isLeftTouch()->Bool{
        return touches[0]
    }
    public static func isRightTouch()->Bool{
        return touches[1]
    }
    public static func getDragDeltax()->Float{
        return touchEndx-touchstartx
    }
    public static func getDragDeltay()->Float{
        return touchEndy-touchstarty
    }
    public static func setTouchStart(x: Float){
        touchstartx = x
    }
    public static func setTouchEnd(x: Float){
        touchEndx = x
    }
    public static func setwasTouched(isT: Bool){
        wasTouched = isT
    }
    public static func getWasTouched()->Bool{
        return wasTouched
    }
    public static func setTouchStarty(y: Float){
        touchstarty = y
    }
    public static func setTouchEndy(y: Float){
        touchEndy = y
    }
    public static func setTouched(isT: Bool){
        isTouched = isT
    }
    public static func getTouched()->Bool{
        return isTouched
    }

    
}
