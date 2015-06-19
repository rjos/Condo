//
//  QrCodeCreateViewController.swift
//  Condo
//
//  Created by eduardo leite soares neto on 6/19/15.
//  Copyright (c) 2015 Condo. All rights reserved.
//
import UIKit
import CondoModel
import AssetsLibrary

class QrCodeCreateViewController:UIViewController{
    @IBOutlet weak var textField:UITextField!
    @IBOutlet weak var imgQRCode:UIImageView!
    @IBOutlet weak var imgQRCode2:UIImageView!
    @IBOutlet weak var btnAction:UIButton!
    @IBOutlet weak var slider: UISlider!
    var qrcodeImage: CIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBAction func performButtonAction(sender: AnyObject){
        
        if qrcodeImage == nil {
            if textField.text == "" {
                return
            }
            let data = textField.text.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("Q", forKey: "inputCorrectionLevel")
            
            qrcodeImage = filter.outputImage
            
            displayQRCodeImage(filter.outputImage)
            //displayQRCodeImage()
            btnAction.setTitle("Clear", forState: UIControlState.Normal)
            
        }
        else {
            imgQRCode.image = nil
            qrcodeImage = nil
            btnAction.setTitle("Generate", forState: UIControlState.Normal)
        }
        textField.enabled = !textField.enabled
        slider.hidden = !slider.hidden
        
    }
    @IBAction func changeImageViewScale(sender: AnyObject){
        imgQRCode.transform = CGAffineTransformMakeScale(CGFloat(slider.value), CGFloat(slider.value))
    }
    func displayQRCodeImage(image: CIImage) {
        let context = CIContext(options:[kCIContextUseSoftwareRenderer : true])
        let trueImage: CGImage = context.createCGImage(image, fromRect: image.extent())
        
        let scaleX = imgQRCode.frame.size.width / qrcodeImage.extent().size.width
        let scaleY = imgQRCode.frame.size.height / qrcodeImage.extent().size.height
        
        let transformedImage = qrcodeImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        let image = UIImage(CIImage: transformedImage)
        imgQRCode.image = image
        saveImage(trueImage)
        //saveImage(UIImage(CIImage: transformedImage)!)
        
    }
    
    func saveImage(image: CGImage) {
        let orientation = ALAssetOrientation.Up
        let test = ALAssetsLibrary()
        test.writeImageToSavedPhotosAlbum(image,
            orientation: orientation,
            completionBlock:{ (path:NSURL!, error:NSError!) -> Void in
                println("Path \(path) Error\(error)")
        })
        
    }
    
    //    func saveImage (image: UIImage) -> Bool{
    //
    ////        let pngImageData = UIImagePNGRepresentation(image)
    ////        NSLog("%@",path)
    ////        var jpgImageData:NSData!
    ////        jpgImageData = UIImageJPEGRepresentation(imgQRCode.image, 1.0)   // if you want to save as JPEG
    ////        let result = jpgImageData.writeToFile(path, atomically: true)
    //
    //        let test = ALAssetsLibrary()
    //        let cgImage = image.CGImage
    //        let orientation = ALAssetOrientation(rawValue: image.imageOrientation.rawValue)!
    //
    //        test.writeImageToSavedPhotosAlbum(cgImage,
    //            orientation: orientation,
    //            completionBlock:{ (path:NSURL!, error:NSError!) -> Void in
    //                println("Path \(path) Error\(error)")
    //        })
    //        //test.writeImageToSavedPhotosAlbum(ciImage, orientation: orientation, compl
    //        return true
    //
    //    }
    func documentsDirectory() -> String {
        let documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
        return documentsFolderPath
    }
}

