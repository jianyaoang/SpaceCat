//
//  GamePlayScene.m
//  SpaceCat
//
//  Created by Jian Yao Ang on 7/19/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "GamePlayScene.h"
#import "MachineNode.h"
#import "SpaceCatNode.h"
#import "ProjectileNode.h"
#import "SpaceDogNode.h"
#import "GroundNode.h"
#import "Utils.h"
#import <AVFoundation/AVFoundation.h>
#import "HUDNode.h"

@interface GamePlayScene ()
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval timeSinceEnemyAdded;
@property (nonatomic) NSTimeInterval totalGameTime;
@property (nonatomic) NSInteger minSpeed;
@property (nonatomic) NSTimeInterval addEnemyTime;
@property (nonatomic) SKAction *damageSound;
@property (nonatomic) SKAction *explodeSound;
@property (nonatomic) SKAction *laserSound;
@property (nonatomic) AVAudioPlayer *backgroundMusic;
@end

@implementation GamePlayScene


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.lastUpdateTimeInterval = 1.5;
        self.timeSinceEnemyAdded = 0;
        self.totalGameTime = 0;
        self.addEnemyTime = 0;
        self.minSpeed = SpaceDogMinSpeed;
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
        
        //position the image to center. CGRectGetMidX&Y gets the center point
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        MachineNode *machine = [MachineNode machineAtPosition:CGPointMake(CGRectGetMidX(self.frame), 12)];
        [self addChild:machine];
        
        //setting spaceCat position relative to the position of machine
        SpaceCatNode *spaceCat = [SpaceCatNode spaceCatAtPosition:CGPointMake(machine.position.x, machine.position.y -2)];
        [self addChild:spaceCat];
        
        [self addSpaceDog];
        
        //real world gravity is -9.8 on y axis.
        //won't affect anything yet, as phyiscs needs to be added to specific nodes
        self.physicsWorld.gravity = CGVectorMake(0, -9.8);
        self.physicsWorld.contactDelegate = self;
        
        GroundNode *ground = [GroundNode groundWithSize:CGSizeMake(self.frame.size.width, 22)];        
        [self addChild:ground];
        
        [self setupSoundEffect];
        
        //-20 right below from the top
        HUDNode *hud = [HUDNode hudAtPosition:CGPointMake(0, self.frame.size.height - 20) frame:self.frame];
        [self addChild:hud];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    [self.backgroundMusic play];
}

-(void)setupSoundEffect
{
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"Gameplay" withExtension:@"mp3"];
    self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    self.backgroundMusic.numberOfLoops = -1;  // number of loops -1 = infinite
    [self.backgroundMusic prepareToPlay];
    
    self.laserSound = [SKAction playSoundFileNamed:@"Laser.caf" waitForCompletion:NO];
    self.damageSound = [SKAction playSoundFileNamed:@"Damage.caf" waitForCompletion:NO];
    self.explodeSound = [SKAction playSoundFileNamed:@"Explode.caf" waitForCompletion:NO];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        CGPoint position = [touch locationInNode:self];
        [self shootProjectileTowardsPosition: position];
    }
}

-(void) shootProjectileTowardsPosition:(CGPoint)position
{
    SpaceCatNode *spaceCate = (SpaceCatNode*)[self childNodeWithName:@"SpaceCat"];
    [spaceCate performTap];
    
    MachineNode *machine = (MachineNode*)[self childNodeWithName:@"Machine"];
    
//    ProjectileNode *projectile = [ProjectileNode projectileAtPosition:position];
    
    //setting the beginning point of the projectile at the top of the machine
    ProjectileNode *projectile = [ProjectileNode projectileAtPosition:CGPointMake(machine.position.x, machine.position.y + machine.frame.size.height - 15)];
    [self addChild:projectile];
    //projectile executes animation movement upon touch
    [projectile moveTowardsPosition:position];
    
    [self runAction:self.laserSound];
}

-(void)addSpaceDog
{
//    SpaceDogNode *spaceDogA = [SpaceDogNode spaceDogOfType:SpaceDogTypeA];
//    spaceDogA.position = CGPointMake(100, 300);
//    [self addChild:spaceDogA];
//    
//    SpaceDogNode *spaceDogB = [SpaceDogNode spaceDogOfType:SpaceDogTypeB];
//    spaceDogB.position = CGPointMake(200, 300);
//    [self addChild:spaceDogB];
    
    //max is not inclusive
    //SpaceDogTypeA = 0 , SpaceDogTypeB = 1
    NSUInteger randomSpaceDog = [Utils randomWithMin:0 max:2];
    
    //generate random spaceDogs TypeA or B
    SpaceDogNode *spaceDog = [SpaceDogNode spaceDogOfType:randomSpaceDog];
    
    //to enable spaceDogs appearing in game at different speed
    float velocityY = [Utils randomWithMin:SpaceDogMinSpeed max:SpaceDogMaxSpeed];
    spaceDog.physicsBody.velocity = CGVectorMake(0, velocityY);
    
    
    //placing the spaceDog offscreen
    float positionY = self.frame.size.height + spaceDog.size.height;
    float positionX = [Utils randomWithMin:10+spaceDog.size.width max:self.frame.size.width-spaceDog.size.width-10];
    spaceDog.position = CGPointMake(positionX, positionY);
    [self addChild:spaceDog];
}

