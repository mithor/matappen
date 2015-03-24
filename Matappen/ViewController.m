//
//  ViewController.m
//  Matappen
//
//  Created by IT-Högskolan on 2015-02-22.
//  Copyright (c) 2015 IT-Högskolan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) UIGravityBehavior *gravity;
@property (nonatomic) UICollisionBehavior *collision;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.gravity = [[UIGravityBehavior alloc] initWithItems:@[self.image]];
    self.gravity.gravityDirection = CGVectorMake(10, -2);
    [self.animator addBehavior:self.gravity];
    self.collision = [[UICollisionBehavior alloc] initWithItems:@[self.titleLabel, self.image]];
    self.collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:self.collision];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidLayoutSubviews {

    [UIView animateWithDuration:1 delay:1 options:kNilOptions animations:^{
        self.searchButton.center = CGPointMake(self.view.frame.size.width+20, self.searchButton.center.y);
    }completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
