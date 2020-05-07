//
//  CannasView.swift
//  freeland
//
//  Created by VoMinhTuanIOS on 4/13/20.
//  Copyright © 2020 VoMinhTuanIOS. All rights reserved.
//

import UIKit


class CanvasView: UIView {

    //public function
    fileprivate var strokeColor = UIColor.white
    fileprivate var strokeWidth:Float = 5
    
    func setStrokeColor(color:UIColor){
        self.strokeColor = color
    }
    
    func setStrokeWidth(width :Float) {
        self.strokeWidth  = width
    }
    func clear(){
        lines.removeAll()
        setNeedsDisplay()
    }
    
    var lines = [Line]()
    
    override func draw(_ rect: CGRect) {
        //custom drawing
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else
        { return }
        //here are my line
        //dummy data
        let showdow = CGSize(width: 0, height: 2)
        let blur : CGFloat = 5
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            context.setLineCap(.round)
            context.setBlendMode(.screen)
            context.setLineJoin(.round)
            context.setShadow(offset: showdow, blur: blur, color: line.color.cgColor)
            context.drawPath(using: .stroke)
            context.fillPath(using: .evenOdd)
            for (i,p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
         
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points:[]))
    }
    // track the finger as wemove across screen
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else {return}
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
}
