import SpriteKit
import GameplayKit

enum Balls: String {
    case BlueBall = "ballBlue"
    case Cyan = "ballCyan"
    case Green = "ballGreen"
    case Grey = "ballGrey"
    case Purple = "ballPurple"
    case Red = "ballRed"
    case Yellow = "ballYellow"
    
    static let allValues = [BlueBall, Cyan, Green, Grey, Purple, Red, Yellow]
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var scoreLabel: SKLabelNode!
    var editLabel: SKLabelNode!
    var ballsLabel: SKLabelNode!
    
        var ballsArray = [String]()

    
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    
    var balls: Int = 5 {
        didSet {
            ballsLabel.text = "Lives: \(balls)"
        }
    }
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        // Initialize Colors Array
        for ball in Balls.allValues {
            ballsArray.append(ball.rawValue)
        }
        
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .Replace
        background.zPosition = -1
        addChild(background)
        
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)

        var i = 0
        for _ in 0 ... 4 {
            makeBouncerAt(CGPoint(x: i, y: 0))
            i += 256
        }
        var slot = 128
        var good = true
        
        for _ in 0..<4 {
            makeSlotAt(CGPoint(x: slot, y: 0), isGood: good )
            slot += 256
            good = !good
        }
        
        physicsWorld.contactDelegate = self

        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .Right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)

        ballsLabel = SKLabelNode(fontNamed: "Chalkduster")
        ballsLabel.text = "Balls: 0"
        ballsLabel.horizontalAlignmentMode = .Right
        ballsLabel.position = CGPoint(x: 980, y: 650)
        addChild(ballsLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        if let touch = touches.first {
            if(balls == 0){
                print("Game Over")
            } else {
                var location = touch.locationInNode(self)
                let objects = nodesAtPoint(location) as [SKNode]
                
                if objects.contains(editLabel) {
                    editingMode = !editingMode
                } else {
                    if editingMode {
                        if (objects.count > 0) {
                            for obj in objects {
                                if (obj.name == "box") {
                                    print("Hit a box in edit Mode")
                                    obj.removeFromParent()
                                    return
                                }
                            }
                        }
                        // create a box
                        let size = CGSize(width: GKRandomDistribution(lowestValue: 16, highestValue: 128).nextInt(), height: 16)
                        let box = SKSpriteNode(color: RandomColor(), size: size)
                        box.zRotation = RandomCGFloat(min: 0, max: 3)
                        box.position = location
                        
                        box.physicsBody = SKPhysicsBody(rectangleOfSize: box.size)
                        box.physicsBody!.dynamic = false
                        box.name = "box"
                        
                        addChild(box)
                    } else {
                        // create a ball
                        let ball = SKSpriteNode(imageNamed: generateRandomBall())
                        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
                        
                        ball.physicsBody!.restitution = 0.4 // This means bounciness
                        location.y = frame.size.height
                        ball.position = location
                        ball.name = "ball"
                        addChild(ball)
                    }
                }
            }
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    private func makeBouncerAt(position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody!.contactTestBitMask = bouncer.physicsBody!.collisionBitMask

        bouncer.physicsBody!.dynamic = false
        addChild(bouncer)
    }
    
    private func makeSlotAt(position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOfSize: slotBase.size)
        slotBase.physicsBody!.dynamic = false
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotateByAngle(CGFloat(-M_PI_2), duration: 2)
        let spinForever = SKAction.repeatActionForever(spin)
        slotGlow.runAction(spinForever)
    }
    
    private func collisionBetweenBall(ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroyBall(ball)
            balls += 1
            score += 1
        } else if object.name == "bad" {
            destroyBall(ball)
            balls -= 1
            score -= 1
        } else if object.name == "box" {
            destroyBox(object)
        }
    }
    
    private func destroyBall(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        
        ball.removeFromParent()
    }
    
    private func destroyBox(box: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = box.position
            addChild(fireParticles)
        }
        
        box.removeFromParent()
    }
    
    
    private func generateRandomBall() -> String {
        return ballsArray[GKRandomDistribution(lowestValue: 0, highestValue: ballsArray.count-1).nextInt()]
    }
    // MARK: Contact Delegate 
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.node!.name == "ball" {
            collisionBetweenBall(contact.bodyA.node!, object: contact.bodyB.node!)
        } else if contact.bodyB.node!.name == "ball" {
            collisionBetweenBall(contact.bodyB.node!, object: contact.bodyA.node!)
        }
    }
    
    
}