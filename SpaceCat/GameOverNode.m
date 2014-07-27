//
//  GameOverNode.m
//  SpaceCat
//
//  Created by Jian Yao Ang on 7/27/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "GameOverNode.h"

@implementation GameOverNode

+(instancetype)gameOverAtPosition:(CGPoint)position
{
    GameOverNode *gameOver = [self node];
    
    SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    gameOverLabel.name = @"GameOver";
    gameOverLabel.text = @"Game Over";
    gameOverLabel.fontSize = 50;
    gameOverLabel.position = position;
    [gameOver addChild:gameOverLabel];
    
    return gameOver;
}

-(void)performAnimation
{
    SKLabelNode *label = (SKLabelNode*)[self childNodeWithName:@"GameOver"];
    label.xScale = 0;
    label.yScale = 0;
    
    SKAction *scaleUp = [SKAction scaleTo:1.2f duration:0.75f];
    SKAction *scaleDown = [SKAction scaleTo:0.9f duration:0.25f];
    SKAction *run = [SKAction runBlock:^{
        SKLabelNode *touchToRestart = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
        touchToRestart.text = @"Touch To Restart";
        touchToRestart.fontSize = 25;
        touchToRestart.position = CGPointMake(label.position.x, label.position.y - 50);
        [self addChild:touchToRestart];
    }];
    
    SKAction *scale = [SKAction sequence:@[scaleUp,scaleDown, run]];
    [label runAction:scale];
}


@end
