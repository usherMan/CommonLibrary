//
//  UITextView+PlaceHolder.m
//  CommonLibrary
//
//  Created by usher on 2019/5/14.
//  Copyright © 2019年 usher. All rights reserved.
//

#import "UITextView+PlaceHolder.h"
#import <objc/runtime.h>

static char limitCountKey;
static char labMarginKey;
static char labHeightKey;

static const void *zw_placeHolderKey;

@interface UITextView ()

@property (nonatomic, readonly) UILabel *zw_placeHolderLabel;

@end

@implementation UITextView (PlaceHolder)

+(void)load{
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")),
                                   class_getInstanceMethod(self.class, @selector(zwPlaceHolder_swizzling_layoutSubviews)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(zwPlaceHolder_swizzled_dealloc)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"setText:")),
                                   class_getInstanceMethod(self.class, @selector(zwPlaceHolder_swizzled_setText:)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")),
                                   class_getInstanceMethod(self.class, @selector(zwlimitCounter_swizzling_layoutSubviews)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(zwlimitCounter_swizzled_dealloc)));
}

#pragma mark - swizzled
- (void)zwPlaceHolder_swizzled_dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self zwPlaceHolder_swizzled_dealloc];
}

- (void)zwPlaceHolder_swizzling_layoutSubviews {
    if (self.zw_placeHolder) {
        UIEdgeInsets textContainerInset = self.textContainerInset;
        CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
        CGFloat x = lineFragmentPadding + textContainerInset.left + self.layer.borderWidth;
        CGFloat y = textContainerInset.top + self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds) - x - textContainerInset.right - 2*self.layer.borderWidth;
        CGFloat height = [self.zw_placeHolderLabel sizeThatFits:CGSizeMake(width, 0)].height;
        self.zw_placeHolderLabel.frame = CGRectMake(x, y, width, height);
    }
    [self zwPlaceHolder_swizzling_layoutSubviews];
}

- (void)zwPlaceHolder_swizzled_setText:(NSString *)text{
    [self zwPlaceHolder_swizzled_setText:text];
    if (self.zw_placeHolder) {
        [self updatePlaceHolder];
    }
}

- (void)zwlimitCounter_swizzled_dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    @try {
        [self removeObserver:self forKeyPath:@"layer.borderWidth"];
        [self removeObserver:self forKeyPath:@"text"];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    [self zwlimitCounter_swizzled_dealloc];
}

- (void)zwlimitCounter_swizzling_layoutSubviews {
    [self zwlimitCounter_swizzling_layoutSubviews];
    if (self.zw_limitCount) {
        UIEdgeInsets textContainerInset = self.textContainerInset;
        textContainerInset.bottom = self.zw_labHeight;
        self.contentInset = textContainerInset;
        CGFloat x = CGRectGetMinX(self.frame)+self.layer.borderWidth;
        CGFloat y = CGRectGetMaxY(self.frame)-self.contentInset.bottom-self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds)-self.layer.borderWidth*2;
        CGFloat height = self.zw_labHeight;
        self.zw_inputLimitLabel.frame = CGRectMake(x, y, width, height);
        if ([self.superview.subviews containsObject:self.zw_inputLimitLabel]) {
            return;
        }
        [self.superview insertSubview:self.zw_inputLimitLabel aboveSubview:self];
    }
}

#pragma mark - associated
-(NSString *)zw_placeHolder{
    return objc_getAssociatedObject(self, &zw_placeHolderKey);
}

-(void)setZw_placeHolder:(NSString *)zw_placeHolder{
    objc_setAssociatedObject(self, &zw_placeHolderKey, zw_placeHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updatePlaceHolder];
}

-(UIColor *)zw_placeHolderColor{
    return self.zw_placeHolderLabel.textColor;
}

-(void)setZw_placeHolderColor:(UIColor *)zw_placeHolderColor{
    self.zw_placeHolderLabel.textColor = zw_placeHolderColor;
}

-(NSString *)placeholder{
    return self.zw_placeHolder;
}

