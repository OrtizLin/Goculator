//
//  UIButton+UIButton_goculatorBackground.m
//  Goculator
//
//  Created by Otis on 2018/3/3.
//  Copyright © 2018年 Otis Lin. All rights reserved.
//

#import "UIButton+UIButton_goculatorBackground.h"
#import <objc/runtime.h>
@interface UIButton (CS_BackgroundColor)

@property (nonatomic, strong) NSMutableDictionary *cs_dictBackgroundColor;

@end

@implementation UIButton (UIButton_goculatorBackground)

static const NSString *key_cs_backgroundColor             = @"key_cs_backgroundColor";

static NSString *cs_stringForUIControlStateNormal         = @"cs_stringForUIControlStateNormal";
static NSString *cs_stringForUIControlStateHighlighted    = @"cs_stringForUIControlStateHighlighted";
static NSString *cs_stringForUIControlStateDisabled       = @"cs_stringForUIControlStateDisabled";
static NSString *cs_stringForUIControlStateSelected       = @"cs_stringForUIControlStateSelected";

#pragma mark - cs_dictBackgroundColor

- (NSMutableDictionary *)cs_dictBackgroundColor {
    return objc_getAssociatedObject(self, &key_cs_backgroundColor);
}

- (void)setCs_dictBackgroundColor:(NSMutableDictionary *)cs_dictBackgroundColor {
    objc_setAssociatedObject(self, &key_cs_backgroundColor, cs_dictBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPadBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    if (!self.cs_dictBackgroundColor) {
        self.cs_dictBackgroundColor = [[NSMutableDictionary alloc] init];
    }
    
    [self.cs_dictBackgroundColor setObject:backgroundColor forKey:[self cs_stringForUIControlState:state]];
}

- (NSString *)cs_stringForUIControlState:(UIControlState)state {
    NSString *cs_string;
    switch (state) {
        case UIControlStateNormal:
            cs_string = cs_stringForUIControlStateNormal;
            break;
        case UIControlStateHighlighted:
            cs_string = cs_stringForUIControlStateHighlighted;
            break;
        case UIControlStateDisabled:
            cs_string = cs_stringForUIControlStateDisabled;
            break;
        case UIControlStateSelected:
            cs_string = cs_stringForUIControlStateSelected;
            break;
        default:
            cs_string = cs_stringForUIControlStateNormal;
            break;
    }
    return cs_string;
}

#pragma mark - highlighted

- (void)setHighlighted:(BOOL)highlighted {
    if (highlighted) {
        self.backgroundColor = (UIColor *)[self.cs_dictBackgroundColor objectForKey:cs_stringForUIControlStateHighlighted];
    } else {
        self.backgroundColor = (UIColor *)[self.cs_dictBackgroundColor objectForKey:cs_stringForUIControlStateNormal];
    }
}

@end

