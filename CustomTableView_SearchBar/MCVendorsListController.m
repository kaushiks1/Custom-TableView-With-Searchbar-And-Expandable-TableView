//
//  MCVendorsListController.m
//  moveCHECK
//
//  Created by Roshan Sequeira on 30/05/16.
//  Copyright © 2016 Saltmines-Mac2. All rights reserved.
//

#import "MCVendorsListController.h"
#import "MCCallVendorVendorCell.h"
#import "Utility.h"

NSString *const vendorsFilterString =  @"%K CONTAINS[c] %@";
NSString *const vendorCellIdentifier = @"vendorCell";

@interface MCVendorsListController()<UITableViewDataSource, UITableViewDelegate , MCCallVendorVendorCellProtocol>
@property (weak, nonatomic) IBOutlet UITableView *vendorsTableView;
@property (nonatomic, strong) NSArray *modelsArray;

@end

@implementation MCVendorsListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self loadAllVendors];
}

- (void)loadAllVendors
{
    self.modelsArray = self.model.vendorsArray;
    [self.vendorsTableView reloadData];
}

- (IBAction)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCCallVendorVendorCell *cell = [tableView dequeueReusableCellWithIdentifier:vendorCellIdentifier];
    cell.model = self.modelsArray[indexPath.row];
    cell.delegate = self;
    return cell;
}


- (IBAction)searchVendors:(id)sender
{
    NSString *textToSearch = ((UITextField *)sender).text ;
    NSLog(@"%@",textToSearch);
    if(textToSearch.length)
    {
        NSArray *taskVendorArray = self.model.vendorsArray;
        NSString* filter = vendorsFilterString;
        NSPredicate* predicate = [NSPredicate predicateWithFormat:filter, @"vendorName",textToSearch];
        NSArray* filteredData = [taskVendorArray filteredArrayUsingPredicate:predicate];
        //filtered Data
        self.modelsArray = filteredData;
        NSLog(@"Filtered Data");
        [self.vendorsTableView reloadData];
    }
    else
    {
        self.modelsArray = self.model.vendorsArray;
        [self.vendorsTableView reloadData];
    }
}

#pragma mark - vendor cell delegates -
- (void)tappedCallVendor:(MCCallVendorVendorCell *)cell
{
    [Utility makeCall:cell.model.vendorPhone];
}

@end
