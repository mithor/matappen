//
//  TableViewController.m
//  Matappen
//
//  Created by IT-Högskolan on 2015-02-23.
//  Copyright (c) 2015 IT-Högskolan. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "DetailViewController.h"

@interface TableViewController ()

@property (nonatomic) NSArray *items;
@property (nonatomic) NSArray *searchResult;
@property (nonatomic) int currentItem;

@end

@implementation TableViewController

- (NSArray*)items {
    if (!_items) {
        _items = @[@{@"name" : @"Laddar lista..."}];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSURL *url = [NSURL URLWithString:@"http://matapi.se/foodstuff"];
    //temporarily using local file here
    NSURL *url = [[NSBundle mainBundle] URLForResource: @"foodstuff" withExtension:@"txt"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      NSError *parseError;
                                      NSArray *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                      options:kNilOptions error:&parseError];
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          
                                          self.items = [json sortedArrayUsingComparator:(NSComparator)^(NSDictionary *a, NSDictionary *b)
                                          {
                                              NSString *s1 = [a objectForKey: @"name"];
                                              NSString *s2 = [b objectForKey: @"name"];
                                              
                                              return [s1 localizedCaseInsensitiveCompare: s2];
                                          }
                                          ];
                                          [self.tableView reloadData];
                                      }); }];
    [task resume];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if(tableView==self.tableView) {
        return self.items.count;
    } else {
        return self.searchResult.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 74;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *a;
    NSString *cellId = @"";
    
    if (tableView == self.tableView) {
        a = self.items;
        cellId = @"MyCell";
    } else {
        a = self.searchResult;
        cellId = @"MySearchCell";
    }
    
    TableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    //cell.textLabel.text = self.items[indexPath.row];
    cell.mainLabel.text = a[indexPath.row][@"name"];
    cell.subLabel.text = [NSString stringWithFormat:@"Databasnummer %@",a[indexPath.row][@"number"]];
    
    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K contains[cd] %@", @"name", searchText];
    
    self.searchResult = [self.items filteredArrayUsingPredicate:predicate];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentItem = indexPath.row;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"Detail"]) {
        
        DetailViewController *detailView = [segue destinationViewController];
        TableViewCell *cell = sender;
        
        detailView.item = self.items[self.currentItem];
                
        detailView.title = cell.mainLabel.text;
        
    }
    else if ([segue.identifier isEqualToString:@"SearchDetail"]) {
        
        DetailViewController *detailView = [segue destinationViewController];
        TableViewCell *cell = sender;
        
        detailView.item = self.searchResult[self.currentItem];
        
        detailView.title = cell.mainLabel.text;
        
    } else {
        NSLog(@"You forgot the segue %@", segue);
    }

}


@end
