//
//  LCAnimationTips.h
//  Cunxin
//
//  Created by CJ on 2017/10/26.
//  Copyright © 2017年 com.trident.lbschat. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIView+CJAdd.h"

//单图动画流动方向
typedef enum: NSInteger{
    LCAnimationDirection_up,
    LCAnimationDirection_down,
    LCAnimationDirection_left,
    LCAnimationDirection_right,
}LCAnimationDirection;

typedef void(^dismissHandle)();
@interface LCAnimationTips : UIView

#pragma mark - 弹出单个json动画
/**
 默认在视图中心显示  size:(100,100)

 @param jsName js文件名称
 */
+ (void)ShowAnimationWithAimationNamed:(NSString *)jsName;

/**
 动画视图

 @param jsName  文件名字
 @param view 目标View   默认主window
 @param centerPoint 中心点 默认屏幕中心
 @param size 大小       默认size:(100,100)
 */
+ (void)ShowAnimationWithAimationNamed:(NSString *)jsName
                                toView:(UIView *)view
                           centerPoint:(CGPoint)centerPoint
                                  size:(CGSize)size;



#pragma mark - 弹出多个冒泡动画
/**
 弹出单个图片动画
 
 默认： 起点：屏幕底部
       size：(50,50)
       type:LCAnimationDirection_up
       animationDissmis:yes
 @param imageName 网络加载图片url
 */

+ (void)AddSignAnimationViewWithLocalImageName:(NSString *)imageName;
/**
 弹出单个图片动画
 
 默认： 起点：屏幕底部
        size：(50,50)
        type:LCAnimationDirection_up
        animationDissmis: yes
 @param url 网络加载图片url
 */
+ (void)AddSignAnimationViewWithImageUrl:(NSString *)url;

/**
 弹出单个图片动画
 默认： 起点：屏幕底部
        size：(50,50)
 @param url 网络加载图片url
 @param animationDissmis 是否渐变消失
 @param startPoint 动画起点
 @param handler 消失后回调
 */
+ (void)AddSignAnimationViewWithImageUrl:(NSString *)url
                              startPoint:(CGPoint)startPoint
                        animationDissmis:(BOOL)animationDissmis
                                    type:(LCAnimationDirection)direction
                                 handler:(nullable dismissHandle)handler;
/**
 弹出单个图片动画
     默认： 起点：屏幕底部
     size：(50,50)
 @param url 网络加载图片url
 @param startPoint 动画起点
 @param endPoint 动画终点
 @param animationDissmis 是否渐变消失
 @param handler 消失后回调
 */
+ (void)AddSignAnimationViewWithImageUrl:(NSString *)url
                              startPoint:(CGPoint)startPoint
                                endPoint:(CGPoint)endPoint
                        animationDissmis:(BOOL)animationDissmis
                                    type:(LCAnimationDirection)direction
                                 handler:(nullable dismissHandle)handler;
/**
 弹出单个图片动画

 @param url  网络加载图片url（优先级使用）
 @param imageName 网络加载图片url
 @param startPoint 动画起点
 @param endPoint 动画终点
 @param size 图片大小
 @param animationDissmis 是否渐变消失
 @param animationTime 动画时长
 @param handler 消失后回调
 */
+ (void)AddSignAnimationViewWithImageUrl:(nullable NSString *)url
                          localImageName:(nullable NSString *)imageName
                              startPoint:(CGPoint)startPoint
                              endPoint:(CGPoint)endPoint
                                    size:(CGSize)size
                        animationDissmis:(BOOL)animationDissmis
                        animationTime:(NSInteger)animationTime
                                    type:(LCAnimationDirection)direction
                                 handler:(nullable dismissHandle)handler;

#pragma mark - 连续弹出多个冒泡动画

/**
 一次性添加多个动画

 @param count 个数
 @param url  网络加载图片url（优先级使用）
 @param imageName 网络加载图片url
 */
+ (void)AddMultiAnimations:(NSInteger)count
                startPoint:(CGPoint)startPoint
                  imageUrl:(nullable NSString *)url
            localImageName:(nullable NSString *)imageName;

@end

