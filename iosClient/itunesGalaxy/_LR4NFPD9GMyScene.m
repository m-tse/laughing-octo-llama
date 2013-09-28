//
//  _LR4NFPD9GMyScene.m
//  itunesGalaxy
//
//  Created by Matthew on 9/26/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "_LR4NFPD9GMyScene.h"
#import "SuperClusterScene.h"
#import "DistantSuperCluster.h"
#import "Galaxy.h"
#import "TestScene.h"

@implementation _LR4NFPD9GMyScene


NSInteger NUM_GALAXIES = 1;

- (SKSpriteNode *)sun
{
    SKSpriteNode *body = [SKSpriteNode spriteNodeWithImageNamed:@"planet.png"];
    return body;
}

- (SKSpriteNode *)planet
{
    SKSpriteNode *body = [SKSpriteNode spriteNodeWithImageNamed:@"planet.png"];
    body.size = CGSizeMake(100, 100);
    body.position = CGPointMake(100,100);
    return body;
}

static inline CGFloat skRandf() {
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf() * (high - low) + low;
}


- (SKEmitterNode *)galaxy
{
    SKEmitterNode * galaxySpawner;
    NSString *galaxyPath = [[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"];
    galaxySpawner = [NSKeyedUnarchiver unarchiveObjectWithFile:galaxyPath];

    SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(100,100)];
    galaxySpawner.physicsBody = physBody;

    [physBody applyAngularImpulse:50];
    physBody.affectedByGravity = false;
    galaxySpawner.name = @"rotating_galaxy";
    return galaxySpawner;
}

- (SKLabelNode *)galaxyLabel
{
    SKLabelNode * label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    label.name = @"label_name";
    label.text = @"Apps";
    label.fontSize = 30;
    SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
    label.physicsBody = physicsBody;
    physicsBody.affectedByGravity = false;
    return label;
}

- (SKEmitterNode *)sunEmitter
{
    SKEmitterNode * galaxySpawner;
    NSString *galaxyPath = [[NSBundle mainBundle] pathForResource:@"Sun" ofType:@"sks"];
    galaxySpawner = [NSKeyedUnarchiver unarchiveObjectWithFile:galaxyPath];

    SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
    galaxySpawner.physicsBody = physBody;
    
    physBody.affectedByGravity = false;
    
    return galaxySpawner;
}

-(SKLabelNode *)createTestSceneButton {
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"TEST"];
    label.name = @"testScene";
    label.text = @"TEST";
    label.fontSize = 30;
    SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:2.0];
    label.physicsBody = physicsBody;
    physicsBody.affectedByGravity = false;
    return label;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.05 green:0.05 blue:0.20 alpha:1.0];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
//        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
//        myLabel.text = @"Hello, World!";
//        myLabel.fontSize = 30;
//        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
//                                       CGRectGetMidY(self.frame));
        
//        [self addChild:myLabel];
//        SKSpriteNode *spaceship = [self newSpaceship];
//        spaceship.position = CGPointMake(CGRectGetMidX(self.frame),
//                                         CGRectGetMidY(self.frame)-150);
//        [self addChild:spaceship];
        
//        SKSpriteNode *sun = [self sun];
//        sun.position = CGPointMake(CGRectGetMidX(self.frame),
//                                   CGRectGetMidY(self.frame));
//        [self addChild:sun];
        
//        SKSpriteNode *planet = [self planet];
//        planet.position = CGPointMake(CGRectGetMidX(self.frame)+150,
//                                   CGRectGetMidY(self.frame)+150);
//        SKPhysicsBody *planetPhysBody = [SKPhysicsBody bodyWithCircleOfRadius:5.0];
//        planetPhysBody.affectedByGravity = false;
//        planet.physicsBody = planetPhysBody;
////        [planetPhysBody applyAngularImpulse:1000.0];
//        [self addChild:planet];
//        [planetPhysBody applyAngularImpulse:1000.0];
//        SKEmitterNode *myGalaxy = [self galaxy];
//        myGalaxy.targetNode = planet;
//        [self addChild:myGalaxy];
        
