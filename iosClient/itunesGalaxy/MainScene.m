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
#import "SongPlanetScene.h"
#import "iTunesCurrentNode.h"
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
    return label;
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
        
        NSArray *mediaTypes = @[@"Apps", @"Songs", @"TV Shows"];
        for (NSString *mediaType in mediaTypes) {
            DistantSuperCluster *distantCluster = [[DistantSuperCluster alloc] initWithScene:self];
            [distantCluster setSetClusterLabel:mediaType];
            [distantCluster setMediaType:mediaType];
            distantCluster.position = CGPointMake([Util randFloatFrom:50 to:self.frame.size.width-50],[Util randFloatFrom:50 to:self.frame.size.height-50]);
        }
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
                DistantSuperCluster *superCluster = (DistantSuperCluster *) node;
                NSString *name = [superCluster mediaType];
                SKScene * clusterScene = [[SuperClusterScene alloc] initWithSize:self.frame.size withParentScene:self mediaType:name];
                //                SKScene * clusterScene = [[SuperClusterScene alloc] initWithSize:self.frame.size withParent:self];
                clusterScene.scaleMode = SKSceneScaleModeAspectFill;

                [iTunesCurrentNode updateCurrentScene:clusterScene];
                [self.view presentScene:clusterScene];
                break;
            }
            node = node.parent;
            
        }
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
