//
//  TableViewCell.h
//  Matappen
//
//  Created by IT-Högskolan on 2015-02-23.
//  Copyright (c) 2015 IT-Högskolan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;

@end
