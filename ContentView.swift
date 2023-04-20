import SwiftUI
import SpriteKit

struct ContentView: View {
    var scene = Scene1(size: CGSize(width: 800, height: 1200))
    var body: some View {
        SpriteView(scene: scene).ignoresSafeArea()
    
    }
}

class Scene1: SKScene, SKPhysicsContactDelegate{
    //declare global variable
    var player = SKSpriteNode()
    var controllerInput: CGVector = .zero
    var imgWelcome = SKSpriteNode()
    var bgGuidelines = SKSpriteNode()
    var buttonOk = SKSpriteNode()
    var backgroundLabel = SKSpriteNode()
    var backgroundSuccess = SKSpriteNode()
    var label = SKLabelNode()
    var foundItem: Int = 0
    var tissueTag = SKSpriteNode(imageNamed: "tissueTag")
    var kniveTag = SKSpriteNode(imageNamed: "kniveTag")
    var stickTag = SKSpriteNode(imageNamed: "stickTag")
    var tissue = SKSpriteNode(imageNamed: "tissue")
    var cane = SKSpriteNode(imageNamed: "cane")
    var knive = SKSpriteNode(imageNamed: "knive")
    var puddle = SKSpriteNode(imageNamed: "puddle")
    override func didMove(to view: SKView){
        // deklare background
        let backgroundColor = SKColor(red: 0.97, green: 0.95, blue: 0.9, alpha: 1.0)
        self.backgroundColor = backgroundColor
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
                
        physicsWorld.contactDelegate = self
        //disable gravity
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        // for setting duration first page
        let durationWelcome = SKAction.wait(forDuration: 2.0)
        let removeAction = SKAction.removeFromParent()
        let sequence = SKAction.sequence([durationWelcome, removeAction])
        
        // welcome page
        welcomePage()
        // set duration welcome page
        imgWelcome.run(sequence)
        // show guidelines
        guidelines()
        
        // add object 
        addObject(imgName: "wallUp", name: "wall")
        addObject(imgName: "wallRight", name: "wall")
        addObject(imgName: "wallLeft", name: "wall")
        addObject(imgName: "wallDown", name: "wall")
        addObject(imgName: "wall1", name: "wall")
        addObject(imgName: "wall2", name: "wall")
        addObject(imgName: "wall3", name: "wall")
        addObject(imgName: "wall4", name: "wall")
        addObject(imgName: "wall5", name: "wall")
        addObject(imgName: "wall6", name: "wall")
        addObject(imgName: "wall7", name: "wall")
        addObject(imgName: "wall8", name: "wall")
        addObject(imgName: "wall9", name: "wall")
        addObject(imgName: "westafle", name: "westafle")
        addBakMandi()
        addObject(imgName: "toilet",name: "toilet")
//        addObject(imgName: "sofa",name: "sofa")
        addObject(imgName: "table",name: "table")
        addObject(imgName: "desk",name: "desk")
        addObject(imgName: "cupboard",name: "cupboard")
//        addObject(imgName: "bed",name: "bed")
//        addObject(imgName: "tableLamp",name: "tableLamp")
        addObject(imgName: "kitchenTable",name: "kitchenTable")
         addObject(imgName: "refridgerator",name: "refridgerator")
        addObject(imgName: "diningTable",name: "diningTable")
        addObject(imgName: "chair",name: "chair")
        addObject(imgName: "sofaTv",name: "sofaTv")
        addObject(imgName: "tableTv",name: "tableTv")
        addObject(imgName: "cupboard1",name: "cupboard")
//        addObject(imgName: "bed1",name: "bed")
        addObject(imgName: "title",name: "title")
        objectTag(objTag: tissueTag)
        objectTag(objTag: kniveTag)
        objectTag(objTag: stickTag)
        addFinding(obj: tissue, name: "tissue")
        addFinding(obj: puddle, name: "puddle")
        addFinding(obj: cane, name: "cane")
        addFinding(obj: knive, name: "knive")
        addFloor()
        // avatar for player
        avatar()

        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        // action button Ok in guidelines
        if node.name == "okGuidelines"{
            bgGuidelines.removeFromParent()
            buttonOk.removeFromParent()
            displayMap()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var location = touch.location(in: self)
        // deklare condition when avatar move
        if backgroundSuccess.parent == nil{
            // condition avatar move when avatar is touched
            if player.contains(location){
                if location.y > self.size.height / 1.2 {
                    location.y = self.size.height / 1.2
                }
                
                player.position = location
            }
        }
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        // deklare for the collision
        if contact.bodyA.node?.name == "avatar"{
            collision(beetwen: contact.bodyA.node!, object: contact.bodyB.node!)
        }
        else if contact.bodyB.node?.name == "avatar"{
            collision(beetwen: contact.bodyB.node!, object: contact.bodyA.node!)
        }
        
    }
    
    func collision(beetwen player: SKNode, object: SKNode){
        //remove label modal
        if backgroundLabel.parent != nil || label.parent != nil  {
            backgroundLabel.removeFromParent()
            label.removeFromParent()
        }
        // action when avatar collision with other object
        if object.name == "wall"{
            modalInformation(information: "You hitting the wall")
        } else if object.name == "westafle"{
            modalInformation(information: "You hitting the westafle")
        } else if object.name == "bathtub"{
            modalInformation(information: "You hitting the bathtub")
        } else if object.name == "toilet"{
            modalInformation(information: "You hitting the toilet")
        } else if object.name == "sofa"{
            modalInformation(information: "You hitting the sofa")
        } else if object.name == "table"{
            modalInformation(information: "You hitting the table")
        } else if object.name == "desk"{
            modalInformation(information: "You hitting the desk")
        } else if object.name == "cupboard"{
            modalInformation(information: "You hitting the cupboard")
        } else if object.name == "bed"{
            modalInformation(information: "You hitting the bed")
        } else if object.name == "sofaTv"{
            modalInformation(information: "You hitting the sofa")
        } else if object.name == "tableTv"{
            modalInformation(information: "You hitting the TV table")
        } else if object.name == "chair"{
            modalInformation(information: "You hitting the chair")
        } else if object.name == "diningTable"{
            modalInformation(information: "You hitting the dinning table")
        } else if object.name == "refridgerator"{
            modalInformation(information: "You hitting the refridgerator")
        } else if object.name == "kitchenTable"{
            modalInformation(information: "You hitting the kitchen table")
        } 
        // condition where object is found
        if object.name == "tissue"{
            successInformation(information: "You found the tissue")
            tissueTag.removeFromParent()
            tissue.removeFromParent()
            
        } 
        if object.name == "cane"{
            successInformation(information: "You found the blind stick")
            stickTag.removeFromParent()
            cane.removeFromParent()
        }
        if object.name == "knive"{
            successInformation(information: "You found the knive")
            kniveTag.removeFromParent()
            knive.removeFromParent()
        }
        
        if object.name == "puddle"{
            successInformation(information: "You slipped in bathroom")
            puddle.removeFromParent()
        }
        // show recap page when all object is found
        if tissueTag.parent == nil && kniveTag.parent == nil && stickTag.parent == nil {
            displayRecap()
        }
        
    }
    
    // function to setting avatar
    func avatar(){
        player = SKSpriteNode(imageNamed: "avatar")
        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        player.position = CGPoint(x: 400, y: 0)
        player.size = CGSizeMake(127, 190)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = player.physicsBody?.collisionBitMask ?? 0
        player.setScale(0.2)
        player.name = "avatar"
        self.addChild(player)
    }
    
    // for black page
    func addFloor(){
        let floor = SKSpriteNode(color: SKColor.black, size: CGSizeMake(frame.size.width, frame.size.height/1.14))
        floor.anchorPoint = CGPointMake(0,0)
        floor.position = CGPoint(x:0, y:0)
        addChild(floor)
    }
    
    func addBakMandi(){
        let bakMandi = SKSpriteNode(imageNamed: "bathtub")
        bakMandi.anchorPoint = CGPointMake(0.5,0.5)
        bakMandi.position = CGPoint(x:90, y:848)
        bakMandi.size = CGSizeMake(127, 190)
        bakMandi.physicsBody = SKPhysicsBody(texture: bakMandi.texture!, size: bakMandi.size)
        bakMandi.physicsBody?.isDynamic = false
        bakMandi.name = "bathtub"
        addChild(bakMandi)
    }
    // function to add all object
    func addObject(imgName: String, name: String){
        let object = SKSpriteNode(imageNamed: imgName)
        object.anchorPoint = CGPointMake(0.5,0.5)
        object.position = CGPoint(x: frame.midX, y: frame.midY)
        object.size = CGSizeMake(frame.size.width, frame.size.height)
        object.physicsBody = SKPhysicsBody(texture: object.texture!, size: object.size)
        object.physicsBody?.isDynamic = false
        object.name = name
        addChild(object)
    }
    
    func addFinding(obj: SKSpriteNode, name: String){
        obj.anchorPoint = CGPointMake(0.5,0.5)
        obj.position = CGPoint(x: frame.midX, y: frame.midY)
        obj.size = CGSizeMake(frame.size.width, frame.size.height)
        obj.physicsBody = SKPhysicsBody(texture: obj.texture!, size: obj.size)
        obj.physicsBody?.isDynamic = false
        obj.name = name
        addChild(obj)
    }
    func objectTag(objTag: SKSpriteNode){
        objTag.anchorPoint = CGPointMake(0.5,0.5)
        objTag.position = CGPoint(x: frame.midX, y: frame.midY)
        objTag.size = CGSizeMake(frame.size.width, frame.size.height)
        addChild(objTag)
    }
    
    func displayMap(){
        let backgroundMap = SKSpriteNode(imageNamed: "map")
        backgroundMap.anchorPoint = CGPointMake(0.5,0.5)
        backgroundMap.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundMap.zPosition = 1
        backgroundMap.size = self.size
        backgroundMap.name = "map"
        addChild(backgroundMap)
        let durationMap = SKAction.wait(forDuration: 10.0)
        let removeAction = SKAction.removeFromParent()
        let sequence = SKAction.sequence([durationMap, removeAction])
        backgroundMap.run(sequence)
    }
    
    func displayRecap(){
        let gameRecap = SKSpriteNode(imageNamed: "recap")
        gameRecap.anchorPoint = CGPointMake(0.5,0.5)
        gameRecap.position = CGPoint(x: frame.midX, y: frame.midY)
        gameRecap.zPosition = 1
        gameRecap.size = self.size
        gameRecap.name = "recap"
        addChild(gameRecap)
    }
    
    func welcomePage(){
        imgWelcome = SKSpriteNode(imageNamed: "welcomePage")
        imgWelcome.anchorPoint = CGPointMake(0.5,0.5)
        imgWelcome.position = CGPoint(x: frame.midX, y: frame.midY)
        imgWelcome.size = self.size
        imgWelcome.zPosition = 4
        addChild(imgWelcome)
    }
    
    func guidelines(){
        bgGuidelines = SKSpriteNode(imageNamed: "Guidelines")
        bgGuidelines.anchorPoint = CGPointMake(0.5,0.5)
        bgGuidelines.position = CGPoint(x: frame.midX, y: frame.midY)
        bgGuidelines.zPosition = 2
        bgGuidelines.size = self.size
        buttonOk = SKSpriteNode(imageNamed: "buttonOk")
        buttonOk.position = CGPoint(x: self.size.width/2, y: 200)
        buttonOk.size = CGSizeMake(130, 170) 
        buttonOk.name = "okGuidelines"
        buttonOk.zPosition = 3
        addChild(buttonOk)
        addChild(bgGuidelines)
    }
    
    func modalInformation(information: String){
        label = SKLabelNode(fontNamed: "Helvetica")
        label.text = information
        label.fontSize = 24
        label.fontColor = .blue
        backgroundLabel = SKSpriteNode(color: .white, size: CGSize(width: 300, height: 50))
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundLabel.position = CGPoint(x: size.width/2, y: size.height/2)
        label.zPosition=1
        if backgroundSuccess.parent == nil {
            addChild(label)
            addChild(backgroundLabel)
        }
        
        let durationLabel = SKAction.wait(forDuration: 1.0)
        let removeAction = SKAction.removeFromParent()
        let sequence = SKAction.sequence([durationLabel, removeAction])
        backgroundLabel.run(sequence)
        label.run(sequence)
    }
    
    func successInformation(information: String){
        let label = SKLabelNode(fontNamed: "Helvetica")
        label.text = information
        label.fontSize = 24
        label.fontColor = .red
        backgroundSuccess = SKSpriteNode(color: .white, size: CGSize(width: 300, height: 50))
        backgroundSuccess.position = CGPoint(x: size.width/2, y: size.height/2)
        label.zPosition=1
        backgroundSuccess.addChild(label)
        addChild(backgroundSuccess)
        
        let durationLabel = SKAction.wait(forDuration: 1.0)
        let removeAction = SKAction.removeFromParent()
        let sequence = SKAction.sequence([durationLabel, removeAction])
        backgroundSuccess.run(sequence)
        label.run(sequence)
    }
    
}
