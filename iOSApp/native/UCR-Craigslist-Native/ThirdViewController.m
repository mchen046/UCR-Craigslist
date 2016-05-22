//
//  ThirdViewController.m
//  UCR-Craigslist-Native
//
//  Created by Michael Chen on 5/1/16.
//  Copyright © 2016 UCR. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController
@synthesize catPicker, titleField, priceField, descView, categories, category, titleName, price, desc;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //keyboard dismiss: http://stackoverflow.com/a/5711504
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    //set UITextField and UITextView BG Color
    //[titleField setBackgroundColor:[UIColor blackColor]];
    //[priceField setBackgroundColor:[UIColor blackColor]];
    //[descView setBackgroundColor:[UIColor blackColor]];
    
    //set placeholder text color
    UIColor *color = [UIColor lightGrayColor];
    titleField.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"enter a title" attributes:@{NSForegroundColorAttributeName:color}];
    priceField.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"enter a price" attributes:@{NSForegroundColorAttributeName:color}];
    
    //set delegates
    titleField.delegate = self;
    priceField.delegate = self;
    descView.delegate = self;
    
    catPicker.delegate = self;
    catPicker.dataSource = self;
    
    categories = @[@"Books", @"Clothing", @"Electronics", @"Furniture", @"Household", @"Leases", @"Music", @"Pets", @"Services", @"Tickets", @"Vehicles", @"Other"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard { //http://stackoverflow.com/a/5711504
    [titleField resignFirstResponder];
    [priceField resignFirstResponder];
    [descView resignFirstResponder];
}

//UIPickerView setup http://stackoverflow.com/questions/13756591/how-would-i-set-up-a-uipickerview
// http://www.techotopia.com/index.php/An_iOS_7_UIPickerView_Example#UIPickerView_Delegate_and_DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 12;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return categories[row];
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    category = categories[row];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"descView.text: %@", descView.text);
    if(textView == descView && [descView.text isEqualToString:@"enter a description"]){
        NSLog(@"descView.text: %@", descView.text);
        descView.text = @"";
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)writeToDB{
   
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    //courtesy popup
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:[NSString stringWithFormat:@"Photo chosen!"]
                                message:@"Please continue with your submission."
                                preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    //button creation and function (handler)
    UIAlertAction* actionOk = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {}];
    
    [alert addAction:actionOk];

    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //UIImage *newImage = image;
    
    
    
}

- (IBAction)chooseButton:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:imagePickerController animated:YES];
}

- (IBAction)takeButton:(id)sender {
    pickerCamera = [[UIImagePickerController alloc] init];
    pickerCamera.delegate = self;
    [pickerCamera setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:pickerCamera animated:YES completion:NULL];
}

- (IBAction)submitButton:(id)sender {
    // write to the db
    
    //courtesy popup
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:[NSString stringWithFormat:@"Submitted!"]
                                message:@"Thank you for your submission."
                                preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    //button creation and function (handler)
    UIAlertAction* actionOk = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {}];
    
    [alert addAction:actionOk];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    // store image here into blob data
    //image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //[imageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
