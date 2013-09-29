//
//  Label.m
//  itunesGalaxy
//
//  Created by Matthew on 9/29/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "Label.h"

NSString *DEFAULT_FONT = @"BebasNeueu";

@implementation Label
//-(id)initLabelNodewithFontSize:(int)fontSize onNode:(SKNode*) node inScene:(SKScene*) scene {
//    [super ]
//    self.fontName=DEFAULT_FONT;
//    self.name = @"label";
//    self.fontSize = fontSize;
//    self.verticalAlignmentMode=SKLabelVerticalAlignmentModeCenter;
//    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10,10)];
//    [node addChild:self];
//    
//    
//    SKPhysicsJointFixed *spring = [SKPhysicsJointFixed jointWithBodyA:self.physicsBody bodyB:node.physicsBody anchor:CGPointMake(0,0)];
////    spring.frequency = 0.1;
////    spring.damping = 50;
//    [scene.physicsWorld addJoint:spring];
//
//    
//    return self;
//}
-(id)initWithFontSize:(int)fontSize onNode:(SKNode*) node inScene:(SKScene*) scene {
    if(self = [super init]){
        self.fontName = DEFAULT_FONT;
        self.name = @"label_name";
        self.text = @"Apps";
        self.fontSize = 30;
        SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
        self.physicsBody = physicsBody;
        [node addChild:self];
        SKPhysicsJointFixed *spring = [SKPhysicsJointFixed jointWithBodyA:self.physicsBody bodyB:node.physicsBody anchor:CGPointMake(0,0)];
        [scene.physicsWorld addJoint:spring];
        
    }
    return self;
}
@end
