//
//  LCAnimationTips.m
//  Cunxin
//
//  Created by CJ on 2017/10/26.
//  Copyright © 2017年 com.trident.lbschat. All rights reserved.
//


#define kScreenHeight  ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth   ([UIScreen mainScreen].bounds.size.width)

#define kAnimationViewH   100
#define kSignAnimationW   50
#define kSignAnimationStartPoint  CGPointMake(kScreenWidth / 2, kScreenHeight)
#define kSignAnimationTime   2  //动画时长
#define kSignAimationScrollHeigh  300//向上移动距离
#define kSignAimationFloatRange   200//左右浮动偏差
#define kSignAimationRightFloatRange   300//上下浮动偏差

#import "LCAnimationTips.h"
#import "Lottie.h"

@implementation LCAnimationTips

#pragma mark - 弹出单个json动画
+ (void)ShowAnimationWithAimationNamed:(NSString *)jsName {
    [LCAnimationTips ShowAnimationWithAimationNamed:jsName toView:[LCAnimationTips currentWindow] centerPoint:CGPointMake(kScreenWidth / 2, kScreenHeight / 2) size:CGSizeMake(kAnimationViewH, kAnimationViewH)];
}

+ (void)ShowAnimationWithAimationNamed:(NSString *)jsName
                                toView:(UIView *)view
                           centerPoint:(CGPoint)centerPoint
                                  size:(CGSize)size {
    if(!jsName) {
        return;
    }
    
     LOTAnimationView *animationView                      = [LOTAnimationView animationNamed:jsName];
    animationView.loopAnimation          = NO;
    animationView.cacheEnable            = NO;
    animationView.size = (size.height && size.width) ? size: CGSizeMake(kAnimationViewH,kAnimationViewH);
    animationView.center = (centerPoint.x && centerPoint.y) ? centerPoint : CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
    animationView.userInteractionEnabled = NO;
    if(view) {
        [view addSubview:animationView];
    }else {
        [[LCAnimationTips currentWindow] addSubview:animationView];
    }
    [animationView playWithCompletion:^(BOOL animationFinished) {
        [animationView removeFromSuperview];
    }];
}

#pragma mark - 弹出多个冒泡动画
+ (void)AddSignAnimationViewWithLocalImageName:(NSString *)imageName {
    if(!imageName) {
        return;
    }
    [LCAnimationTips AddSignAnimationViewWithImageUrl:nil localImageName:imageName startPoint:kSignAnimationStartPoint endPoint:CGPointZero size:CGSizeMake(kSignAnimationW, kSignAnimationW) animationDissmis:YES animationTime:0 type:LCAnimationDirection_up handler:nil];
}

+ (void)AddSignAnimationViewWithImageUrl:(NSString *)url {
    if(!url) {
        return;
    }
    [LCAnimationTips AddSignAnimationViewWithImageUrl:url localImageName:nil startPoint:kSignAnimationStartPoint endPoint:CGPointZero size:CGSizeMake(kSignAnimationW, kSignAnimationW) animationDissmis:YES animationTime:0 type:LCAnimationDirection_up handler:nil];
}
+ (void)AddSignAnimationViewWithImageUrl:(NSString *)url
                              startPoint:(CGPoint)startPoint
                        animationDissmis:(BOOL)animationDissmis
                                    type:(LCAnimationDirection)direction
                                 handler:(dismissHandle)handler {
    if(!url) {
        return;
    }
    [LCAnimationTips AddSignAnimationViewWithImageUrl:url localImageName:nil startPoint:startPoint endPoint:CGPointZero size:CGSizeMake(kSignAnimationW, kSignAnimationW) animationDissmis:animationDissmis animationTime:0 type:direction handler:handler];
}
+ (void)AddSignAnimationViewWithImageUrl:(NSString *)url
                              startPoint:(CGPoint)startPoint
                                endPoint:(CGPoint)endPoint
                        animationDissmis:(BOOL)animationDissmis
                                    type:(LCAnimationDirection)direction
                                 handler:(dismissHandle)handler {
    if(!url) {
        return;
    }
    [LCAnimationTips AddSignAnimationViewWithImageUrl:url localImageName:nil startPoint:startPoint endPoint:endPoint size:CGSizeMake(kSignAnimationW, kSignAnimationW) animationDissmis:animationDissmis animationTime:0 type:direction handler:handler];
}

