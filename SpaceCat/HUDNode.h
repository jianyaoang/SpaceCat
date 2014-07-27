//
//  HUDNode.h
//  SpaceCat
//
//  Created by Jian Yao Ang on 7/27/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface HUDNode : SKNode
@property (nonatomic) NSInteger lives;
@property (nonatomic) NSInteger score;

+(instancetype)hudAtPosition:(CGPoint)position frame:(CGRect)frame;
-(void)addPoints:(NSInteger)points;
-(BOOL)loseLife;

@end