-(void)setPlaceholder:(NSString *)placeholder{
    self.zw_placeHolder = placeholder;
}

-(NSInteger)zw_limitCount{
    return [objc_getAssociatedObject(self, &limitCountKey) integerValue];
}

- (void)setZw_limitCount:(NSInteger)zw_limitCount{
    objc_setAssociatedObject(self, &limitCountKey, @(zw_limitCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateLimitCount];
}

-(CGFloat)zw_labMargin{
    return [objc_getAssociatedObject(self, &labMarginKey) floatValue];
}

-(void)setZw_labMargin:(CGFloat)zw_labMargin{
    objc_setAssociatedObject(self, &labMarginKey, @(zw_labMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateLimitCount];
}

-(CGFloat)zw_labHeight{
    return [objc_getAssociatedObject(self, &labHeightKey) floatValue];
}

-(void)setZw_labHeight:(CGFloat)zw_labHeight{
    objc_setAssociatedObject(self, &labHeightKey, @(zw_labHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateLimitCount];
}

#pragma mark -config
- (void)configTextView{
    self.zw_labHeight = 20;
    self.zw_labMargin = 10;
}

#pragma mark - update
- (void)updatePlaceHolder{
    if (self.text.length) {
        [self.zw_placeHolderLabel removeFromSuperview];
        return;
    }
    self.zw_placeHolderLabel.font = self.font?self.font:self.cacutDefaultFont;
    self.zw_placeHolderLabel.textAlignment = self.textAlignment;
    self.zw_placeHolderLabel.text = self.zw_placeHolder;
    [self insertSubview:self.zw_placeHolderLabel atIndex:0];
}

- (void)updateLimitCount{
    if (self.text.length > self.zw_limitCount) {
        UITextRange *markedRange = [self markedTextRange];
        if (markedRange) {
            return;
        }
        NSRange range = [self.text rangeOfComposedCharacterSequenceAtIndex:self.zw_limitCount];
        self.text = [self.text substringToIndex:range.location];
    }
    NSString *showText = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)self.text.length,(long)self.zw_limitCount];
    self.zw_inputLimitLabel.text = showText;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString
                                              alloc] initWithString:showText];
    NSUInteger length = [showText length];
    NSMutableParagraphStyle *
    style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.tailIndent = -self.zw_labMargin; //设置与尾部的距离
    style.alignment = NSTextAlignmentRight;//靠右显示
    [attrString addAttribute:NSParagraphStyleAttributeName value:style
                       range:NSMakeRange(0, length)];
    self.zw_inputLimitLabel.attributedText = attrString;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"layer.borderWidth"]||
        [keyPath isEqualToString:@"text"]) {
        [self updateLimitCount];
    }
}

#pragma mark - lazzing
-(UILabel *)zw_placeHolderLabel{
    UILabel *placeHolderLab = objc_getAssociatedObject(self, @selector(zw_placeHolderLabel));
    if (!placeHolderLab) {
        placeHolderLab = [[UILabel alloc] init];
        placeHolderLab.numberOfLines = 0;
        placeHolderLab.textColor = [UIColor lightGrayColor];
        objc_setAssociatedObject(self, @selector(zw_placeHolderLabel), placeHolderLab, OBJC_ASSOCIATION_RETAIN);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlaceHolder) name:UITextViewTextDidChangeNotification object:self];
    }
    return placeHolderLab;
}

- (UIFont *)cacutDefaultFont{
    static UIFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITextView *textview = [[UITextView alloc] init];
        textview.text = @" ";
        font = textview.font;
    });
    return font;
}

-(UILabel *)zw_inputLimitLabel{
    UILabel *label = objc_getAssociatedObject(self, @selector(zw_inputLimitLabel));
    if (!label) {
        label = [[UILabel alloc] init];
        label.backgroundColor = self.backgroundColor;
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentRight;
        objc_setAssociatedObject(self, @selector(zw_inputLimitLabel), label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateLimitCount)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self];
        [self addObserver:self forKeyPath:@"layer.borderWidth" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [self configTextView];
    }
    return label;
}
@end
