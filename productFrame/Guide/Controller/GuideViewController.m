//
//  GuideViewController.m
//  productFrame
//
//  Created by admin on 2017/12/11.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "GuideViewController.h"
#import "productMainTabBarController.h"

@interface GuideViewController ()<UIScrollViewDelegate>
{
    // 创建页码控制器
    UIPageControl *pageControl;
    // 判断是否是第一次进入应用
    BOOL isFirst;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self creatScrollView];
    
}

- (void)creatScrollView{
    
    CGFloat imageNum = 4;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * imageNum, SCREEN_HEIGHT);
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    for (int i=0; i<imageNum; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
        
        if (i == imageNum - 1) {
            // 在最后一页创建按钮
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(SCREEN_WIDTH / 3, SCREEN_HEIGHT * 7 / 8, SCREEN_WIDTH / 3, SCREEN_HEIGHT / 16);
            [button setTitle:@"点击进入" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            button.layer.borderWidth = 2;
            button.layer.cornerRadius = 5;
            button.clipsToBounds = YES;
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [button addTarget:self action:@selector(enterApp:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }else{
            UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.scrollView addSubview:skipButton];
            skipButton.frame = CGRectMake(10 + SCREEN_WIDTH *i, 80, 100, 20);
            [skipButton setTitle:@"skip >>" forState:UIControlStateNormal];
            [skipButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [skipButton addTarget:self action:@selector(skip:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3, SCREEN_HEIGHT * 15 / 16, SCREEN_WIDTH / 3, SCREEN_HEIGHT / 16)];
    // 设置页数
    pageControl.numberOfPages = imageNum;
    pageControl.pageIndicatorTintColor = [UIColor orangeColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self.view addSubview:pageControl];
    
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 计算当前在第几页
    pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width);
}

#pragma mark - 点击事件

// 点击按钮保存数据并切换根视图控制器
- (void)enterApp:(UIButton *)sender{
    isFirst = YES;
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    // 保存用户数据
    [useDef setBool:isFirst forKey:@"First"];
    [useDef synchronize];
    // 切换根视图控制器
    self.view.window.rootViewController = [[productMainTabBarController alloc] init];
}

- (void)skip:(UIButton *)sender{
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*(pageControl.currentPage + 1), _scrollView.contentOffset.y) animated:YES];
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

@end
