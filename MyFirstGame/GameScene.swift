//
//  GameScene.swift
//  MyFirstGame
//
//  Created by Сагын Акжолов on 17.02.2019.
//  Copyright © 2019 Сагын Акжолов. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var leftCar = SKSpriteNode()
    var rightCar = SKSpriteNode()
    
    var canMove = false
    var leftToMoveLeft = true
    var rightCarToMoveRight = true
    
    var leftCarAtRight = false
    var rightCarAtLeft = false
    var centerPoint : CGFloat!
    
    var leftCarMinimumX : CGFloat = -280
    var leftCarMaximumX : CGFloat = -100
    
    var rightCarMinimumX : CGFloat = 100
    var rightCarMaximumX : CGFloat = 280
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        setup()
        Timer.scheduledTimer(timeInterval: TimeInterval(0.1), target: self, selector: #selector(GameScene.createRoadStrip), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: TimeInterval(Helper().randomBetweenTwoNumbers(firstNUmber: 0, secondNumber: 1.8)), target: self, selector: #selector(GameScene.leftTrafic), userInfo: nil, repeats: true)
    }
    override func update(_ currentTime: TimeInterval) {
        if canMove{
            move(leftSlide: leftToMoveLeft)
            moveRightCar(rightSlide: rightCarToMoveRight)
        }
        showRoadStrip()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchLocation = touch.location(in: self)
            if touchLocation.x > centerPoint{
                if rightCarAtLeft{
                    rightCarAtLeft = false
                    rightCarToMoveRight = false
                }else{
                    rightCarAtLeft = true
                    rightCarToMoveRight = true
                }
            }else{
                if leftCarAtRight{
                    leftCarAtRight = false
                    leftToMoveLeft = false
                }else{
                    leftCarAtRight = true
                    leftToMoveLeft = true
                }
            }
            canMove = true
        }
    }
    func setup(){
        leftCar = self.childNode(withName: "leftCar") as! SKSpriteNode
        rightCar = self.childNode(withName: "rightCar") as! SKSpriteNode
        centerPoint = self.frame.size.width / self.frame.size.height
    }
    @objc func createRoadStrip(){
        let leftRoadStrip = SKShapeNode(rectOf: CGSize(width: 10, height: 40))
        leftRoadStrip.strokeColor = SKColor.white
        leftRoadStrip.fillColor = SKColor.white
        leftRoadStrip.alpha = 0.4
        leftRoadStrip.name = "leftRoadStrip"
        leftRoadStrip.zPosition = 10
        leftRoadStrip.position.x = -187.5
        leftRoadStrip.position.y = 700
        addChild(leftRoadStrip)
        
        let rightRoadStrip = SKShapeNode(rectOf: CGSize(width: 10, height: 40))
        rightRoadStrip.strokeColor = SKColor.white
        rightRoadStrip.fillColor = SKColor.white
        rightRoadStrip.alpha = 0.4
        rightRoadStrip.name = "rightRoadStrip"
        rightRoadStrip.zPosition = 10
        rightRoadStrip.position.x = 187.5
        rightRoadStrip.position.y = 700
        addChild(rightRoadStrip)
    }
    
    func showRoadStrip(){
        enumerateChildNodes(withName: "leftRoadStrip") { (roadStrip, stop) in
            let strip = roadStrip as! SKShapeNode
            strip.position.y -= 30
        }
        enumerateChildNodes(withName: "rightRoadStrip") { (roadStrip, stop) in
            let strip = roadStrip as! SKShapeNode
            strip.position.y -= 30
        }
        enumerateChildNodes(withName: "yellowCar") { (leftCar, stop) in
            let car = leftCar as! SKSpriteNode
            car.position.y -= 30
        }
        enumerateChildNodes(withName: "redCar") { (leftCar, stop) in
            let car = leftCar as! SKSpriteNode
            car.position.y -= 30
        }
    }
    
    func removeItems(){
        for child in children{
            if child.position.y < -self.size.height - 100{
                child.removeFromParent()
            }
        }
    }
    
    func move(leftSlide: Bool){
        if leftSlide{
            leftCar.position.x -= 20
            if leftCar.position.x < leftCarMinimumX{
                leftCar.position.x = leftCarMinimumX
            }
        }else{
            leftCar.position.x += 20
            if leftCar.position.x > leftCarMaximumX{
                leftCar.position.x = leftCarMaximumX
            }
        }
    }
    func moveRightCar(rightSlide: Bool){
        if rightSlide{
            rightCar.position.x += 20
            if rightCar.position.x > rightCarMaximumX{
             rightCar.position.x = rightCarMaximumX
            }
        }else{
            rightCar.position.x -= 20
            if rightCar.position.x < rightCarMinimumX{
                rightCar.position.x = rightCarMinimumX
            }
        }
    }
    @objc func leftTrafic(){
        let leftTraficItem : SKSpriteNode!
        let randomNumber = Helper().randomBetweenTwoNumbers(firstNUmber: 1, secondNumber: 8)
        
        switch Int(randomNumber) {
        case 1...4:
            leftTraficItem = SKSpriteNode(imageNamed: "yellowCar")
            leftTraficItem.name = "yellowCar"
            break
        case 5...8:
            leftTraficItem = SKSpriteNode(imageNamed: "yellowCar")
            leftTraficItem.name = "redCar"
            break
        default:
            leftTraficItem = SKSpriteNode(imageNamed: "yellowCar")
            leftTraficItem.name = "yellowCar"
        }
        leftTraficItem.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        leftTraficItem.zPosition = 10
        
        let randomNum = Helper().randomBetweenTwoNumbers(firstNUmber: 1, secondNumber: 10)
        switch Int(randomNum) {
        case 1...4:
            leftTraficItem.position.x = -280
        case 5...10:
            leftTraficItem.position.x = -100
        default:
            leftTraficItem.position.x = -280
        }
        leftTraficItem.position.y = 700
        addChild(leftTraficItem)
    }
}
