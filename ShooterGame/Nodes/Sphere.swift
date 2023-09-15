//
//  Sphere.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 13.09.2023.
//

import UIKit
import SceneKit

class Sphere: SCNNode {
    override init () {
        super.init()
        let sphere = SCNSphere(radius: 0.07)
        self.geometry = sphere
        let shape = SCNPhysicsShape(geometry: sphere, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        
        self.physicsBody?.categoryBitMask = CollisionCategory.target.rawValue
        self.physicsBody?.contactTestBitMask = CollisionCategory.bullets.rawValue
        
        self.geometry?.materials.first?.diffuse.contents = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
