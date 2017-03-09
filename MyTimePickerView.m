//
//  MyTimePicker.m
//  TimePicker
//
//  Created by App on 1/13/16.
//  Copyright © 2016 App. All rights reserved.
//

#import "MyTimePickerView.h"
#import "MyTimeTool.h"

#define SCREENSIZE [UIScreen mainScreen].bounds.size
#define HEIGHTCOUNT 0.5
#define INTERVALMINUTE 15

#define ONEDAYARRAY @[@"今天"]
#define TWODAYARRAY [self.deadLine integerValue] > 0 ? @[@"今天", @"明天"] : @[@"今天", @"昨天"]
#define THREEDAYARRAY [self.deadLine integerValue] > 0 ? @[@"今天", @"明天", @"后天"] : @[@"今天", @"昨天", @"前天"]
#define HOURARRAY @[ @"9点", @"10点", @"11点", @"12点", @"13点", @"14点", @"15点", @"16点", @"17点", @"18点", @"19点", @"20点", @"21点", @"22点", @"23点"]
#define MINUTEARRAY @[@"0分", @"15分", @"30分", @"45分"]

#define DURATIONARRAY @[@"0.5", @"1.0", @"2.0", @"4.0"]

#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]  

typedef void(^CompleteBolck) (NSDictionary *);

@interface MyTimePickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;


- (IBAction)sureBtnAction:(id)sender;
- (IBAction)cancelBtnAction:(id)sender;

@property (nonatomic, strong) NSArray *dayArray;
@property (nonatomic, strong) NSArray *showDayArray;
@property (nonatomic, strong) NSArray *hourArray;
@property (nonatomic, strong) NSArray *minuteArray;
@property (nonatomic, strong) NSArray *totalArray;

@property (nonatomic, strong) NSArray *durationArray;

@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, assign) NSInteger columnIndex;
@property (nonatomic, assign) NSInteger rowIndex;

@property (nonatomic, copy) CompleteBolck completeBlock;
@property (nonatomic, copy) NSString *deadLine;

@end

@implementation MyTimePickerView



@synthesize intervalMinute = intervalMinute_;

+(instancetype)myTimePickerViewWithDeadLine:(NSString *)deadLine{
    MyTimePickerView *timePickerView = [[[NSBundle mainBundle] loadNibNamed:@"MyTimePickerView" owner:self options:nil] objectAtIndex:0];
    timePickerView.deadLine = deadLine;
    [timePickerView initData];
    return timePickerView;
}

-(void)awakeFromNib{
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
}

//-(void)layoutSubviews{
//    [super layoutSubviews];
//    NSLog(@"layout subviews---%@", NSStringFromCGSize(SCREENSIZE));
////    self.frame =
////    self.topLabel.frame = CGRectMake(0, 0.2 * 0.06 * SCREENSIZE.height, SCREENSIZE.width, 0.6 * 0.1 *SCREENSIZE.height);
////    self.pickerView.frame = CGRectMake(0, 0.1 * SCREENSIZE.height, SCREENSIZE.width, 0.3 * SCREENSIZE.height);
////    self.cancelBtn.frame = CGRectMake( 0.2 * 0.0.06 * SCREENSIZE.height, self.cancelBtn.frame.origin.y, 100, 60);
////    self.sureBtn.frame = CGRectMake(SCREENSIZE.width - 0.2 * 0.1 * SCREENSIZE.height, self.cancelBtn.frame.origin.y, 60, 60);
//    
//}

+(void)showTimePickerViewDeadLine:(NSString *)deadLine CompleteBlock:(void (^)(NSDictionary *))completeBlock{
    MyTimePickerView *timePickerView = [self myTimePickerViewWithDeadLine:deadLine];
    timePickerView.completeBlock = completeBlock;
    timePickerView.frame = CGRectMake(0, SCREENSIZE.height + HEIGHTCOUNT * SCREENSIZE.height, SCREENSIZE.width, HEIGHTCOUNT * SCREENSIZE.height);
    
    [timePickerView.maskView addSubview:timePickerView];

    [[UIApplication sharedApplication].keyWindow addSubview:timePickerView.maskView];
//    CGRect frame = CGRectMake(0, (1-HEIGHTCOUNT) * 0.5 * SCREENSIZE.height, SCREENSIZE.width, HEIGHTCOUNT * SCREENSIZE.height);
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = timePickerView.frame;
        frame.origin.y = (1-HEIGHTCOUNT) * 0.5 * SCREENSIZE.height;
        timePickerView.frame = frame;
        timePickerView.maskView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];    
}

