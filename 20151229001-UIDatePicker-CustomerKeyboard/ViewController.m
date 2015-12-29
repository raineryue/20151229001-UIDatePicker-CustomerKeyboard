//
//  ViewController.m
//  20151229001-UIDatePicker-CustomerKeyboard
//
//  Created by Rainer on 15/12/29.
//  Copyright © 2015年 Rainer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/** 日期显示文本框 */
@property (nonatomic, weak) UITextField *dateTextField;

/** 日期选择控件工具栏 */
@property (nonatomic, strong) UIToolbar *dateToolbar;

/** 日期选择控件 */
@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 布局子控件
    [self layoutSubviews];
}

#pragma mark - 控件懒加载
/**
 *  日期显示文本框
 */
- (UITextField *)dateTextField {
    if (nil == _dateTextField) {
        UITextField *dateTextField = [[UITextField alloc] init];
        
        dateTextField.borderStyle = UITextBorderStyleRoundedRect;
        
        // 设置文本框的键盘视图
        dateTextField.inputView = self.datePicker;
        // 设置文本框的键盘辅助视图
        dateTextField.inputAccessoryView = self.dateToolbar;
        
        _dateTextField = dateTextField;
        
        [self.view addSubview:_dateTextField];
    }
    
    return _dateTextField;
}

/**
 *  日期选择控件
 */
- (UIDatePicker *)datePicker {
    if (nil == _datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        
        // 设置日期选择器本地化
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        // 设置日期选择器的类型
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }
    
    return _datePicker;
}

/**
 *  日期选择控件工具栏
 */
- (UIToolbar *)dateToolbar {
    if (nil == _dateToolbar) {
        _dateToolbar = [[UIToolbar alloc] init];
        
        _dateToolbar.frame = (CGRect){CGPointZero, {self.view.bounds.size.width, 44}};
        
        UIBarButtonItem *prevBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上一个" style:UIBarButtonItemStylePlain target:self action:@selector(dateToolbarButtonItemClickAction:)];
        prevBarButtonItem.tag = 1;
        
        UIBarButtonItem *nextBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一个" style:UIBarButtonItemStylePlain target:self action:@selector(dateToolbarButtonItemClickAction:)];
        nextBarButtonItem.tag = 2;
        
        UIBarButtonItem *bounceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(dateToolbarButtonItemClickAction:)];
        doneBarButtonItem.tag = 3;
        
        _dateToolbar.items = @[prevBarButtonItem, nextBarButtonItem, bounceBarButtonItem, doneBarButtonItem];
    }
    
    return _dateToolbar;
}

#pragma mark - 私有辅助方法
/**
 *  布局子控件
 */
- (void)layoutSubviews {
    // 日期文本框
    self.dateTextField.frame = CGRectMake(10, 30, self.view.bounds.size.width - 20, 35);
}

#pragma mark - 按钮监听事件
/**
 *  日期控件辅助工具按钮点击事件
 */
- (void)dateToolbarButtonItemClickAction:(UIBarButtonItem *)barButtonItem {
    if (3 == barButtonItem.tag) {
        NSLog(@"%@", self.datePicker.date);
        
        // 实例化一个日期格式化对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // 设置格式化的类型
        dateFormatter.dateFormat = @"yyyyMMdd";
        // 将格式化的字符串赋值给文本框
        self.dateTextField.text = [dateFormatter stringFromDate:self.datePicker.date];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
