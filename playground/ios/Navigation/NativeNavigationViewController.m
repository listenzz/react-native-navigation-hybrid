//
//  NativeNavigationViewController.m
//  Navigation
//
//  Created by Listen on 2017/11/26.
//  Copyright © 2017年 Listen. All rights reserved.
//

#import "NativeNavigationViewController.h"

@interface NativeNavigationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *popToRootButton;

@end

@implementation NativeNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.popToRootButton.enabled = [self.navigator canPop];
    self.title = @"navigation";
    self.navigationItem.title = self.title;
}

- (IBAction)pushToNative:(UIButton *)sender {
    [self.navigator pushModule:@"NativeNavigation"];
}

- (IBAction)pushToRN:(UIButton *)sender {
    
}

- (IBAction)popToRoot:(UIButton *)sender {
    [self.navigator popToRootAnimated:YES];
}

- (IBAction)requestFromRN:(UIButton *)sender {
    
}

- (IBAction)requestFromNative:(UIButton *)sender {
    [self.navigator presentModule:@"NativeResult" requestCode:1];
}

- (void)didReceiveResultCode:(NSInteger)resultCode resultData:(NSDictionary *)data requestCode:(NSInteger)requestCode {
    [super didReceiveResultCode:resultCode resultData:data requestCode:requestCode];
    if (requestCode == 1) {
        if (resultCode == RESULT_OK) {
            if (!data) {
                data = @{};
            }
            _resultLabel.text = [NSString stringWithFormat:@"result:%@", data[@"text"]];
        } else {
            _resultLabel.text = @"ACTION CANCEL";
        }
    }
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
