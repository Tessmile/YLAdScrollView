//
//  ViewController.m
//  YLAdSrollView
//
//  Created by 鲁玉兰 on 16/6/15.
//  Copyright © 2016年 luyulan. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.scrollView = [[YLADScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i<4 ;i++){
        NSString *name = [NSString stringWithFormat:@"image%d.jpg",i];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
        [array addObject:imageView];
    }
    [self.scrollView setScrollViewContent:array];
    self.scrollView.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.scrollView.pageControl.currentPage = 3;

    [self.scrollView setDelegate:self];
   
    [self.view addSubview:self.scrollView];
    
    

}


#pragma YLAdScrollViewDelegate
- (void)clickedPage:(YLADScrollView *)view atIndex:(NSUInteger)index
{
   
    NSLog(@"you clicked page: %ld,and you can do some http request here", index);
}


@end
