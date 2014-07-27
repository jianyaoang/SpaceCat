//
//  GameOverNode.h
//  SpaceCat
//
//  Created by Jian Yao Ang on 7/27/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameOverNode : SKNode

+(instancetype)gameOverAtPosition:(CGPoint)position;

-(void)performAnimation;

@end
