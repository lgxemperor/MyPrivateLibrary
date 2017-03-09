//
//  DBTextField.h
//  toHomeMerchant
//
//  Created by emperor on 16/4/16.
//  Copyright © 2016年 sdj. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DBTextFieldDelegate <UITextFieldDelegate>
@optional
- (void)textFieldDidDeleteBackward:(UITextField *)textField;
@end
@interface DBTextField : UITextField
@property(nonatomic,assign)IBOutlet id<DBTextFieldDelegate>keyInputDelegate;
@end
