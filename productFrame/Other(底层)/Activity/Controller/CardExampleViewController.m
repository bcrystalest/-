//
//  CardExampleViewController.m
//  productFrame
//
//  Created by admin on 2017/12/28.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "CardExampleViewController.h"
#import <Stripe/Stripe.h>

@interface CardExampleViewController ()<STPPaymentCardTextFieldDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) STPPaymentCardTextField *paymentTextField;
@property (weak, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) UIScrollView *scrollView;

@end

@implementation CardExampleViewController

//- (void)loadView {
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT + 68)];
//    scrollView.delegate = self;
//    scrollView.alwaysBounceVertical = YES;
//    scrollView.backgroundColor = [UIColor whiteColor];
//    self.view = scrollView;
//    self.scrollView = scrollView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Card";
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self setNavigationBarTitle:@"cardPay" color:[UIColor blackColor] font:[UIFont systemFontOfSize:14] withPopButton:YES];

    [self setRightButtonWithType:onlyText andTitle:@"pay" andImage:[UIImage imageNamed:@""] andTextFont:15];
    
//    UIBarButtonItem *buyButton = [[UIBarButtonItem alloc] initWithTitle:@"Pay" style:UIBarButtonItemStyleDone target:self action:@selector(pay)];
//    buyButton.enabled = NO;
//    self.navigationItem.rightBarButtonItem = buyButton;
//
    STPPaymentCardTextField *paymentTextField = [[STPPaymentCardTextField alloc] init];
    paymentTextField.delegate = self;
    paymentTextField.cursorColor = [UIColor purpleColor];
    paymentTextField.postalCodeEntryEnabled = YES;
    self.paymentTextField = paymentTextField;
    [self.view addSubview:paymentTextField];
//
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator = activityIndicator;
    [self.view addSubview:activityIndicator];
    
}

-(void)rightClickAction{
    [self pay];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat padding = 15;
    CGFloat width = CGRectGetWidth(self.view.frame) - (padding*2);
    CGRect bounds = self.view.bounds;
    self.paymentTextField.frame = CGRectMake(padding, 80, width, 44);
    self.activityIndicator.center = CGPointMake(CGRectGetMidX(bounds),CGRectGetMaxY(self.paymentTextField.frame) + 160);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.paymentTextField becomeFirstResponder];
}

- (void)paymentCardTextFieldDidChange:(nonnull STPPaymentCardTextField *)textField {
    self.navigationItem.rightBarButtonItem.enabled = textField.isValid;
}

- (void)pay{
    if (![self.paymentTextField isValid]) {
        return;
    }
    if (![Stripe defaultPublishableKey]) {
//        [self.delegate exampleViewController:self didFinishWithMessage:@"Please set a Stripe Publishable Key in Constants.m"];
        return;
    }
    [self.activityIndicator startAnimating];
    [[STPAPIClient sharedClient] createTokenWithCard:self.paymentTextField.cardParams
                                          completion:^(STPToken *token, NSError *error) {
//                                              if (error) {
//                                                  [self.delegate exampleViewController:self didFinishWithError:error];
//                                              }
//                                              [self.delegate createBackendChargeWithSource:token.tokenId completion:^(STPBackendChargeResult result, NSError *error) {
//                                                  if (error) {
//                                                      [self.delegate exampleViewController:self didFinishWithError:error];
//                                                      return;
//                                                  }
//                                                  [self.delegate exampleViewController:self didFinishWithMessage:@"Payment successfully created"];
//                                              }];
                                          }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
