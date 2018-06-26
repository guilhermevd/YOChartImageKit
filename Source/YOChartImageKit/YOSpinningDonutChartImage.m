#import "YOSpinningDonutChartImage.h"

@implementation YOSpinningDonutChartImage {
  CGFloat startAngle;
  NSMutableArray *images;
  NSInteger index;
}

- (instancetype)init {
    self = [super init];
    if (self) {
      index = 0;
      startAngle = self.startAngle;
      _duration = 2;
      _useGradient = YES;
      self.value = 40; // Need to call `self` to invoke the setter
      self.lineCapStyle = kCGLineCapRound;
      _alphaLenght = 1.2;
    }
    return self;
}

- (void)setColor:(UIColor *)color {
    self.colors = @[color, [UIColor clearColor]];
}

- (void)setValue:(CGFloat)value {
  NSNumber *number = [NSNumber numberWithFloat:value];
  if (value < 100) {
    self.values = @[number, [NSNumber numberWithFloat:100-value]];
  } else {
    self.values = @[number];
  }
}

- (void)makeGradient {
  // Getting all the colors and values for the last one
  NSMutableArray *values = [NSMutableArray arrayWithArray:self.values];
  NSMutableArray *colors = [NSMutableArray arrayWithArray:self.colors];
  
  // Getting the amount of the last value and computing the alpha decrement
  CGFloat last = [(NSNumber*)values[0] floatValue];
  CGFloat alpha = 1 / last;
  
  // Because we're about to replace it with a gradient
  UIColor *gradientColor = colors[0];
  [values removeObjectAtIndex:0];
  [colors removeObjectAtIndex:0];
  const CGFloat multiplicator = (self.lineCapStyle == kCGLineCapRound) ? self.alphaLenght : 1;
  
  for (NSUInteger ai = last; ai > 0; ai--) {
      [values insertObject:@1 atIndex:0];
    const CGFloat currentAlpha = 1 - (ai * alpha * multiplicator);
      [colors insertObject:[gradientColor colorWithAlphaComponent:currentAlpha] atIndex:0];
  }
  self.values = values;
  self.colors = colors;
}

- (UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale {
    if (_useGradient) {
      [self makeGradient];
    }
    // Create the animations
    while (index++ < 32) {
      // TODO: Probablement make this `32` variable, depending on the `duration` (but
      self.startAngle = startAngle;
      CGFloat chunk = M_PI_4 / 4;
      if (startAngle > (M_PI + M_PI_2 - chunk)) {
        startAngle = -M_PI_2;
      } else {
        startAngle += chunk;
      }
      UIImage *image = [super drawImage:frame scale:scale];
      if (!images) {
        images = [NSMutableArray arrayWithObject:image];
      } else {
        [images addObject:image];
      }
    }
    UIImage *image = [UIImage animatedImageWithImages:images duration:_duration];
    return image;
}

@end
