//
//  SolarSystemScene.m
//  itunesGalaxy
//
//  Created by Matthew on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "SolarSystemScene.h"
#import "ZoomedSolarSystem.h"

@implementation SolarSystemScene

-(id)initWithSize:(CGSize)size withParentScene:(SKScene*) parent{
    if (self = [super initWithSize:size]) {
        
        
        //        UIPinchGestureRecognizer* pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
        //        [self.view addGestureRecognizer:(pinchRecognizer)];
        //    self.backgroundColor = [SKColor colorWithRed:0.05 green:0.05 blue:0.60 alpha:1.0];
        
        SKNode* galaxy = [[ZoomedSolarSystem alloc] initWithScene:self];
        CGPoint position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        galaxy.position = position;
        
    }
    return self;
}
@end
