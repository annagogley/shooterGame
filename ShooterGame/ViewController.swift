//
//  ViewController.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 13.09.2023.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    let gameSet = ShooterSettings.sharedInstance
    var player = AVAudioPlayer()
    let gunSoundURL =  Bundle.main.url(forResource: "art.scnassets/gun", withExtension: "mp3")!
    let blowSoundURL =  Bundle.main.url(forResource: "art.scnassets/blow", withExtension: "mp3")!

    private var shotCount: Int = 0
    private var userScore: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                self.scoreLabel.text = String(self.userScore)
            }
        }
    }
    
    var timer = Timer()
    private var counter = 3
    private var timeRemaining = 60
    
    //MARK: UI elements
    private let crossImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "cross"))
        image.contentMode = .scaleAspectFit
        image.image = image.image?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .white
        return image
    }()
    
    private var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Your score"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private var countdownLabel: UILabel = {
        let label = UILabel()
        label.text = "3"
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private var timeRemainingLabel: UILabel = {
        let label = UILabel()
        label.text = "60"
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    private var shootButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        button.setTitle("Tap", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 45
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.scene.physicsWorld.contactDelegate = self
        
        shootButton.addTarget(self, action: #selector(shootButtonTapped), for: .touchUpInside)
        setUpView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.delegate = self
        sceneView.session.run(configuration)
        countdown()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}

//MARK: Views
extension ViewController {
    
    private func setUpView() {
        view.addSubview(countdownLabel)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: { [self] in
            countdownLabel.isHidden = true
            view.addSubview(crossImage)
            view.addSubview(scoreLabel)
            view.addSubview(shootButton)
            view.addSubview(timeRemainingLabel)
        })
    }
    
    private func setUpSubviews() {
        let frame = view.frame
        countdownLabel.frame = CGRect(x: frame.width / 2 - 25, y: frame.height / 2 - 25, width: 50, height: 50)
        crossImage.frame = CGRect(x: frame.width / 2 - 25, y: frame.height / 2 - 25, width: 50, height: 50)
        shootButton.frame = CGRect(x: frame.width - 120, y: frame.height - 170, width: 100, height: 100)
        scoreLabel.frame = CGRect(x: 20, y: 100, width: frame.width - 40, height: 100)
        timeRemainingLabel.frame = CGRect(x: 20, y: 40, width: 60, height: 40)
    }
    
    @objc private func shootButtonTapped() {
        guard gameSet.state == .InGame else {
            beginPlaying()
            return
        }
        shotCount += 1
        let bulletsNode = Bullet()
        playSound(gunSoundURL)
        
        let (direction, position) = self.getUserVector()
        bulletsNode.position = position
        let bulletDirection = direction
        
        let impulseVector = SCNVector3(
            x: bulletDirection.x * Float(20),
            y: bulletDirection.y * Float(20),
            z: bulletDirection.z * Float(20)
        )
        
        bulletsNode.physicsBody?.applyForce(impulseVector, asImpulse: true)
        sceneView.scene.rootNode.addChildNode(bulletsNode)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            bulletsNode.removeFromParentNode()
        })
    }
}

//MARK: playing elements
extension ViewController {
    
    func beginPlaying() {
        gameSet.state = .InGame
        self.userScore = 0
        self.shotCount = 0
        self.counter = 3
        self.timeRemaining = 60
        self.countdown()
        self.addSphere()
    }
    
    func addSphere() {
        let node = Sphere()
        let posX = floatBetween(-0.5, and: 0.5)
        let posY = floatBetween(-0.5, and: 0.5)
        let posZ = -2
        node.position = SCNVector3(posX, posY, Float(posZ))
        sceneView.scene.rootNode.addChildNode(node)
        gameSet.targets.append(node)
    }
    
    func getUserVector() -> (SCNVector3, SCNVector3) {
        if let frame = self.sceneView.session.currentFrame {
            let mat = SCNMatrix4(frame.camera.transform)
            let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33)
            let pos = SCNVector3(mat.m41, mat.m42, mat.m43)
            return (dir, pos)
        }
        return (SCNVector3Zero, SCNVector3Zero)
    }
    
    func floatBetween(_ first: Float,  and second: Float) -> Float {
        return (Float(arc4random()) / Float(UInt32.max)) * (first - second) + second
    }
    
    func removeNode(_ node: SCNNode) {
        if node is Sphere {
            //make explosion
            let scene = SCNScene(named: "art.scnassets/particles.scn")
            let explosionNode = (scene?.rootNode.childNode(withName: "particles", recursively: true)!)!
            
            explosionNode.position = node.presentation.position
            sceneView.scene.rootNode.addChildNode(explosionNode)
            playSound(blowSoundURL)
            
            if let sphere = node as? Sphere
            {
                if let index = gameSet.targets.firstIndex(of: sphere)
                {
                    gameSet.targets.remove(at: index)
                }
            }
        }
        node.removeFromParentNode()
    }
    
    func endPlaying() {
        DispatchQueue.main.async {
            self.scoreLabel.text = "You've earned \(self.userScore) points. \n You've made \(self.shotCount) shots. \n Tap to continue."
            self.sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
                node.removeFromParentNode()
            }
            self.shootButton.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                self.shootButton.isEnabled = true
            })
        }
        gameSet.state = .Start
    }
}

extension ViewController: SCNPhysicsContactDelegate, ARSessionDelegate {
    //bullet + sphere contact
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        if (contact.nodeA.physicsBody?.categoryBitMask == CollisionCategory.target.rawValue && contact.nodeB.physicsBody?.categoryBitMask == CollisionCategory.bullets.rawValue) {
            self.removeNode(contact.nodeB)
            self.removeNode(contact.nodeA)
            self.userScore += 1
            self.addSphere()
        }
    }
}

//MARK: timer + player services
extension ViewController {
    
    func playSound(_ url: URL){
        do {
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: nil)
            player.prepareToPlay()
            player.play()
        } catch {
            print("there is no sound")
        }
    }
    
    func countdown() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if gameSet.state == .Start {
            if counter > 0 {
                counter -= 1
            } else {
                timer.invalidate()
                beginPlaying()
            }
            countdownLabel.text = String(counter)
        } else {
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.invalidate()
                endPlaying()
            }
            timeRemainingLabel.text = String(timeRemaining)
        }
    }
}