-(UIView *)maskView{
    if(!_maskView){
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, SCREENSIZE.height)];
        _maskView.backgroundColor = COLOR(58, 59, 58, 0.9);
        _maskView.alpha = 0.0;
    }
    return _maskView;
}

- (IBAction)sureBtnAction:(id)sender {
    if(self.completeBlock){
        NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
        NSInteger firstIndex = [_pickerView selectedRowInComponent:0];
        NSInteger secodnIndex = [_pickerView selectedRowInComponent:1];
        NSInteger thirdIndex = [_pickerView selectedRowInComponent:2];
        NSInteger fourtIndex = [_pickerView selectedRowInComponent:3];
        NSMutableString *dateValue = [[NSMutableString alloc] initWithString:[MyTimeTool displayedSummaryTimeUsingString:_dayArray[firstIndex]]];
        [dateValue appendString:@" "];
        [dateValue appendString:[self formatOriArray:_hourArray][secodnIndex]];
        [dateValue appendString:@":"];
        [dateValue appendString:[self formatOriArray:_minuteArray][thirdIndex]];
        [dateValue appendString:@":"];
        [dateValue appendString:@"00"];
        infoDic[@"time_value"] = dateValue;
        infoDic[@"duration"]=_durationArray[fourtIndex];
        infoDic[@"timedescrip"]=[MyTimeTool convertSummaryTimeUsingString:dateValue WithDuration:_durationArray[fourtIndex]];
        self.completeBlock(infoDic);

    }
    [self.maskView removeFromSuperview];
}

-(NSArray *)formatOriArray:(NSArray *)oriArray{
    NSMutableArray *newArray = [NSMutableArray array];
    for (NSString *hourStr in oriArray) {
        NSString *tmpStr = [self removeLastChareacter:hourStr];
        [newArray addObject: [self append0IfNeed:tmpStr]];
    }
    return newArray;
}

-(NSString *)removeLastChareacter:(NSString *)oriString{
    return [oriString substringToIndex:oriString.length -1];
}

-(NSString *)append0IfNeed:(NSString *)oriString{
    if(oriString.length <2) return [NSString stringWithFormat:@"0%@", oriString];
    return oriString;
}

- (IBAction)cancelBtnAction:(id)sender {
    [self.maskView removeFromSuperview];
}

#pragma mark - pickerview data and delegate
-(void)initData{
    _dayArray = [MyTimeTool daysFromNowToDeadLine:self.deadLine];
    _showDayArray = [self genShowDayArrayByDayArray:_dayArray];
    _hourArray = [self validHourArray];
    _minuteArray = [self validMinuteArray];
    _durationArray=DURATIONARRAY;
    if ([self.deadLine integerValue] < 0) {
        [self pickerView:_pickerView didSelectRow:0 inComponent:0];
    }else{
        [self.pickerView selectRow:0 inComponent:0 animated:YES];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
        [self.pickerView selectRow:1 inComponent:3 animated:YES];
    }

}

-(NSArray *)genShowDayArrayByDayArray:(NSArray *)dayArray{
    NSInteger arrayCount = dayArray.count;
    if(arrayCount == 1 || arrayCount == 0) return ONEDAYARRAY;
    if(arrayCount == 2) return TWODAYARRAY;
    if(arrayCount == 3) return THREEDAYARRAY;
    NSMutableArray *showDayArray = [NSMutableArray arrayWithArray:THREEDAYARRAY];
    NSArray *tmpArray = [dayArray subarrayWithRange:NSMakeRange(3, arrayCount - 3)];
    for (int i = 0; i< tmpArray.count; i++) {
        [showDayArray addObject:[MyTimeTool displayedSummaryTimeUsingString:tmpArray[i]]];
    }
    return showDayArray;
}

