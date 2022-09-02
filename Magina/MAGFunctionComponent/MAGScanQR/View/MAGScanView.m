//
//  MAGScanView.m
//  Magina
//
//  Created by liujinze on 2021/2/4.
//

#import "MAGScanView.h"

@implementation MAGScanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 边框
    CGContextAddRect(context, self.bounds);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    CGContextStrokePath(context);
    
    // 绘制四角：
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextSetLineWidth(context, 5.0);
    
    // 左上角：
    CGContextMoveToPoint(context, 0, 30);
    CGContextAddLineToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 30, 0);
    CGContextStrokePath(context);
    
    // 右上角：
    CGContextMoveToPoint(context, self.bounds.size.width - 30, 0);
    CGContextAddLineToPoint(context, self.bounds.size.width, 0);
    CGContextAddLineToPoint(context, self.bounds.size.width, 30);
    CGContextStrokePath(context);
    
    // 右下角：
    CGContextMoveToPoint(context, self.bounds.size.width, self.bounds.size.height - 30);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
    CGContextAddLineToPoint(context, self.bounds.size.width - 30, self.bounds.size.height);
    CGContextStrokePath(context);
    
    // 左下角：
    CGContextMoveToPoint(context, 30, self.bounds.size.height);
    CGContextAddLineToPoint(context, 0, self.bounds.size.height);
    CGContextAddLineToPoint(context, 0, self.bounds.size.height - 30);
    CGContextStrokePath(context);
}

//todo 不使用nstimer 实现扫描动画
@end
