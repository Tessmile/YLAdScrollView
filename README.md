# YLAdScrollView
实现广告图片循环滚动，图片点击功能

1. 利用3个UIView 实现多张图片的循环展示。
2. 使用代理模式实现用户单击图片的处理。

How to Use:
1. 拷贝YLAdScrollView.m YLAdScrollView.h两个文件到工程
2. 初始化YLAdScrollView对象后，调用方法- (void)setScrollViewContent: (NSMutableArray *)imageArray设置需要展示的图片
3. 可以pageControl进行设置，当前页，当前页显示颜色等
4. 可通过实现代理方法- (void)clickedPage: (YLADScrollView *)view atIndex: (NSUInteger)index实现图片单击
