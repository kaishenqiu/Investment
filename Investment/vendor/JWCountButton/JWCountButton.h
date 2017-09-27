//
//  JWCountButton.h
//  JWCountButton
//
//  Created by wangjun on 2017/9/22.
//  Copyright © 2017年 wangjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWCountButton : UIView

@property (nonatomic, copy) void(^valueChanged)(NSInteger number, BOOL isIncrease);

/** *  晃动动画，default is NO 不开启 */
@property (nonatomic, assign) BOOL shakeAnimation;

/** *  '减' 按钮隐藏功能，default is NO 不隐藏 */
@property (nonatomic, assign) BOOL decreaseHide;

/** *  是否可以键盘输入，default is YES */
@property (nonatomic, assign, getter=isEditing) BOOL editing;

/** *  边框颜色 */
@property (nonatomic, strong) UIColor *borderColor;

/** *  长按加减按钮时间间隔，Default is CGFLOAT_MAX 默认功能关闭，若需要开启，设置一个不为 CGFLOAT_MAX 的值即可 */
@property (nonatomic, assign) CGFloat longPressSpaceTime;



/** *  当前值 */
@property (nonatomic, assign) NSInteger currentNumber;

/** *  输入框文字字体 default is [UIFont fontWithName:@"Arial" size:13] */
@property (nonatomic, strong) UIFont *inputFont;

/** *  输入框文字颜色 default is [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] */
@property (nonatomic, strong) UIColor *inputColor;

/** *  最小值, default is 1 */
@property (nonatomic, assign) NSInteger minValue;

/** *  最大值，default 无上限 */
@property (nonatomic, assign) NSInteger maxValue;




/** *  按钮字体 default is [UIFont fontWithName:@"Arial" size:15] */
@property (nonatomic, strong) UIFont *buttonTitleFont;

/** *  '加' 按钮图片 */
@property (nonatomic, strong) UIImage *increaseImage;

/** *  '减' 按钮图片 */
@property (nonatomic, strong) UIImage *decreaseImage;

/** *  '加' 按钮标题 default is '+' */
@property (nonatomic, copy) NSString *increaseTitle;

/** *  '减' 按钮标题 default is '-' */
@property (nonatomic, copy) NSString *decreaseTitle;




@end

@interface NSString (JWCountButton)

/** 
 *  是否非空白
 */
- (BOOL)isNotBlank;

@end
