//
//  MyTimePicker.m
//  TimePicker
//
//  Created by App on 1/13/16.
//  Copyright © 2016 App. All rights reserved.
//

#import "MyDatePickerView.h"
#import "MyTimeTool.h"

#define HEIGHTCOUNT 0.5
#define INTERVALMINUTE 15



#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]  

typedef void(^CompleteBolck) (NSDictionary *);

@interface MyDatePickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;


- (IBAction)sureBtnAction:(id)sender;
- (IBAction)cancelBtnAction:(id)sender;

@property (nonatomic, strong) NSArray *dayArray;
@property (nonatomic, strong) NSArray *hourArray;
@property (nonatomic, strong) NSArray *minuteArray;

@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, assign) NSInteger columnIndex;
@property (nonatomic, assign) NSInteger rowIndex;

@property (nonatomic, copy) CompleteBolck completeBlock;
@property (nonatomic, copy) NSString *deadLine;

@end

@implementation MyDatePickerView



@synthesize intervalMinute = intervalMinute_;

+(instancetype)myDatePickerViewWithDeadLine:(NSString *)deadLine{
    MyDatePickerView *timePickerView = [[[NSBundle mainBundle] loadNibNamed:@"MyDatePickerView" owner:self options:nil] objectAtIndex:0];
    timePickerView.deadLine = deadLine;
    [timePickerView initData];
    return timePickerView;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
}



+(void)showDatePickerViewDeadLine:(NSString *)deadLine CompleteBlock:(void (^)(NSDictionary *))completeBlock{
    MyDatePickerView *timePickerView = [self myDatePickerViewWithDeadLine:deadLine];
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
        NSMutableString *dateValue = [[NSMutableString alloc] initWithFormat:@"%04ld",[_dayArray[firstIndex] integerValue]];
        [dateValue appendString:@"-"];
        [dateValue appendFormat:@"%02ld",[_hourArray[secodnIndex] integerValue]];
        [dateValue appendString:@"-"];
        [dateValue appendFormat:@"%02ld",[_minuteArray[thirdIndex] integerValue]];
//        [dateValue appendString:@" "];
//        [dateValue appendString:@"00:00:00"];
        infoDic[@"time_value"] = dateValue;
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
    _dayArray = [MyTimeTool yearsFromNow];
    _hourArray = [MyTimeTool monthsFromNow];
    _minuteArray = [MyTimeTool daysFromMonth:[_hourArray indexOfObject:[@([MyTimeTool currentMonth]) stringValue]] WithYear:[_dayArray indexOfObject:[@([MyTimeTool currentYear]) stringValue]]];
    [self.pickerView selectRow:[_dayArray indexOfObject:[@([MyTimeTool currentYear]) stringValue]] inComponent:0 animated:YES];
    [self.pickerView selectRow:[_hourArray indexOfObject:[@([MyTimeTool currentMonth]) stringValue]] inComponent:1 animated:YES];
    [self.pickerView selectRow:[_minuteArray indexOfObject:[@([MyTimeTool currentDay]) stringValue]] inComponent:2 animated:YES];
}



-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return self.dayArray.count;
        case 1:
            return self.hourArray.count;
        case 2:
            return self.minuteArray.count;
        default:
            return 0;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
        //当第一列滑到第一个位置时，第二，三列滚回到0位置
    switch (component) {
        case 0:
        {
             _hourArray = [MyTimeTool monthsFromNow];
        }
            break;
        case 1:
        {
            NSString *yearStr=[_dayArray objectAtIndex:[_pickerView selectedRowInComponent:0]];
            NSString *monthStr=[_hourArray objectAtIndex:[_pickerView selectedRowInComponent:1]];
           _minuteArray = [MyTimeTool daysFromMonth:[monthStr integerValue] WithYear:[yearStr integerValue]];
            [self.pickerView reloadComponent:2];
        }
            break;
            
        default:
            break;
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
            label.text = self.dayArray[row];
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
        default:
            break;
    }
    
    return label;
}

//view的宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return self.frame.size.width / 3.0;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}


@end
