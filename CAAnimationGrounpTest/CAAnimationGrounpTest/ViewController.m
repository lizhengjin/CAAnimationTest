//
//  ViewController.m
//  CAAnimationGrounpTest
//
//  Created by liqi on 2019/6/28.
//  Copyright © 2019年 zhht. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIView *customView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

/**
 keypath
 transform.scale = 比例转换
 transform.rotation = 旋转
 transform.rotation.x = x轴旋转
 transform.rotation.y = y轴旋转
 opacity = 透明度
 margin = 边距
 position ＝ 位移
 backgroundColor = 背景颜色
 cornerRadius = 圆角
 borderWidth ＝ 边框宽度
 bounds ＝ 位置，体积
 contents ＝ 内容
 contentsRect ＝ 面积
 frame ＝ 位置，体积
 hidden ＝ 是否隐藏
 shadowColor ＝ 阴影颜色
 shadowOffset ＝ 阴影偏移
 shadowOpacity ＝ 阴影透明
 shadowRadius ＝ 阴影半径

 @param sender nil
 */
- (IBAction)positionClick:(id)sender {
    
    CABasicAnimation *position = [CABasicAnimation animationWithKeyPath:@"position"];
    position.toValue = [NSValue valueWithCGRect:CGRectMake(300, 300, 250, 250)];
    // removedOnCompletion = NO   position.fillMode = kCAFillModeForwards; 可以不让动画返回
    position.removedOnCompletion = NO;
    position.fillMode = kCAFillModeForwards;
    [self.customView.layer addAnimation:position forKey:@"position"];
    
//    [self.customView.layer removeAllAnimations];
//    [self.customView.layer removeAnimationForKey:@"position"];
    
}
- (IBAction)scaleClick:(id)sender {
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.byValue = @1.5;
    scale.duration = 3;
    scale.delegate = self;
    [self.customView.layer addAnimation:scale forKey:@"transform.scale"];
}
- (IBAction)rotationClick:(id)sender {
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.byValue = @M_PI;
    rotation.duration = 3;
    rotation.repeatDuration = 5;
    rotation.delegate = self;
    [self.customView.layer addAnimation:rotation forKey:@"transform.rotation"];
    
}
- (IBAction)animationGroupClick:(id)sender {
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.byValue = @1.5;
    
    CAKeyframeAnimation *leftRightAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    leftRightAnimation.values= @[@-0.5,@0.5,@-0.5];
    leftRightAnimation.repeatCount = CGFLOAT_MAX;
    leftRightAnimation.duration = 0.25;
    
    groupAnimation.animations = @[positionAnimation, scaleAnimation, leftRightAnimation];
    groupAnimation.duration = 3;
    
    [self.customView.layer addAnimation:groupAnimation forKey:@"group"];
}
- (IBAction)keyFrameAnimationClick:(id)sender {
    CAKeyframeAnimation *keyframe = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(400, 300)];
    
    keyframe.values = @[value1,value2,value3,value4];
    keyframe.duration = 2;
    [self.customView.layer addAnimation:keyframe forKey:@"keyframe"];
}
- (IBAction)bezierPathClick:(id)sender {
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(125, 355) radius:100 startAngle:0 endAngle:M_PI*3 clockwise:YES].CGPath;
    pathAnimation.duration = 1.5;
    
    [self.customView.layer addAnimation:pathAnimation forKey:@"path"];
}
- (IBAction)translationClick:(id)sender {
    
    CATransition *transition = [CATransition animation];
    /**
     1.苹果定义的常量
     kCATransitionFade 交叉淡化过渡
     kCATransitionMoveIn 新视图移到旧视图上面
     kCATransitionPush 新视图把旧视图推出去
     kCATransitionReveal 将旧视图移开,显示下面的新视图
     2.用字符串表示
     pageCurl 向上翻一页
     pageUnCurl 向下翻一页
     rippleEffect 滴水效果
     suckEffect 收缩效果，如一块布被抽走
     cube 立方体效果
     oglFlip 上下翻转效果
     */
    transition.type = @"oglFlip";
    transition.duration = 1.5;
    
    [self.customView.layer addAnimation:transition forKey:@"transtion"];
}
// 波浪纹动画
- (IBAction)waveAnimationClick:(id)sender {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 500, 1, 1);
    button.backgroundColor = [UIColor colorWithRed:64 / 255.0 green:185 / 255.0 blue:216 / 255.0 alpha:1];
    button.layer.cornerRadius = button.bounds.size.width/2;
    [self.view addSubview:button];
    
    [self customWave:button radius:300 duration:5 alpha:0.3];
    [self customWave:button radius:150 duration:4 alpha:0.5];
    [self customWave:button radius:75 duration:3 alpha:0.7];
}

- (void)customWave:(UIView *)view   radius:(CGFloat)radius duration:(CGFloat)duration alpha:(CGFloat)alpha
{
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, radius, radius);
    layer.cornerRadius = radius/2;
    layer.position = view.center;
    layer.backgroundColor = [[UIColor colorWithRed:249 / 255.0 green:200 / 255.0 blue:85/ 255.0 alpha:alpha] CGColor];
    
    [view.superview.layer insertSublayer:layer below:view.layer];//把扩散层放到播放按钮下面
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = duration;
    group.repeatCount = INFINITY;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    group.timingFunction = defaultCurve;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.1;
    scaleAnimation.toValue = @1.0;
    scaleAnimation.duration = duration;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @1.0;
    opacityAnimation.toValue = @0.1;
    opacityAnimation.duration = duration;
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    
    group.animations = @[scaleAnimation, opacityAnimation];
    [layer addAnimation:group forKey:@"kPulseAnimation"];
}


#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"%s",__func__);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"%s",__func__);
}
@end














