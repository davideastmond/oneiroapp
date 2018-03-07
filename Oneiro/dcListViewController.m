//
//  dcListViewController.m
//  Oneiro
//
//  Created by David Eastmond on 2018-03-03.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "dcListViewController.h"
#import "dcListViewCellTableViewCell.h"
#define defaultJournalKey @"journal"
@interface dcListViewController ()

@end

@implementation dcListViewController
@synthesize dcList = _dcList; // Dream character list

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Load the data array
    _dcTable.dataSource = self;
    _dcTable.delegate = self;
    _dcList = [JournalController getAllDreamCharacters:defaultJournalKey];
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

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"dcCell";
    dcListViewCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[dcListViewCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    DreamCharacter *dc = [_dcList objectAtIndex:[indexPath row]];
    cell.lblDcName.text = dc.Name;
    
    if (dc.description == nil)
    {
        cell.lblDcDesc.text = @"default nil description";
    } else{
        
        cell.lblDcDesc.text = dc.description;
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dcList.count;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
    //return [indexPath row] * 75;
}
@end
