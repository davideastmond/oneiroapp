//
//  dcListViewCellTableViewCell.h
//  Oneiro
//
//  Created by David Eastmond on 2018-03-04.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dcListViewCellTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblDcName;
@property (strong, nonatomic) IBOutlet UILabel *lblDcDesc;

@end
