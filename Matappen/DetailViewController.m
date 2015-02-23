//
//  DetailViewController.m
//  Matappen
//
//  Created by IT-Högskolan on 2015-02-23.
//  Copyright (c) 2015 IT-Högskolan. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel1;
@property (weak, nonatomic) IBOutlet UILabel *subLabel2;
@property (weak, nonatomic) IBOutlet UILabel *subLabel3;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainLabel.text = self.item;
    self.subLabel1.text = [NSString stringWithFormat:@"Energi: %d kcal", [self.item length]];
    self.subLabel2.text = [NSString stringWithFormat:@"Protein: %d g", [self.item length]*2];
    self.subLabel3.text = [NSString stringWithFormat:@"Fett: %d g", 20-[self.item length]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
