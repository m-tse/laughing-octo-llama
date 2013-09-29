//
//  iTunesRoot.m
//  itunesGalaxy
//
//  Created by Andrew Shim on 9/29/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "iTunesCurrentNode.h"
#import "DistantSuperCluster.h"
#import "Util.h"
#import "SuperClusterScene.h"

@implementation iTunesCurrentNode

static SKScene *currentScene;
static SKScene *previousScene;

+(void) setCurrentScene:(SKScene *)scene {
    currentScene = scene;
}

+(SKScene *) getCurrentScene {
    return currentScene;
}

+(void) updateCurrentScene:(SKScene *)scene {
    previousScene = currentScene;
    currentScene = scene;
    
}

+(void) setPreviousScene:(SKScene *)scene {
    previousScene = scene;
}

+(SKScene *) getPreviousScene {
    return previousScene;
}



@end
