//
//  YLADScrollView.m
//  YLAdSrollView
//
//  Created by 鲁玉兰 on 16/6/15.
//  Copyright © 2016年 luyulan. All rights reserved.
//

#import "YLADScrollView.h"
@interface YLADScrollView()

@property (strong, nonatomic) UITapGestureRecognizer *gesture;
@property (assign, nonatomic) NSUInteger pageNum;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIView *firstView;
@property (strong, nonatomic) UIView *midView;
@property (strong, nonatomic) UIView *lastView;
@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSMutableArray *imageArray;
@end

@implementation YLADScrollView


#define VIEW_WIDTH self.bounds.size.width
#define VIEW_HEIGHT self.bounds.size.height

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        // scrollView
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, VIEW_WIDTH, VIEW_HEIGHT)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.maximumZoomScale = 2.0;
        _scrollView.minimumZoomScale = 0.5;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        // pageControl
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(VIEW_WIDTH/2-50, VIEW_HEIGHT-20, 100, 20)];
        [_pageControl setCurrentPage:0];
        _pageControl.userInteractionEnabled = NO;
        [self addSubview:_pageControl];
        
        // Gestures
        _gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        _gesture.numberOfTapsRequired = 1;
        _gesture.numberOfTouchesRequired = 1;
        [_scrollView addGestureRecognizer:_gesture];
        
        
    }
    return self;
}


- (void)handleGesture: (UITapGestureRecognizer *)sender
{
    if ([_delegate respondsToSelector:@selector(clickedPage:atIndex:)]) {
        [_delegate clickedPage:self atIndex:_currentPage+1];
    }
}

- (void)setScrollViewContent: (NSMutableArray *)imageArray
{
    if (imageArray) {
        _imageArray = imageArray;
        _scrollView.contentSize = CGSizeMake(VIEW_WIDTH * _imageArray.count, VIEW_HEIGHT);
        [_pageControl setNumberOfPages:_imageArray.count];
        
    }
    [self reloadAd];
    [self addTimer];

}


#pragma UIScrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

        CGFloat x = _scrollView.contentOffset.x;
    
        // 向前翻页
        if (x <= 0){
            if (_currentPage - 1 < 0) {
                _currentPage = _imageArray.count - 1;
            }
            else{
                _currentPage--;
            }
        }
     // 向后翻页
        else if(x >= VIEW_WIDTH * 2){
            if (_currentPage == _imageArray.count - 1) {
                _currentPage = 0;
    
            }
            else {
                _currentPage++;
            }
        }
    
    [self reloadAd];

    [self addTimer];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [_imageArray objectAtIndex:_currentPage];
}


#pragma private method
- (void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
}

- (void)removeTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)changeImage
{
    if (_currentPage == _imageArray.count - 1) {
        _currentPage = 0;
    }
    else {
        _currentPage++;
    }
        
    [self reloadAd];
    
}

- (void)reloadAd
{
    [_firstView removeFromSuperview];
    [_midView removeFromSuperview];
    [_lastView removeFromSuperview];
    
    if (_currentPage == 0) {
        _firstView = [_imageArray lastObject];
        _midView = [_imageArray objectAtIndex:_currentPage];
        _lastView = [_imageArray objectAtIndex:_currentPage + 1];
    }
    else if (_currentPage == _imageArray.count - 1){
        _firstView = [_imageArray objectAtIndex:_currentPage - 1];
        _midView = [_imageArray objectAtIndex:_currentPage];
        _lastView = [_imageArray firstObject];
    }
    else{
        _firstView = [_imageArray objectAtIndex:_currentPage - 1];
        _midView = [_imageArray objectAtIndex:_currentPage];
        _lastView = [_imageArray objectAtIndex:_currentPage + 1];
    }
    
    
    
    [_firstView setFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    [_midView setFrame:CGRectMake(VIEW_WIDTH, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    [_lastView   setFrame:CGRectMake(VIEW_WIDTH * 2, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    
    [_scrollView addSubview:_firstView];
    [_scrollView addSubview:_midView];
    [_scrollView addSubview:_lastView];
    
    [_pageControl setCurrentPage:_currentPage];
    
    [_scrollView setContentOffset:CGPointMake(VIEW_WIDTH, 0)];
    
    
}



@end
