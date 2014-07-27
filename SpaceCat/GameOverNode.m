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
    gameOverLabel.text = @"GameOver";
    gameOverLabel.fontSize = 50;
    gameOverLabel.position = position;
    [gameOver addChild:gameOverLabel];
    
    return gameOver;
}


@end
