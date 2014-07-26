//
//  Utils.m
//  SpaceCat
//
//  Created by Jian Yao Ang on 7/20/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(NSInteger)randomWithMin:(NSInteger)min max:(NSInteger)max;
{
    return arc4random()%(max-min) + min;
}



@end
