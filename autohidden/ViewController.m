//
//  ViewController.m
//  autohidden
//
//  Created by izuchy on 2014/07/10.
//  Copyright (c) 2014年 IMPATH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    CGPoint totalOffset;
    CGPoint firstOffset;
    UIEdgeInsets defaultInsets;
    UIEdgeInsets defaultScrollInsets;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

static const NSInteger kAutoHiddenOffset = 100;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:(id)self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    totalOffset.y = 0;
    firstOffset.y = scrollView.contentOffset.y;
    
    if(self.tableView.contentInset.top !=0){
        defaultInsets = self.tableView.contentInset;
        defaultScrollInsets = self.tableView.scrollIndicatorInsets;
    }
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint currentOffset = scrollView.contentOffset;
    totalOffset.y = firstOffset.y - currentOffset.y;
    
    if(totalOffset.y < -kAutoHiddenOffset){
        if(!self.navigationController.navigationBarHidden){
            [self.navigationController setToolbarHidden:YES animated:YES];
            [self.navigationController setNavigationBarHidden:YES animated:YES];
            self.tableView.contentInset = UIEdgeInsetsMake(0,0,0,0);
            self.tableView.scrollIndicatorInsets=UIEdgeInsetsMake(0,0,0,0);
        }
    }else if(totalOffset.y > kAutoHiddenOffset){
        if(self.navigationController.navigationBarHidden){
            [self.navigationController setToolbarHidden:NO animated:YES];
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            [self.tableView setContentInset:defaultInsets];
            [self.tableView setScrollIndicatorInsets:defaultScrollInsets];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tvcell = [tableView dequeueReusableCellWithIdentifier: @"cid"];
    if (tvcell == nil) {
        tvcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                        reuseIdentifier: @"cid"];
    }
    tvcell.textLabel.text = [[NSString alloc] initWithFormat:@"%ld行目のセル", indexPath.row + 1];
    tvcell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%ld行目のセル", indexPath.row + 1];
    return tvcell;
}


@end
