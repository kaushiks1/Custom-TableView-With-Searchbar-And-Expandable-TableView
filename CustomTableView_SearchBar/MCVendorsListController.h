//
//  MCVendorsListController.h
//  moveCHECK
//
//  Created by Roshan Sequeira on 30/05/16.
//  Copyright © 2016 Saltmines-Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCCallVendorTaskModel.h"

@interface MCVendorsListController : UIViewController

@property (nonatomic, strong) MCCallVendorTaskModel *model; // task model with name and list of vendors

@end