-(void)update:(NSTimeInterval)currentTime
{
    if (self.lastUpdateTimeInterval)
    {
        self.timeSinceEnemyAdded += currentTime - self.lastUpdateTimeInterval;
        self.totalGameTime += currentTime - self.lastUpdateTimeInterval;
    }
    
    if (self.timeSinceEnemyAdded > self.addEnemyTime)
    {
        [self addSpaceDog];
        self.timeSinceEnemyAdded = 0;
    }
    
    self.lastUpdateTimeInterval = currentTime;
    
    if (self.totalGameTime > 480) //8minutes
    {
        self.minSpeed = -160;
        self.addEnemyTime = 0.50;
    }
    else if (self.totalGameTime > 240) //4 minutes
    {
        self.minSpeed = -150;
        self.addEnemyTime = 0.65;
    }
    else if (self.totalGameTime > 20) //20sec
    {
        self.minSpeed = -125;
        self.addEnemyTime = 0.75;
    }
    else if (self.totalGameTime > 10) // 10 sec
    {
        self.minSpeed = -100;
        self.addEnemyTime = 1.00;
    }
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody;
    SKPhysicsBody *secondBody;
    
    //ensure that body A is the enemy
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (firstBody.categoryBitMask == CollisionCategoryEnemy &&
        secondBody.categoryBitMask == CollisionCategoryProjectile)
    {
        NSLog(@"Shot!!");
        
        SpaceDogNode *spaceDog = (SpaceDogNode*)firstBody.node;
        ProjectileNode *projectile = (ProjectileNode*)secondBody.node;
        
        [self addPoints:PointsPerHit];
        
        //when it collides, remove it from game
        [spaceDog removeFromParent];
        [projectile removeFromParent];
        
        [self runAction:self.explodeSound];
    }
    else if (firstBody.categoryBitMask == CollisionCategoryEnemy &&
             secondBody.categoryBitMask == CollisionCategoryGround)
    {
        NSLog(@"Hit the ground");
        
        SpaceDogNode *spaceDog = (SpaceDogNode*)firstBody.node;
        [spaceDog removeFromParent];
        [self runAction:self.damageSound];
        
        [self loseLife];
    }
    [self createDebrisAtPosition:contact.contactPoint];
}

-(void)createDebrisAtPosition:(CGPoint)position
{
    NSInteger numberOfPieces = [Utils randomWithMin:5 max:20];
    
    for (int i = 0; i < numberOfPieces; i++)
    {
        NSInteger randomPiece = [Utils randomWithMin:1 max:4];
        NSString *imageName = [NSString stringWithFormat:@"debri_%d",randomPiece];
        
        SKSpriteNode *debris = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        debris.position = position;
        [self addChild:debris];
        
        debris.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:debris.frame.size];
        debris.physicsBody.categoryBitMask = CollisionCategoryDebris;
        debris.physicsBody.contactTestBitMask = 0;
        debris.physicsBody.collisionBitMask = CollisionCategoryGround | CollisionCategoryDebris;
        debris.name = @"Debris";
        
        debris.physicsBody.velocity = CGVectorMake([Utils randomWithMin:-150 max:150],
                                                   [Utils randomWithMin:150 max:350]);
    
        [debris runAction:[SKAction waitForDuration:2.0] completion:^{
            [debris removeFromParent];
        }];
        
        NSString *explosionFilePath = [[NSBundle mainBundle] pathForResource:@"Explosion" ofType:@"sks"];
        SKEmitterNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:explosionFilePath];
        explosion.position = position;
        [self addChild:explosion];
        
        [explosion runAction:[SKAction waitForDuration:0.2] completion:^{
            [explosion removeFromParent];
        }];
    }
}

-(void)addPoints:(NSInteger)points
{
    HUDNode *hud = (HUDNode*)[self childNodeWithName:@"HUD"];
    [hud addPoints:points];
}

-(void)loseLife
{
    HUDNode *hud = (HUDNode*)[self childNodeWithName:@"HUD"];
    [hud loseLife];
}


@end
