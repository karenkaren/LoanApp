//
//  ImagesManager.m
//  LingTouNiaoLoan
//
//  Created by LiuFeifei on 17/3/27.
//  Copyright © 2017年 LiuJie. All rights reserved.
//

#import "ImagesManager.h"
#import <AVFoundation/AVFoundation.h>

@interface ImagesManager()<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIViewController * viewController;
@property (nonatomic, strong) HandlerBlock finishBlock;

@end

@implementation ImagesManager

singleton_implementation(ImagesManager)

+ (void)uploadImageInController:(UIViewController *)controller block:(HandlerBlock)block
{
    [ImagesManager sharedImagesManager].viewController = controller;
    [ImagesManager sharedImagesManager].finishBlock = block;
    [[ImagesManager sharedImagesManager] callImagePicker];
}

// 调用图片选择器
- (void)callImagePicker {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"手机相册", nil];
    [sheet showInView:[GlobalManager keyWindow]];
}

#pragma mark action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex != 0 && buttonIndex != 1) return;
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            NSString * mediaType = AVMediaTypeVideo;//读取媒体类型
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                kTipAlert(@"请在iPhone的“设置－隐私－相机“选项中，允许”花无忧“访问你的相机");
            }
        } else {
            NSString *message = @"设备不支持拍照";
            [NSObject showMessage:message];
            return;
        }
    } else if (buttonIndex == 1) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        } else {
            return;
        }
    }
    
    if (self.viewController) {
        self.viewController.transitioningDelegate = nil;
        self.viewController.modalPresentationStyle = UIModalPresentationNone;
        [self.viewController presentViewController:picker animated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:true completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 退出图片选择控制器
    [picker dismissViewControllerAnimated:YES completion:nil];

    UIImage * image = info[UIImagePickerControllerEditedImage];
    [NSObject showWaitingIconInView:self.viewController.view];
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    int maxFileSize = 1000 * 1024;
    NSData * imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression)
    {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    //NSString * imageBody=[imageData base64EncodedStringWithOptions:0];

    NSDate * date = [NSDate date];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init]; //创建一个日期格式化器
    dateFormatter.dateFormat=@"yyyyMMddhhmmss";//指定转date得日期格式化形式
    NSString * fileName = [NSString stringWithFormat:@"%@.jpg", [dateFormatter stringFromDate:date]];
//    [[NetAPIManager sharedNetAPIManager] uploadFileWithData:imageData fileName:fileName mimeType:@"image/jpg" path:loanApply_upload params:nil methodType:Post autoShowError:YES block:^(id response, NSError *error) {
//        [NSObject dismissWaitingIconInView:self.viewController.view];
//        if (!error && self.finishBlock) {
//            self.finishBlock(response);
//        }
//    }];
}

@end