-(NSArray *)validHourArray{
    int startIndex = [MyTimeTool currentDateHour];
    if ([MyTimeTool currentDateMinute]+30>= 45) startIndex++;
    if (startIndex<9) {
        startIndex=0;
    }else{
        startIndex=startIndex-9;
    }
    return [self.deadLine integerValue] > 0 ? [HOURARRAY subarrayWithRange:NSMakeRange(startIndex, HOURARRAY.count - startIndex)] : [HOURARRAY subarrayWithRange:NSMakeRange(0, startIndex + 1)];
}

-(NSArray *)validMinuteArray{
    
    int cminute=[MyTimeTool currentDateMinute];
    if(cminute<=15){
        cminute=45;
    }else if (cminute<=30){
        cminute=0;
    }else if(cminute<=45){
        cminute=15;
    }else if(cminute<=60){
        cminute=30;
    }else{
        cminute=0;
    }
    int startIndex = cminute/ INTERVALMINUTE;
//    if ([MyTimeTool currentDateMinute]+30>= 45) startIndex = 0;
    return [self.deadLine integerValue] > 0 ? [MINUTEARRAY subarrayWithRange:NSMakeRange(startIndex, MINUTEARRAY.count - startIndex)] : [MINUTEARRAY subarrayWithRange:NSMakeRange(0, startIndex + 1)];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return self.showDayArray.count;
            break;
        case 1:
            return self.hourArray.count;
        case 2:
            return self.minuteArray.count;
        case 3:
            return self.durationArray.count;
        default:
            return 0;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSInteger firstComponentSelectedRow = [self.pickerView selectedRowInComponent:0];
    if (firstComponentSelectedRow == 0) {
        _hourArray = [self validHourArray];
        _minuteArray =[self validMinuteArray];
        NSInteger secondComponentSelectedRow = [self.pickerView selectedRowInComponent:1];
        if (([self.deadLine integerValue] > 0 && secondComponentSelectedRow == 0)
            || ([self.deadLine integerValue] < 0 && secondComponentSelectedRow == self.hourArray.count - 1)
            || component ==0) {
            _minuteArray = [self validMinuteArray];
            //            if(component == 1) [self.pickerView selectRow:0 inComponent:2 animated:YES];
        }else{
            _minuteArray = MINUTEARRAY;
        }
    }else{
        _hourArray = HOURARRAY;
        _minuteArray = MINUTEARRAY;
    }
    [self.pickerView reloadAllComponents];
    
    //当第一列滑到第一个位置时，第二，三列滚回到0位置
    if(component == 0){
        if ([self.deadLine integerValue] < 0 && !firstComponentSelectedRow){
            [self.pickerView selectRow:self.hourArray.count - 1 inComponent:1 animated:YES];
            [self.pickerView selectRow:self.minuteArray.count - 1 inComponent:2 animated:YES];
        } else if([self.deadLine integerValue]>0 && !firstComponentSelectedRow){
            [self.pickerView selectRow:1 inComponent:3 animated:YES];
        }else{
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            [self.pickerView selectRow:2 inComponent:2 animated:YES];
        }
    }
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label;
    if (view) {
        label = (UILabel *)view;
    }else{
        label = [[UILabel alloc] init];
    }
    label.textAlignment = NSTextAlignmentCenter;
    switch (component) {
        case 0:
            label.text = self.showDayArray[row];
            //            [label setBackgroundColor:[UIColor redColor]];
            break;
        case 1:
            label.text = self.hourArray[row];
            //            [label setBackgroundColor:[UIColor greenColor]];
            break;
        case 2:
            label.text = self.minuteArray[row];
            //            [label setBackgroundColor:[UIColor lightGrayColor]];
            break;
        case 3:
            label.text = [NSString stringWithFormat:@"%@小时",self.durationArray[row]];
            //            [label setBackgroundColor:[UIColor lightGrayColor]];
            break;
        default:
            break;
    }
    
    return label;
}

//view的宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return self.frame.size.width / 4.0;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}


@end
