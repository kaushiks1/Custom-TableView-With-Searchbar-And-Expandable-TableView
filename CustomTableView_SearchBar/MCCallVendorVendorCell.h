//
//  MCCallVendorVendorCell.h
//  moveCHECK
//
//  Created by Roshan Sequeira on 27/05/16.
//  Copyright © 2016 Saltmines-Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCCallVendorVendorModel.h"

@class MCCallVendorVendorCell;

@protocol MCCallVendorVendorCellProtocol <NSObject>

- (void)tappedCallVendor:(MCCallVendorVendorCell *)cell;
@optional
- (void)tappedViewMore:(MCCallVendorVendorCell *)cell;

@end


@interface MCCallVendorVendorCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *separator;

@property (nonatomic, weak) id <MCCallVendorVendorCellProtocol> delegate;
@property (nonatomic, strong) MCCallVendorVendorModel *model;
@property (nonatomic, assign) NSUInteger section;
@end
