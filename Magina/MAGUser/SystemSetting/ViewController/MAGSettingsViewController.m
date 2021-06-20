//
//  MAGSettingsViewController.m
//  Magina
//
//  Created by liujinze on 2021/3/2.
//

#import "MAGSettingsViewController.h"
#import "MAGSettingsDefines.h"
#import <XLForm/XLForm.h>

@interface MAGSettingsViewController ()

@end

@implementation MAGSettingsViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        [self initializeForm];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initializeForm];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)initializeForm {
    self.form = [XLFormDescriptor formDescriptorWithTitle:@"Magina 系统设置"];
    
    //输入类型
    XLFormSectionDescriptor *sectionText = [XLFormSectionDescriptor formSection];
    [self.form addFormSection:sectionText];
    [sectionText addFormRow:[self textRow]];
    
    //按钮类
    XLFormSectionDescriptor *control = [XLFormSectionDescriptor formSection];
    [self.form addFormSection:control];
    [control addFormRow:[self boolSwitchRow]];
    [control addFormRow:[self boolCheckRow]];
    [control addFormRow:[self boolSliderRow]];
    [control addFormRow:[self buttonRow]];
    [control addFormRow:[self stepCounterRow]];
    
    //菜单
    XLFormSectionDescriptor *sectionSelectList = [XLFormSectionDescriptor formSection];
    [self.form addFormSection:sectionSelectList];
    [sectionSelectList addFormRow:[self pushSelectRow]];

    //日历类型
    XLFormSectionDescriptor *dateSection = [XLFormSectionDescriptor formSection];
    [self.form addFormSection:dateSection];
    [dateSection addFormRow:[self dateInlineRow]];
    [dateSection addFormRow:[self dateTimeInlineRow]];
    [dateSection addFormRow:[self timeInlineRow]];
}

#pragma mark - rows get Methods

- (XLFormRowDescriptor *)textRow
{
    XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:kText rowType:XLFormRowDescriptorTypeText];
    [row.cellConfigAtConfigure setObject:@"输入文本" forKey:@"textField.placeholder"];
    return row;
}

- (XLFormRowDescriptor *)pushSelectRow
{
    XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:kPushSelector rowType:XLFormRowDescriptorTypeSelectorPush title:@"菜单选择"];
    return row;
}

- (XLFormRowDescriptor *)boolSwitchRow
{
    XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:kBooleanSwitch rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"开关"];
    return row;
}

- (XLFormRowDescriptor *)boolCheckRow
{
    XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:kBooleanCheck rowType:XLFormRowDescriptorTypeBooleanCheck title:@"勾选"];
    return row;
}

- (XLFormRowDescriptor *)boolSliderRow
{
    XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:kSlider rowType:XLFormRowDescriptorTypeSlider title:@"滑条"];
    return row;
}

- (XLFormRowDescriptor *)buttonRow
{
    XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:kButton rowType:XLFormRowDescriptorTypeButton title:@"按钮"];
    return row;
}

- (XLFormRowDescriptor *)stepCounterRow
{
    XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:kStepCounter rowType:XLFormRowDescriptorTypeStepCounter title:@"计数"];
    return row;
}


- (XLFormRowDescriptor *)dateInlineRow
{
    //date 月 日 年  （内嵌）
    XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:kDateInline rowType:XLFormRowDescriptorTypeDateInline title:@"dateInline"];
    row.value = [NSDate new];
    return row;
}

- (XLFormRowDescriptor *)dateTimeInlineRow
{
    // 星期 月 日 小时  分（内嵌）
    XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:kDateTimeInline rowType:XLFormRowDescriptorTypeDateTimeInline title:@"dateTimeInline"];
    row.value = [NSDate new];
    return row;
}

- (XLFormRowDescriptor *)timeInlineRow
{
    //date 小时 分 AM/PM（内嵌）
    XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:kTimeInline rowType:XLFormRowDescriptorTypeTimeInline title:@"timeInline"];
    row.value = [NSDate new];
    return row;
}

/*
 - 文本：基本是键盘细节不同

 XLFormRowDescriptorTypeTextView 一大段文本
 XLFormRowDescriptorTypeName
 XLFormRowDescriptorTypeURL 键盘带.com
 XLFormRowDescriptorTypeEmail  键盘带@
 XLFormRowDescriptorTypeNumber
 XLFormRowDescriptorTypePassword 输入自动变不可见
 XLFormRowDescriptorTypePhone 数字键盘
 XLFormRowDescriptorTypeTwitter
 XLFormRowDescriptorTypeAccount
 XLFormRowDescriptorTypeInteger
 XLFormRowDescriptorTypeDecimal
 XLFormRowDescriptorTypeZipCode

 - 菜单
 XLFormRowDescriptorTypeSelectorPopover
 XLFormRowDescriptorTypeSelectorActionSheet
 XLFormRowDescriptorTypeSelectorAlertView
 XLFormRowDescriptorTypeSelectorPickerView
 XLFormRowDescriptorTypeSelectorPickerViewInline
 XLFormRowDescriptorTypeMultipleSelector
 XLFormRowDescriptorTypeMultipleSelectorPopover
 XLFormRowDescriptorTypeSelectorLeftRight
 
 - 日期 表现很差的date类型 可能和iOS14升级有关 没适配
 XLFormRowDescriptorTypeDate
 XLFormRowDescriptorTypeDateTime
 XLFormRowDescriptorTypeTime
 XLFormRowDescriptorTypeDatePicker 直接一坨datepicker
 
 XLFormRowDescriptorTypeImage 就是包装imagepicker 意义不大
 XLFormRowDescriptorTypeStepCounter 展示计数
 XLFormRowDescriptorTypeCountDownTimerInline
 XLFormRowDescriptorTypeCountDownTimer 计时器
*/

#pragma mark - 回调

- (void)formSectionHasBeenRemoved:(XLFormSectionDescriptor *)formSection atIndex:(NSUInteger)index
{
    [super formSectionHasBeenRemoved:formSection atIndex:index];
}

- (void)formSectionHasBeenAdded:(XLFormSectionDescriptor *)formSection atIndex:(NSUInteger)index
{
    [super formSectionHasBeenAdded:formSection atIndex:index];
}

- (void)formRowHasBeenAdded:(XLFormRowDescriptor *)formRow atIndexPath:(NSIndexPath *)indexPath
{
    [super formRowHasBeenAdded:formRow atIndexPath:indexPath];
}

- (void)formRowHasBeenRemoved:(XLFormRowDescriptor *)formRow atIndexPath:(NSIndexPath *)indexPath
{
    [super formRowHasBeenRemoved:formRow atIndexPath:indexPath];
}

- (void)formRowDescriptorPredicateHasChanged:(XLFormRowDescriptor *)formRow
                                   oldValue:(id)oldValue
                                   newValue:(id)newValue
                               predicateType:(XLPredicateType)predicateType
{
    [super formRowDescriptorPredicateHasChanged:formRow oldValue:oldValue newValue:newValue predicateType:predicateType];
}

- (void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)formRow oldValue:(id)oldValue newValue:(id)newValue
{
    [super formRowDescriptorValueHasChanged:formRow oldValue:oldValue newValue:newValue];
}

@end
