//
//  Utils.h
//  SpaceCat
//
//  Created by Jian Yao Ang on 7/20/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int ProjectileSpeed = 400;
static const int SpaceDogMinSpeed = -100;
static const int SpaceDogMaxSpeed = -50;
static const int MaxLives = 4;
static const int PointsPerHit = 10;

typedef NS_OPTIONS(NSUInteger, CollisionCategory)
{
    CollisionCategoryEnemy      = 1 << 0, //0000
    CollisionCategoryProjectile = 1 << 1, //0010
    CollisionCategoryDebris     = 1 << 2, //0100
    CollisionCategoryGround     = 1 << 3  //1000
};


@interface Utils : NSObject

+(NSInteger)randomWithMin:(NSInteger)min max:(NSInteger)max;


@end
