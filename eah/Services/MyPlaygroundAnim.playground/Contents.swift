
import UIKit
import PlaygroundSupport

let canvasView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = canvasView

let square = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
square.layer.anchorPoint = CGPoint(x: 0.75, y: 0.75)
square.backgroundColor = UIColor.blue

canvasView.addSubview(square)

print(square.layer.presentation()?.opacity)


//let animationMove = CABasicAnimation(keyPath: #keyPath(CALayer.position))
//animationMove.fromValue = CGPoint(x: square.layer.position.x - 50, y: square.layer.position.y)
//animationMove.toValue = CGPoint(x: square.layer.position.x + 50, y: square.layer.position.y)
//
//let animationMove1 = CABasicAnimation(keyPath: #keyPath(CALayer.position))
//animationMove1.fromValue = CGPoint(x: square.layer.position.x, y: square.layer.position.y - 50)
//animationMove1.toValue = CGPoint(x: square.layer.position.x, y: square.layer.position.y + 50)
//
//let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
//rotateAnimation.fromValue = -CGFloat(Double.pi / 10.0)
//rotateAnimation.toValue = CGFloat(Double.pi / 10.0)
//rotateAnimation.isRemovedOnCompletion = false
//rotateAnimation.repeatCount=Float.infinity
//
//let group = CAAnimationGroup()
//group.duration = 0.3
//group.repeatCount = .infinity
//group.autoreverses = true
//group.animations = [animationMove1]
//
////square.layer.add(group, forKey: nil)
//
//
//var iconCell: CAEmitterCell = {
//var iconCell = CAEmitterCell()
//    iconCell.contents = UIImage(systemName: "globe.americas")?.cgImage
//    iconCell.scale = 0.2
//    iconCell.emissionRange = .pi/4
//    iconCell.lifetime = 3
//    iconCell.birthRate = 6
//    iconCell.velocity = 60
//    iconCell.yAcceleration = 30
//    iconCell.xAcceleration = 5
//    iconCell.spin = -0.5
//    iconCell.spinRange = 1.0
//return iconCell
//}()
//
//func showIcon(into view: UIView) {
//    let iconLayer = CAEmitterLayer()
//    iconLayer.emitterPosition = CGPoint(x: 200, y: 200)
//    iconLayer.emitterShape = CAEmitterLayerEmitterShape.line
//    iconLayer.beginTime = CACurrentMediaTime()
//    iconLayer.timeOffset = CFTimeInterval(arc4random_uniform(6))
//    iconLayer.emitterCells = [iconCell]
//view.layer.addSublayer(iconLayer)
//}
//
//showIcon(into: canvasView)

