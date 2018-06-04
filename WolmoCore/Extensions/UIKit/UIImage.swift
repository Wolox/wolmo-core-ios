//
//  UIImage.swift
//  WolmoCore
//
//  Created by Nahuel Gladstein on 6/8/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import UIKit

public extension UIImage {
    
    /**
     Returns a resized copy of the image, with cornerRadius if used.
     
     - parameter toSize: The wanted size to fit the new image in.
     - parameter maintainAspectRatio: Determines if the resulting image will keep the aspect ratio of the original image, 
            If set to true the size of the resulting image will be the closest smaller size to the one specified that maintains the aspect ratio of the original image.
            If set to false it will stretch the image to fill the size specified.
     - parameter useScreenScale: Determines if the screen scale will be used when creating the image context. Default: true.
        Set to true if you want to make the size relative to the scale of the screen 
            (So the resized image looks the same relative size on all devices, you probably want this if you're showing the resized image).
        Set to false if you want the size to be actual pixels 
            (This is useful to generate a resized image of a particular size in real pixels to send to API regardless of the device screen scale).
     - parameter cornerRadius: The cornerRadius to be used. Any number lower or equal to zero will not add cornerRadius. Default: 0.0, no corner radius.
     
     */
    
    public func resized(toSize: CGSize, maintainAspectRatio: Bool, useScreenScale: Bool = true, cornerRadius: CGFloat = 0.0, insets: UIEdgeInsets = .zero) -> UIImage {
        let newSize = maintainAspectRatio ? size.resizedMaintainingRatio(wantedSize: toSize) : toSize
        let scale: CGFloat = useScreenScale ? 0.0 : 1.0
        let imageRect = CGRect(origin: CGPoint.zero, size: newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        if cornerRadius > 0 {
            let path = UIBezierPath(roundedRect: imageRect, cornerRadius: cornerRadius)
            path.addClip()
        }
        resizableImage(withCapInsets: capInsets).draw(in: imageRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }

    
    /**
     Returns the aspect ratio of the image represented by a CGFloat. 
        For example an image with a 4:3 ratio will give 1.333... as output.
     */
    
    public var aspectRatio: CGFloat {
        return size.width / size.height
    }

}

fileprivate extension CGSize {

    /**
     Returns a resized copy of the size maintaining it's aspect ratio.
     
     - parameter wantedSize: The wanted new size to fit.
     Note that the size of the resulting CGSize will be the smaller closest size to the one specified that maintains the aspect ratio of the original.
     
     */
    
    fileprivate func resizedMaintainingRatio(wantedSize: CGSize) -> CGSize {
        let widthFactor = wantedSize.width / width
        let heightFactor = wantedSize.height / height
        let resizeFactor = min(heightFactor, widthFactor)
        
        return CGSize(width: width * resizeFactor, height: height * resizeFactor)
    }
    
}
