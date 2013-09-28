//
//  Util.h
//  itunesGalaxy
//
//  Created by Matthew on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject
//+ (CGFloat) skRandf;
+ (CGFloat) randFloatFrom:(CGFloat)low to:(CGFloat)high;
+ (int) randIntFrom:(int)low to:(int)high;
@end
