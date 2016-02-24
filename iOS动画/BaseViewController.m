//
//  BaseViewController.m

//  iOS动画
//
//  Created by 杨杨 on 16/1/30.
//  Copyright © 2016年 杨杨. All rights reserved.
//

#import "BaseViewController.h"
#import "TitleButton.h"

@interface BaseViewController ()

@property (strong, nonatomic) NSArray *operateTitleArray;

@end

@implementation BaseViewController

- (void)initDate {
    _operateTitleArray = [self operateTitle];
}

//界面标题
- (NSString *)controllerTitle {
    return @"test";
}

//初始化界面
- (void)initView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 40)];
    topView.backgroundColor = [UIColor cyanColor];
    title.text = [self controllerTitle];
    title.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:title];
    [self.view addSubview:topView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (_operateTitleArray &&_operateTitleArray.count > 0) {
        NSUInteger row = _operateTitleArray.count%4 == 0 ? _operateTitleArray.count/4 : _operateTitleArray.count/4 + 1;
        UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - row *( 30 + 20) - 20, SCREEN_WIDTH, row*50 + 20)];
        for (int i = 0; i < _operateTitleArray.count; i ++) {
            TitleButton *buttonTitle = [[TitleButton alloc] initWithFrame:[self rectForButtonAtIndex:i sumButtons:_operateTitleArray.count] title:[_operateTitleArray objectAtIndex:i]];
            buttonTitle.tag = i;
            [buttonTitle addTarget:self action:@selector(clickOperateButton:) forControlEvents:UIControlEventTouchUpInside];
            [buttomView addSubview:buttonTitle];
        }
        [self.view addSubview:buttomView];
    }
}

//计算操作标题的大小
- (CGRect)rectForButtonAtIndex : (NSUInteger)index sumButtons:(NSUInteger)sumButttons {
    NSInteger maxButtonCell = 4;
    CGFloat buttonCellMargin = 20;
    CGFloat buttonCellRowMargin = 20;
    NSInteger temp = sumButttons/maxButtonCell;
    CGFloat offsetX = 0;
    CGFloat offsetY = 0;
    CGFloat width = 0;
    CGFloat height = 30;
    if (index < temp*maxButtonCell) {
        width = (SCREEN_WIDTH - 5*buttonCellMargin)/4 ;
         offsetX = buttonCellMargin * (index%maxButtonCell) + ((SCREEN_WIDTH - 5*buttonCellMargin)/4 )*(index%maxButtonCell) + buttonCellMargin;
         offsetY = index/maxButtonCell * (buttonCellRowMargin + buttonCellRowMargin) + buttonCellRowMargin;
    } else {
        width = ((SCREEN_WIDTH - (sumButttons%maxButtonCell + 1)*buttonCellMargin)/(sumButttons%maxButtonCell));
         offsetX = buttonCellMargin * (index%maxButtonCell) + ((SCREEN_WIDTH - (sumButttons%maxButtonCell + 1)*buttonCellMargin)/(sumButttons%maxButtonCell))*(index%maxButtonCell) + buttonCellMargin;
        
        offsetY = index/maxButtonCell * (buttonCellRowMargin + buttonCellRowMargin) + buttonCellRowMargin;
    }
    return CGRectMake(offsetX, offsetY, width, height);
}

//按钮标题
- (NSArray *)operateTitle {
    return @[@"1",@"2"];
}

//点击事件
- (void)clickOperateButton:(UIButton *)button {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDate];
    [self initView];
    // Do any additional setup after loading the view.
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
