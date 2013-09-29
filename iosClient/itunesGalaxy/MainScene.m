//
//  _LR4NFPD9GMyScene.m
//  itunesGalaxy
//
//  Created by Matthew on 9/26/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "MainScene.h"
#import "SuperClusterScene.h"
#import "DistantSuperCluster.h"
#import "DistantGalaxy.h"
#import "Sun.h"
#import "Moon.h"
#import "Planet.h"
#import "TestScene.h"
#import "Util.h"

@implementation MainScene


NSInteger NUM_GALAXIES = 10;
float RANDOM_MOTION_IMPLUSE = 0.3;



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
    galaxySpawner.name = @"BM_rotating_galaxy";
    return galaxySpawner;
}

- (SKLabelNode *)galaxyLabel
{
    SKLabelNode * label = [SKLabelNode labelNodeWithFontNamed:@"BebasNeue"];
    label.name = @"label_name";
    label.text = @"Apps";
    label.fontSize = 30;
    SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
    label.physicsBody = physicsBody;
    physicsBody.affectedByGravity = false;
    return label;
}

//- (SKEmitterNode *)sunEmitter
//{
//    SKEmitterNode * galaxySpawner;
//    NSString *galaxyPath = [[NSBundle mainBundle] pathForResource:@"Sun" ofType:@"sks"];
//    galaxySpawner = [NSKeyedUnarchiver unarchiveObjectWithFile:galaxyPath];
//
//    SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
//    galaxySpawner.physicsBody = physBody;
//    
//    physBody.affectedByGravity = false;
//    
//    return galaxySpawner;
//}


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

        
        // Create supercluster
//        SKNode * supercluster = [[Galaxy alloc] init];
//        supercluster.position = CGPointMake(500, 500);
//        [self addChild:supercluster];
        
//        // Create sun
//        SKNode * sun = [[Sun alloc] init];
//        sun.position = CGPointMake(300, 300);
//        [self addChild:sun];
//        
//        // Create moon
//        SKNode * moon = [[Moon alloc] init];
//        moon.position = CGPointMake(500, 500);
//        [self addChild:moon];
//        
//        // Create planet
//        SKNode * planet = [[Planet alloc] init];
//        planet.position = CGPointMake(700, 700);
//        [self addChild:planet];
//        
//        // Create galaxy
//        SKNode * galaxy = [[DistantGalaxy alloc] init];
//        galaxy.position = CGPointMake(200, 600);
//        [self addChild:galaxy];
        
        for(int i=0;i<NUM_GALAXIES;i++)
        {
            SKNode * distantCluster = [[DistantSuperCluster alloc] initWithScene:self];
            distantCluster.position = CGPointMake([Util randFloatFrom:50 to:self.scene.frame.size.width-50],[Util randFloatFrom:50 to:self.scene.frame.size.height-50]);
//            CGPoint position = CGPointMake(skRand(50, 900), skRand(50,900));
//            SKEmitterNode *galaxySpawner = [self galaxy];
//            galaxySpawner.position = position;
//            [self addChild:galaxySpawner];
//            SKLabelNode *galaxyLabel = [self galaxyLabel];
//            galaxyLabel.position = CGPointMake(position.x, position.y-100);
//            [self addChild:galaxyLabel];
//            
//            SKPhysicsJointLimit *fixedJoint = [SKPhysicsJointLimit jointWithBodyA:galaxySpawner.physicsBody bodyB:galaxyLabel.physicsBody anchorA:CGPointMake(0.5,0.5) anchorB:CGPointMake(0.5,0.5)];
//            fixedJoint.maxLength = 100;
//            [self.physicsWorld addJoint:fixedJoint];
        }
        
        

        

        

//        SKLabelNode *testLabel = [self createTestSceneButton];
//        testLabel.position = CGPointMake(400, 400);
//        [self addChild:testLabel];
        
//        SKEmitterNode *sunEmitter = [self sunEmitter];
//        sunEmitter.position = CGPointMake(150 , 150);
//        [self addChild:sunEmitter];
//        NSLog(self.children);

        
        
    }
    return self;
}


-(void)didSimulatePhysics
{

}

- (void)didEvaluateActions {
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
        
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKPhysicsBody* body = [self.physicsWorld bodyAtPoint:location];
        SKNode * node = body.node;
        while(node != NULL){
            if([[node name] isEqual:@"BM_distantSuperCluster"]){
                SKScene * clusterScene = [[SuperClusterScene alloc] initWithSize:self.frame.size withParentScene:self];
//                SKScene * clusterScene = [[SuperClusterScene alloc] initWithSize:self.frame.size withParent:self];
                clusterScene.scaleMode = SKSceneScaleModeAspectFill;
                

                [self.scene.view presentScene:clusterScene];
                break;
            }
            node = node.parent;
            
        }


//        if ([[node name] isEqual:@"testScene"]) {
//            SKScene *testScene = [[TestScene alloc] initWithSize:self.size];
//            testScene.scaleMode = SKSceneScaleModeAspectFit;
//            [self.scene.view presentScene:testScene transition:[SKTransition fadeWithDuration:1.0]];
//            return;
//        }

    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

-(void)update:(CFTimeInterval)currentTime {
    
    [super update:currentTime];
    [self applyBrownianMotionInScene:self withNodeNames:@"BM_distantSuperCluster"];
    

  
    /* Called before each frame is rendered */
}

@end
