//
//  TitleScene.m
//  SpaceCat
//
//  Created by Jian Yao Ang on 7/19/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//


#import "TitleScene.h"
#import "GamePlayScene.h"
#import <AVFoundation/AVFoundation.h>

@interface TitleScene ()
@property (nonatomic) SKAction *pressStart;
@property (nonatomic) AVAudioPlayer *backgroundMusic;
@end

@implementation TitleScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"splash_1"];
        
        //position the image to center. CGRectGetMidX&Y gets the center point
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        self.pressStart = [SKAction playSoundFileNamed:@"PressStart.caf" waitForCompletion:NO];
        
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"StartScreen" withExtension:@"mp3"];
        self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        self.backgroundMusic.numberOfLoops = -1;  // number of loops -1 = infinite
        [self.backgroundMusic prepareToPlay];
    
    }
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    [self.backgroundMusic play];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self runAction:self.pressStart];
    [self.backgroundMusic stop];
    
    //displaying the scene full size
    GamePlayScene *gamePlayScene = [GamePlayScene sceneWithSize:self.frame.size];
    
    //when touch, fade the current screen and display gamePlayScene in 1.0s
    SKTransition *transition = [SKTransition fadeWithDuration:1.0];
    
    [self.view presentScene:gamePlayScene transition:transition];
}

@end
