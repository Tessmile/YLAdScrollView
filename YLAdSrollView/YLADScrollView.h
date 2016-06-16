//
//  YLADScrollView.h
//  YLAdSrollView
//
//  Created by 鲁玉兰 on 16/6/15.
//  Copyright © 2016年 luyulan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YLAdSrcollViewDelegate;

@interface YLADScrollView : UIView<UIScrollViewDelegate>
@property (assign, nonatomic) id<YLAdSrcollViewDelegate> delegate;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

- (void)setScrollViewContent: (NSMutableArray *)imageArray;
@end

@protocol YLAdSrcollViewDelegate <NSObject>
@optional
- (void)clickedPage: (YLADScrollView *)view atIndex: (NSUInteger)index;
@end