//        SKEmitterNode *galaxySpawner;
//        
//        NSString *galaxyPath = [[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"];
//        galaxySpawner = [NSKeyedUnarchiver unarchiveObjectWithFile:galaxyPath];
//        galaxySpawner.position = CGPointMake(200, 200);
//        galaxySpawner.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:galaxySpawner.size];
        for(int i=0;i<NUM_GALAXIES;i++)
        {
            CGPoint position = CGPointMake(skRand(50, 900), skRand(50,900));
            SKEmitterNode *galaxySpawner = [self galaxy];
            galaxySpawner.position = position;
            [self addChild:galaxySpawner];
            SKLabelNode *galaxyLabel = [self galaxyLabel];
            galaxyLabel.position = CGPointMake(position.x, position.y-100);
            [self addChild:galaxyLabel];
            
            SKPhysicsJointLimit *fixedJoint = [SKPhysicsJointLimit jointWithBodyA:galaxySpawner.physicsBody bodyB:galaxyLabel.physicsBody anchorA:CGPointMake(0.5,0.5) anchorB:CGPointMake(0.5,0.5)];
            fixedJoint.maxLength = 100;
            [self.physicsWorld addJoint:fixedJoint];
//        [galaxySpawner.physicsBody applyAngularImpulse:-.5];
        }
        
        
        SKNode * supercluster = [[Galaxy alloc] Galaxy];
        supercluster.position = CGPointMake(500, 500);
        [self addChild:supercluster];
        
        SKLabelNode *testLabel = [self createTestSceneButton];
        testLabel.position = CGPointMake(400, 400);
        [self addChild:testLabel];
        
//        SKEmitterNode *sunEmitter = [self sunEmitter];
//        sunEmitter.position = CGPointMake(150 , 150);
//        [self addChild:sunEmitter];
//        NSLog(self.children);
        
//        SKPhysicsJointLimit* spring = [SKPhysicsJointLimit jointWithBodyA:galaxySpawner.physicsBody bodyB:sunEmitter.physicsBody anchorA:CGPointMake(600, 600) anchorB:CGPointMake(500, 500)];
//        spring.maxLength = 200;
//        [self.physicsWorld addJoint:spring];
//        [galaxySpawner.physicsBody applyForce:CGVectorMake(0, 100)];
//        [sunEmitter.physicsBody applyAngularImpulse:0.1];
//        [galaxySpawner.physicsBody applyAngularImpulse:0.1];
//        galaxySpawner.physicsBody.angularVelocity = 1;

//        [self addChild:spring];
        
//        SKAction *makeRocks = [SKAction sequence: @[
//                                                    [SKAction performSelector:@selector(addRock) onTarget:self],
//                                                    [SKAction waitForDuration:0.10 withRange:0.15]
//                                                    ]];
//        [self runAction: [SKAction repeatActionForever:makeRocks]];
    }
    return self;
}


-(void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < 0)
            [node removeFromParent];
    }];
}

- (void)didEvaluateActions {
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKPhysicsBody* body = [self.physicsWorld bodyAtPoint:location];
        SKNode * node = body.node;
        if([[node name] isEqual:@"rotating_galaxy"]){
            SKScene * clusterScene = [[SuperClusterScene alloc] initWithSize:self.frame.size];
            clusterScene.scaleMode = SKSceneScaleModeAspectFill;
            
            // Present the scene.
            [self.scene.view presentScene:clusterScene];

        }
        if ([[node name] isEqual:@"testScene"]) {
            SKScene *testScene = [[TestScene alloc] initWithSize:self.size];
            testScene.scaleMode = SKSceneScaleModeAspectFit;
            [self.scene.view presentScene:testScene transition:[SKTransition fadeWithDuration:1.0]];
            return;
        }
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

-(void)update:(CFTimeInterval)currentTime {
    [self enumerateChildNodesWithName:@"rotating_galaxy" usingBlock:^(SKNode *node, BOOL *stop) {
        CGFloat xImpulse = skRand(-0.5,0.5);
        CGFloat yImpulse = skRand(-0.5, 0.5);
        if(node.position.x<50){
            xImpulse = (CGFloat) 0.5;
        }
        if(node.position.x>self.scene.size.width){
            xImpulse = (CGFloat) -0.5;
        }
        if(node.position.y<50){
            yImpulse = (CGFloat) 0.5;
        }
        if(node.position.y>self.scene.size.height){
            yImpulse = (CGFloat) -0.5;
        }
        
        [node.physicsBody applyImpulse:CGVectorMake(xImpulse,yImpulse)];
    }];
//    for(SKNode* node in self.children)
//    {
//        NSLog(@"x:%f y:%f", node.position.x, node.position.y);
//        CGFloat xImpulse = skRand(-0.5,0.5);
//        CGFloat yImpulse = skRand(-0.5, 0.5);
//        if(node.position.x<0){
//            xImpulse = (CGFloat) 0.5;
//        }
//        if(node.position.x>self.scene.size.width){
//            xImpulse = (CGFloat) -0.5;
//        }
//        if(node.position.y<0){
//            yImpulse = (CGFloat) 0.5;
//        }
//        if(node.position.y>self.scene.size.height){
//            yImpulse = (CGFloat) -0.5;
//        }
//
//        [node.physicsBody applyImpulse:CGVectorMake(xImpulse,yImpulse)];
//        NSLog(@"%f,%f", xImpulse, yImpulse);
//        [node.physicsBody applyAngularImpulse:skRand(-0.001,0.001)];
//    }
  
    /* Called before each frame is rendered */
}

@end
