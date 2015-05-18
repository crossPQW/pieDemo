//
//  ViewController.m
//  pieDemo
//
//  Created by 黄少华 on 15/5/18.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "ViewController.h"
#import "VBPieChart.h"
#import "UIColor+HexColor.h"
#import "SKTagView.h"
#import "SKTagButton.h"
@interface ViewController ()

@property (nonatomic, strong) VBPieChart *chart;

@property (nonatomic, strong) NSArray *chartValues;

@property (nonatomic, strong) SKTagView *tagView;

@property (nonatomic, strong) SKTagView *secondTagView;

@property (nonatomic, strong) NSMutableArray *firstTags;
@property (nonatomic, strong) NSMutableArray *secondTags;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setNeedsLayout];
    
    if (!_chart) {
        _chart = [[VBPieChart alloc] init];
        [self.view addSubview:_chart];
    }
    [_chart setFrame:CGRectMake(30, 50, 300, 300)];
    [_chart setEnableStrokeColor:YES];
    [_chart setHoleRadiusPrecent:0.3];
    
    [_chart.layer setShadowOffset:CGSizeMake(2, 2)];
    [_chart.layer setShadowRadius:3];
    [_chart.layer setShadowColor:[UIColor blackColor].CGColor];
    [_chart.layer setShadowOpacity:0.7];
    
    [_chart setHoleRadiusPrecent:0.3];
    
    self.chartValues = @[
                         @{@"name":@"第一个按钮", @"value":@50, @"color":[UIColor colorWithHex:0xdd191daa]},
                         @{@"name":@"测试数据哈哈", @"value":@20, @"color":[UIColor colorWithHex:0xd81b60aa]},
                         @{@"name":@"取个名字呢", @"value":@40, @"color":[UIColor colorWithHex:0x8e24aaaa]},
                         @{@"name":@"名字一定要长一点点", @"value":@70, @"color":[UIColor colorWithHex:0x3f51b5aa]},
                         @{@"name":@"哦", @"value":@65, @"color":[UIColor colorWithHex:0x5677fcaa]},
                         @{@"name":@"boring", @"value":@23, @"color":[UIColor colorWithHex:0x2baf2baa]}
                         
                         ];
    
    [_chart setChartValues:_chartValues animation:YES];
    
    //添加tagView
    __weak ViewController *weakSelf = self;
    self.tagView = ({
        SKTagView *tagView = [[SKTagView alloc] init];
        weakSelf.tagView   = tagView;
        tagView.backgroundColor = [UIColor yellowColor];
        tagView.padding    = UIEdgeInsetsMake(12, 12, 12, 12);
        tagView.insets     = 10;
        tagView.lineSpace  = 10;
        //点击了第一行的按钮
        tagView.didClickTagAtIndex = ^(NSUInteger index){
            SKTagButton *firstTagBtn    = self.firstTags[index];//上面的按钮
            SKTagButton *secondTagBtn   = self.secondTags[index];//下面得按钮
            firstTagBtn.backgroundColor = [UIColor lightGrayColor];
            secondTagBtn.backgroundColor= [UIColor redColor];
        };
        tagView;
    });
    
    self.tagView.frame = CGRectMake(0, 380, 320, 100);
    [self.view addSubview:self.tagView];
    
    //添加tag
    for (int i = 0; i < self.chartValues.count; i++) {
        NSDictionary *dict = self.chartValues[i];
        SKTag *tag = [SKTag tagWithText:dict[@"name"]];
        tag.textColor = [UIColor whiteColor];
        tag.fontSize  = 12;
        tag.padding   = UIEdgeInsetsMake(8, 8, 8, 8);
        UIColor *color= dict[@"color"];
        tag.bgColor   = color;
        tag.cornerRadius = 5;
        [self.tagView addTag:tag];
        
        //添加到数组
        for (SKTagButton *tagBtn in self.tagView.subviews) {
            if ([tagBtn isKindOfClass:[SKTagButton class]]) {
                [self.firstTags insertObject:tagBtn atIndex:i];
            }
        }
    }
    
    
    //第二个tagView
    self.secondTagView = ({
        SKTagView *secondTagView = [[SKTagView alloc] init];
        weakSelf.secondTagView   = secondTagView;
        secondTagView.backgroundColor = [UIColor whiteColor];
        secondTagView.padding    = UIEdgeInsetsMake(12, 12, 12, 12);
        secondTagView.insets     = 10;
        secondTagView.lineSpace  = 10;
        //第二个view内部按钮点击事件
        secondTagView.didClickTagAtIndex = ^(NSUInteger index){
            SKTagButton *firstTagBtn     = self.firstTags[index];//上面的按钮
            SKTagButton *secondTagBtn    = self.secondTags[index];//下面得按钮
            NSDictionary *dict           = self.chartValues[index];
            firstTagBtn.backgroundColor  = dict[@"color"];
            secondTagBtn.backgroundColor = [UIColor lightGrayColor];
            
        };
        secondTagView;
    });
    
    self.secondTagView.frame = CGRectMake(0, 480, 320, 100);
    [self.view addSubview:self.secondTagView];
    
    //添加tag
    for (int i = 0; i < self.chartValues.count; i++) {
        NSDictionary *dict = self.chartValues[i];
        SKTag *tag = [SKTag tagWithText:dict[@"name"]];
        tag.textColor = [UIColor clearColor];
        tag.fontSize  = 12;
        tag.padding   = UIEdgeInsetsMake(8, 8, 8, 8);
        tag.bgColor   = [UIColor lightGrayColor];
        tag.cornerRadius = 5;
        [self.secondTagView addTag:tag];
        
        //添加到数组
        for (SKTagButton *tagBtn in self.secondTagView.subviews) {
            if ([tagBtn isKindOfClass:[SKTagButton class]]) {
                [self.secondTags insertObject:tagBtn atIndex:i];
            }
        }
        
        
    }

    
    

}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.chart setChartValues:self.chartValues animation:YES duration:5.f options:VBPieChartAnimationGrowth];
//}

- (NSMutableArray *)firstTags
{
    if (_firstTags == nil) {
        _firstTags = [NSMutableArray array];
    }
    return _firstTags;
}

- (NSMutableArray *)secondTags
{
    if (_secondTags == nil) {
        _secondTags = [NSMutableArray array];
    }
    return _secondTags;
}
@end
