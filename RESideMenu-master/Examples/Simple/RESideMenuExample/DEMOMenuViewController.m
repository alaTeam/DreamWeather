//
//  DEMOMenuViewController.m
//  RESideMenuExample
//
//  Created by Roman Efimov on 10/10/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOMenuViewController.h"
#import "DEMOFirstViewController.h"
#import "DEMOSecondViewController.h"
#import "UIImageView+LBBlurredImage.h"

//https://itunes.apple.com/us/app/meng-yi-tian-qi/id847338649?ls=1&mt=8
@interface DEMOMenuViewController ()

@property (strong, readwrite, nonatomic) UITableView *tableView;
@property (nonatomic, strong) UIImageView *blurredImageView;

@end

@implementation DEMOMenuViewController
#define IPHONE5_HEIGHT 568
#define IPHONE4_HEIGHT 480
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
- (void)viewDidLoad
{
    [super viewDidLoad];
    _firstVC=[[DEMOFirstViewController alloc]init];
    
    UIImage *background   =[UIImage imageNamed:IS_IPHONE_5?@"Mallbackgurand.png":@"Mallbackgurand.png"];

//    CGFloat top = 5; // 顶端盖高度
//    CGFloat bottom = 20 ; // 底端盖高度
//    CGFloat left = 20; // 左端盖宽度
//    CGFloat right = 0; // 右端盖宽度
//    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
//    // 伸缩后重新赋值
//    background = [background resizableImageWithCapInsets:insets];
//
    
    _blurredImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _blurredImageView.contentMode = UIViewContentModeScaleAspectFill;
    _blurredImageView.alpha = 1;
   // [_blurredImageView setImageToBlur:background blurRadius:8 completionBlock:nil];
    _blurredImageView.image=background;
    [self.view addSubview:_blurredImageView];
    _blurredImageView.frame=self.view.bounds;

    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 5) / 2.0f, self.view.frame.size.width, 54 * 5) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        
        tableView.backgroundView = nil;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            self.sideMenuViewController.contentViewController = [[UINavigationController alloc] initWithRootViewController:_firstVC];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[DEMOSecondViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            
            
            
            break;
        case 2:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/meng-yi-tian-qi/id847338649?ls=1&mt=8"]];
            

            break;
        case 3:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[DEMOSecondViewController alloc] init]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    NSArray *titles = @[@"当地天气",@"关于我们", @"爱得鼓励"];
  //  NSArray *images = @[@"IconHome", @"IconCalendar", @"IconProfile", @"IconSettings", @"IconEmpty"];
    cell.textLabel.text = titles[indexPath.row];
   // cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    
    
    return UIStatusBarStyleLightContent;
}

@end
