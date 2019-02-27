//
//  UIView+Radio.m
//  hntx
//
//  Created by zzz on 16/8/17.
//  Copyright © 2016年 zoomwoo. All rights reserved.
//

#import "UIView+Radio.h"


@implementation UIView (Radio)
//static CGFloat raido = 640;
CGFloat CGFloatIn640(CGFloat value)
{
//    if (raido==0) {
//        raido = screenWidth/640.
//    }
     return  (value/640.)*screenWidth;
}

CGFloat CGFloatIn750(CGFloat value)
{
    //    if (raido==0) {
    //        raido = screenWidth/640.
    //    }
    return  (value/750.)*screenWidth;
}

CGFloat CGFloatIn2048(CGFloat value)
{
    //    if (raido==0) {
    //        raido = screenWidth/640.
    //    }
    return  (value/2048.)*screenWidth;
}

CGFloat CGFloatIn1536(CGFloat value)
{
    //    if (raido==0) {
    //        raido = screenWidth/640.
    //    }
    return  (value/1536.)*screenHeight;
}
@end
