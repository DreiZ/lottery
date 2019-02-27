//
//  UIView+Radio.h
//  hntx
//
//  Created by zzz on 16/8/17.
//  Copyright © 2016年 zoomwoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
static inline CGFloat getValue(CGFloat value)
{
    return  floorf((value/640.)*screenWidth);
    
}

static inline CGFloat getValueWithoutLimit(CGFloat value)
{
    return  ceilf((value/640.)*screenWidth);
}

static inline CGFloat getValueBybig(CGFloat value)
{
    return  ceilf((value/750.)*screenWidth);
    
}

static inline CGFloat getValueBybigWithoutLimit(CGFloat value)
{
    return  ceilf((value/750.)*screenWidth);
}


@interface UIView (Radio)
extern CGFloat CGFloatIn640(CGFloat valure);
extern CGFloat CGFloatIn750(CGFloat value);
extern CGFloat CGFloatIn2048(CGFloat value);
extern CGFloat CGFloatIn1536(CGFloat value);

@end