+ (void)AddSignAnimationViewWithImageUrl:(nullable NSString *)url
                          localImageName:(nullable NSString *)imageName
                              startPoint:(CGPoint)startPoint
                                endPoint:(CGPoint)endPoint
                                    size:(CGSize)size
                        animationDissmis:(BOOL)animationDissmis
                           animationTime:(NSInteger)animationTime
                                    type:(LCAnimationDirection)direction
                                 handler:(nullable dismissHandle)handler {

    NSInteger animationInterval = animationTime > 0 ? animationTime : kSignAnimationTime;
    if(!url && !imageName) {
        return;
    }
    UIImageView *imageView = [[UIImageView alloc] init];
    if(size.width) {
        imageView.size = size;
    }else {
        imageView.size = CGSizeMake(kSignAnimationW, kSignAnimationW);
    }
    if(!startPoint.y && !startPoint.x) {
        imageView.bottom = kSignAnimationStartPoint.y;
        imageView.centerX = kSignAnimationStartPoint.x;
    }else {
        imageView.bottom = startPoint.y;
        imageView.centerX = startPoint.x;
    }
    
    [[LCAnimationTips currentWindow] addSubview:imageView];
    if(url) {
        //[imageView sd_setImageWithURL:[NSURL URLWithString:url]];
    }else {
        imageView.image = [UIImage imageNamed:imageName];
    }
    
    imageView.transform = CGAffineTransformMakeScale(0, 0);
    imageView.alpha = 0;
    
    //弹出动画
    [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        imageView.transform = CGAffineTransformIdentity;
        imageView.alpha = 0.9;
    } completion:NULL];
    
    //随机偏转角度
    NSInteger i = arc4random_uniform(2);
    NSInteger rotationDirection = 1- (2*i);
    NSInteger rotationFraction = arc4random_uniform(10);
    [UIView animateWithDuration:animationInterval animations:^{
        imageView.transform = CGAffineTransformMakeRotation(rotationDirection * M_PI/(4 + rotationFraction*0.2));
    } completion:NULL];
    
    UIBezierPath *heartTravelPath = [UIBezierPath bezierPath];
    [heartTravelPath moveToPoint:imageView.center];
    
    //终点
    CGFloat ViewX = imageView.center.x;
    CGFloat ViewY = imageView.center.y;
    if(!endPoint.y && !endPoint.x) {
        switch (direction) {
            case LCAnimationDirection_up:
                    endPoint = CGPointMake(ViewX + rotationDirection*100, ViewY - kSignAimationScrollHeigh);
                break;
            case LCAnimationDirection_down:
                    endPoint = CGPointMake(ViewX + rotationDirection*100, ViewY + kSignAimationScrollHeigh);
                break;
            case LCAnimationDirection_right:
                    endPoint = CGPointMake(ViewX + kSignAimationFloatRange, ViewY + rotationDirection*50);
                break;
            case LCAnimationDirection_left:
                    endPoint = CGPointMake(ViewX - kSignAimationFloatRange, ViewY + rotationDirection*50);
                break;
            default:
                break;
        }
    }
  
    //中间control点
    NSInteger j = arc4random_uniform(2);
    NSInteger travelDirection = 1- (2*j);
    
    NSInteger m1 = 0;
    NSInteger n1 = 0;
    NSInteger m2 = 0;
    NSInteger n2 = 0;
    switch (direction) {
        case LCAnimationDirection_up:
             m1 = ViewX + travelDirection*(arc4random_uniform(20) + kSignAimationFloatRange);
             n1 = ViewY - 60 + travelDirection*arc4random_uniform(20);
             m2 = ViewX - travelDirection*(arc4random_uniform(20) + kSignAimationFloatRange);
             n2 = ViewY - 90 + travelDirection*arc4random_uniform(20);
            break;
        case LCAnimationDirection_down:
            m1 = ViewX + travelDirection*(arc4random_uniform(20) + kSignAimationFloatRange);
            n1 = ViewY + 60 - travelDirection*arc4random_uniform(20);
            m2 = ViewX - travelDirection*(arc4random_uniform(20) + kSignAimationFloatRange);
            n2 = ViewY + 90 - travelDirection*arc4random_uniform(20);
            break;
        case LCAnimationDirection_right:
            m1 = ViewX + 40 - travelDirection*arc4random_uniform(20);
            n1 = ViewY + travelDirection*(arc4random_uniform(20) + kSignAimationRightFloatRange);
            m2 = ViewX + 60 - travelDirection*arc4random_uniform(20);
            n2 = ViewY - travelDirection*(arc4random_uniform(20) + kSignAimationRightFloatRange / 2);
            break;
        case LCAnimationDirection_left:
            m1 = ViewX - 40 + travelDirection*arc4random_uniform(20);
            n1 = ViewY + travelDirection*(arc4random_uniform(20) + kSignAimationRightFloatRange);
            m2 = ViewX - 60 + travelDirection*arc4random_uniform(20);
            n2 = ViewY - travelDirection*(arc4random_uniform(20) + kSignAimationRightFloatRange / 2);
            break;
        default:
            break;
    }
    
    CGPoint controlPoint1 = CGPointMake(m1, n1);
    CGPoint controlPoint2 = CGPointMake(m2, n2);
    [heartTravelPath addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.path = heartTravelPath.CGPath;
    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    keyFrameAnimation.duration = animationInterval;
    [imageView.layer addAnimation:keyFrameAnimation forKey:@"positionOnPath"];
    
    [UIView animateWithDuration:animationInterval - 0.2 animations:^{
        //是否渐变消失
        if(animationDissmis) {
            imageView.alpha = 0.0;
        }else {
            imageView.alpha = 0.8;
        }
    } completion:^(BOOL finished) {
        //回调
        if(handler) {
            handler();
        }
        [imageView removeFromSuperview];
    }];
}
#pragma mark - 连续弹出多个冒泡动画
+ (void)AddMultiAnimations:(NSInteger)count startPoint:(CGPoint)startPoint imageUrl:(nullable NSString *)url localImageName:(nullable NSString *)imageName {
    //动画时间间隔0.25s
    for(int i = 0;i < count;i ++) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i * 0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              [LCAnimationTips AddSignAnimationViewWithImageUrl:url localImageName:imageName startPoint:startPoint endPoint:CGPointZero size:CGSizeZero animationDissmis:YES animationTime:3 type:LCAnimationDirection_up handler:nil];
        });
    }
}
#pragma mark - getter
+ (UIView *)currentWindow {
  return [UIApplication sharedApplication].keyWindow;
}
@end
