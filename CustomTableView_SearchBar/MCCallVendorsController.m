//
//  MCCallVendorsController.m
//  moveCHECK
//
//  Created by Roshan Sequeira on 26/05/16.
//  Copyright © 2016 Saltmines-Mac2. All rights reserved.
//

#import "MCCallVendorsController.h"
#import "MCCallVendorVendorCell.h"
#import "MCCallVendorVendorModel.h"
#import "MCCallVendorTaskCell.h"
#import "MCCallVendorTaskModel.h"
#import "Utility.h"
//#import "MCNetworkManager.h"
#import "MCVendorsListController.h"

NSString *const filterTaskConstant = @"%K CONTAINS[c] %@";
NSString *const vendorCell = @"vendorCell";
NSString *const viewMore = @"viewMore";
NSString *const taskSectionCell = @"taskSectionCell";
NSString *const placeholderText = @"Search:moving, packing";
NSString *const vendorsListControllerName = @"MCVendorsListController";

typedef enum
{
    MCVendorTypeFrom,
    MCVendorTypeTo
}MCVendorType;

@interface MCCallVendorsController ()<UITableViewDataSource,UITableViewDelegate,MCCallVendorTaskCellProtocol , MCCallVendorVendorCellProtocol,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (nonatomic, strong) NSMutableArray *fromModelArray;
@property (nonatomic, strong) NSMutableArray *toModelArray;
@property (nonatomic, strong) NSArray *modelArray;
@property (nonatomic, assign) MCVendorType vendorType;

@property (weak, nonatomic) IBOutlet UITableView *taskVendorsTableView;


@end

@implementation MCCallVendorsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.activityIndicator startAnimating];
    self.navigationController.navigationBarHidden = YES;
    self.vendorType = MCVendorTypeFrom;
    [self loadModels];
    UIColor *color = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    self.searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderText attributes:@{NSForegroundColorAttributeName: color}];
    
    
    CGFloat r1 = CGRectGetHeight(self.viewForSwitch.bounds) / 2.0;
    self.viewForSwitch.layer.cornerRadius = r1;
    
    ZJSwitch *switchMoveFromTo = [[ZJSwitch alloc] initWithFrame:CGRectMake(2, 2, self.viewForSwitch.frame.size.width - 4, self.viewForSwitch.frame.size.height - 4)];
    switchMoveFromTo.on = NO;
    switchMoveFromTo.backgroundColor = [UIColor clearColor];
    switchMoveFromTo.onTintColor = [UIColor colorWithRed:37/255.0 green:81/255.0 blue:92/255.0 alpha:1];
    switchMoveFromTo.offTintColor = [UIColor colorWithRed:37/255.0 green:81/255.0 blue:92/255.0 alpha:1];
    switchMoveFromTo.textColor = [UIColor blackColor];
    switchMoveFromTo.onText = @"Moving To";
    switchMoveFromTo.offText = @"Moving From";
    //switch2.textFont = @"";
    [switchMoveFromTo setOnTextFontSize:7];
    [switchMoveFromTo setOffTextFontSize:7];
    [switchMoveFromTo addTarget:self action:@selector(switchStateChanged:) forControlEvents:UIControlEventValueChanged];
    [self.viewForSwitch addSubview:switchMoveFromTo];
 

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    //sample data
    
    // Dispose of any resources that can be recreated.
}

