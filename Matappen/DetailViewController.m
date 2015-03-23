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
@property (weak, nonatomic) IBOutlet UILabel *subLabel4;
@property (nonatomic) NSDictionary *nutrients;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainLabel.text = self.item[@"name"];
    self.subLabel1.text = [NSString stringWithFormat:@"Nyttighetsvärde: %d", 0];
    self.subLabel2.text = [NSString stringWithFormat:@"Energi: %d kcal", 0];
    self.subLabel3.text = [NSString stringWithFormat:@"Protein: %d g", 0];
    self.subLabel4.text = [NSString stringWithFormat:@"Fett: %d g", 0];
    
    NSString *string = [NSString stringWithFormat:@"http://matapi.se/foodstuff/%@", self.item[@"number"]];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      NSError *parseError;
                                      NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                      options:kNilOptions error:&parseError];
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          
                                          self.nutrients = json;
                                          
                                          self.subLabel1.text = [NSString stringWithFormat:@"Nyttighetsvärde: %d", [self.nutrients[@"nutrientValues"][@"water"] integerValue]+1*[self.nutrients[@"nutrientValues"][@"protein"] integerValue]+1*[self.nutrients[@"nutrientValues"][@"carbohydrates"] integerValue]+1];
                                          self.subLabel2.text = [NSString stringWithFormat:@"Energi: %@ kcal", self.nutrients[@"nutrientValues"][@"energyKcal"]];
                                          self.subLabel3.text = [NSString stringWithFormat:@"Protein: %@ g", self.nutrients[@"nutrientValues"][@"protein"]];
                                          self.subLabel4.text = [NSString stringWithFormat:@"Fett: %@ g", self.nutrients[@"nutrientValues"][@"fat"]];
                                      }); }];
    [task resume];
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
