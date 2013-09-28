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
#import "Galaxy.h"
#import "TestScene.h"
#import "Util.h"

@implementation MainScene


NSInteger NUM_GALAXIES = 5;
float RANDOM_MOTION_IMPLUSE = 0.3;

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
    galaxySpawner.name = @"BM_rotating_galaxy";
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

        
        self.backgroundColor = [SKColor colorWithRed:0.05 green:0.05 blue:0.20 alpha:1.0];
        self.physicsWorld.gravity = CGVectorMake(0, 0);


        
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
        
        

//        [self addChild:distantCluster];
        

        

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
        if([[node name] isEqual:@"BM_distantSuperCluster"]){
            SKScene * clusterScene = [[SuperClusterScene alloc] initWithSize:self.frame.size];
            clusterScene.scaleMode = SKSceneScaleModeAspectFill;
            
            // Present the scene.
            [self.scene.view presentScene:clusterScene];
            break;
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
    
    //Apply browniwn Motion
    [self enumerateChildNodesWithName:@"//BM_distantSuperCluster" usingBlock:^(SKNode *node, BOOL *stop) {
        CGFloat xImpulse = skRand(-RANDOM_MOTION_IMPLUSE,RANDOM_MOTION_IMPLUSE);
        CGFloat yImpulse = skRand(-RANDOM_MOTION_IMPLUSE, RANDOM_MOTION_IMPLUSE);
        if(node.position.x<50){
            xImpulse = (CGFloat) RANDOM_MOTION_IMPLUSE;
        }
        if(node.position.x>self.scene.size.width-50){
            xImpulse = (CGFloat) -RANDOM_MOTION_IMPLUSE;
        }
        if(node.position.y<50){
            yImpulse = (CGFloat) RANDOM_MOTION_IMPLUSE;
        }
        if(node.position.y>self.scene.size.height-50){
            yImpulse = (CGFloat) -RANDOM_MOTION_IMPLUSE;
        }
        
        [node.physicsBody applyImpulse:CGVectorMake(xImpulse,yImpulse)];
    }];


  
    /* Called before each frame is rendered */
}

@end