- (void)loadModels
{
    
    NSDictionary *dictionary = @{
                                 @"moveTo": @"11111",
                                 @"moveFrom":@"22222"
                                 };
    
//    [[MCNetworkManager sharedNetworkManager] getVendorsList:dictionary withCompletionBlock:^(NSDictionary *response, NSError *error) {
//        NSLog(@"Response");
//        NSArray *moveFromArray = response[@"result"][@"move_from"][@"tasks"];
//        NSArray *moveToArray = response[@"result"][@"move_to"][@"tasks"];
//        self.fromModelArray = [NSMutableArray array];
//        self.toModelArray = [NSMutableArray array];
//        [self generateVendorsModelsForArray:moveFromArray moveIntoArray:self.fromModelArray];
//        [self generateVendorsModelsForArray:moveToArray moveIntoArray:self.toModelArray];
//        self.modelArray = (self.vendorType == MCVendorTypeFrom) ? self.fromModelArray : self.toModelArray;
//        [self.taskVendorsTableView reloadData];
//        [self.activityIndicator stopAnimating];
//        self.activityIndicator.hidden = YES;
//    }];
    
    
    
    self.arrayJson = [Utility parseStatesResponseFileName:@"Json_File" FileType:@"json"];
    NSLog(@"%@",self.arrayJson);
    
    NSDictionary *response = (NSDictionary *)self.arrayJson;
    
    NSArray *moveFromArray = response[@"result"][@"move_from"][@"tasks"];
            NSArray *moveToArray = response[@"result"][@"move_to"][@"tasks"];
            self.fromModelArray = [NSMutableArray array];
            self.toModelArray = [NSMutableArray array];
            [self generateVendorsModelsForArray:moveFromArray moveIntoArray:self.fromModelArray];
            [self generateVendorsModelsForArray:moveToArray moveIntoArray:self.toModelArray];
            self.modelArray = (self.vendorType == MCVendorTypeFrom) ? self.fromModelArray : self.toModelArray;
            [self.taskVendorsTableView reloadData];
            [self.activityIndicator stopAnimating];
            self.activityIndicator.hidden = YES;
}
     
     
- (void)generateVendorsModelsForArray:(NSArray *)array moveIntoArray:(NSMutableArray *)movingArray
{
         for(NSDictionary *taskWithVedorsList in array)
         {
             MCCallVendorTaskModel *model = [[MCCallVendorTaskModel alloc] init];
             //set task and vendors list details
             [model setDataFromDictionary:taskWithVedorsList];
             model.expanded = NO;
             [movingArray addObject:model];
         }
}
- (IBAction)switchStateChanged:(id)sender
{
    UISwitch *toFromswitch = (UISwitch *)sender;
    self.vendorType  = (toFromswitch.isOn) ? MCVendorTypeFrom : MCVendorTypeTo;
    [self filterTasks:self.searchTextField.text];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MCCallVendorTaskModel *taskModel = self.modelArray[section];
    NSInteger rows = (taskModel.expanded) ? ((taskModel.vendorsArray.count > 5) ? 6 : taskModel.vendorsArray.count) : 0;
    return rows;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = vendorCell;
    MCCallVendorTaskModel *model = self.modelArray[indexPath.section];
    NSArray *vendorsArray = model.vendorsArray;
    if(indexPath.row > 4 && vendorsArray.count > 5)
    {
        identifier = viewMore;
    }
    MCCallVendorVendorCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.delegate = self;
    cell.section = indexPath.section;
    cell.model = vendorsArray[indexPath.row];
    
    if([identifier isEqualToString:vendorCell])
    {
        //check if last cell and vendor cell
        if((indexPath.row == vendorsArray.count-1))
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIBezierPath *maskPath;
                maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds
                                                 byRoundingCorners:(UIRectCornerBottomRight|UIRectCornerBottomLeft)
                                                       cornerRadii:CGSizeMake(5.0, 5.0)];
                
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.path = maskPath.CGPath;
                maskLayer.frame = cell.bounds;
                cell.layer.mask = maskLayer;
                cell.separator.hidden = YES;
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIBezierPath *maskPath;
                maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds
                                                 byRoundingCorners:(UIRectCornerBottomRight|UIRectCornerBottomLeft)
                                                       cornerRadii:CGSizeMake(0.0, 0.0)];
                
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.path = maskPath.CGPath;
                maskLayer.frame = cell.bounds;
                cell.layer.mask = maskLayer;
                if((indexPath.row > 3 && vendorsArray.count > 5))
                {
                    cell.separator.hidden = YES;
                }
                else
                {
                    cell.separator.hidden = NO;
                }
            });
        }
       
    }
    else if ([identifier isEqualToString:viewMore])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIBezierPath *maskPath;
            maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds
                                             byRoundingCorners:(UIRectCornerBottomRight|UIRectCornerBottomLeft)
                                                   cornerRadii:CGSizeMake(5.0, 5.0)];
            
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.path = maskPath.CGPath;
            maskLayer.frame = cell.bounds;
            cell.layer.mask = maskLayer;
        });
    }
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.modelArray.count;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MCCallVendorTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:taskSectionCell];
    cell.delegate = self;
    cell.model = self.modelArray[section];
    dispatch_async(dispatch_get_main_queue(), ^{
        UIBezierPath *maskPath;
        maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds
                                         byRoundingCorners:(UIRectCornerTopRight|UIRectCornerTopLeft)
                                               cornerRadii:CGSizeMake(5.0, 5.0)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.path = maskPath.CGPath;
        maskLayer.frame = cell.bounds;
        cell.layer.mask = maskLayer;
    });
    return cell;
}


- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}


-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    return  view;
}

#pragma mark - Task cell delegates -
- (void)expandCell:(MCCallVendorTaskCell *)cell
{
    for(int i=0; i< self.modelArray.count ; i++)
    {
        MCCallVendorTaskModel *model = self.modelArray[i];
        if(model != cell.model)
        {
            model.expanded = NO;
        }
    }
    cell.model.expanded = !(cell.model.expanded);
    [self.taskVendorsTableView reloadData];
}

#pragma  mark - Vendor cell delegates -
- (void)tappedViewMore:(MCCallVendorVendorCell *)cell
{
    //push a new controller
    MCVendorsListController *vendorsListController = [[UIStoryboard storyboardWithName:vendorsListControllerName bundle:nil] instantiateInitialViewController];
    //pass the selected vendors list,this a a parcular vendor cell, but we need to get list of the vendors for that section
    vendorsListController.model = self.modelArray[cell.section];
    [self.navigationController pushViewController:vendorsListController animated:YES];
}

- (void)tappedCallVendor:(MCCallVendorVendorCell *)cell
{
    //call the vendor
    [Utility makeCall:cell.model.vendorPhone];
}
- (IBAction)searchTasks:(id)sender
{
    NSString *textToSearch = ((UITextField *)sender).text ;
    [self filterTasks:textToSearch];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)filterTasks:(NSString *)filterText
{
    NSLog(@"%@",filterText);
    if(filterText.length)
    {
        NSArray *taskVendorArray = (self.vendorType == MCVendorTypeFrom) ? self.fromModelArray : self.toModelArray;
        NSString* filter =  filterTaskConstant;
        NSPredicate* predicate = [NSPredicate predicateWithFormat:filter, @"taskName",filterText];
        NSArray* filteredData = [taskVendorArray filteredArrayUsingPredicate:predicate];
        //filtered Data
        self.modelArray = filteredData;
        NSLog(@"Filtered Data");
        [self.taskVendorsTableView reloadData];
    }
    else
    {
        self.modelArray = (self.vendorType == MCVendorTypeFrom) ? self.fromModelArray : self.toModelArray;
        [self.taskVendorsTableView reloadData];
    }
}
- (IBAction)tapGesture:(id)sender
{
    [self.view endEditing:YES];
}




@end
