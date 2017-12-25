//
//  scanViewController.h
//  productFrame
//
//  Created by 陈威利 on 2017/12/25.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, codeScannerType) {
    codeScannerTypeAll = 0,   //default, scan QRCode and barcode
    codeScannerTypeQRCode,    //scan QRCode only
    codeScannerTypeBarcode,   //scan barcode only
};

@interface codeScannerVC : UIViewController

@property (nonatomic, assign) codeScannerType scanType;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *tipStr;

@property (nonatomic, copy) void(^resultBlock)(NSString *value);

@end
