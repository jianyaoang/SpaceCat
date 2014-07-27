//
//  ProjectileNode.h
//  SpaceCat
//
//  Created by Jian Yao Ang on 7/19/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ProjectileNode : SKSpriteNode

+ (instancetype) projectileAtPosition:(CGPoint)position;
-(void)moveTowardsPosition:(CGPoint)position;
@end
