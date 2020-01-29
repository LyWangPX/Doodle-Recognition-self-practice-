//
//  extensions.swift
//  FinalProject
//
//  Created by Yifan Wang on 2019/11/28.
//  Copyright © 2019 Yifan Wang. All rights reserved.
//

import Foundation
import UIKit

let labels =
    ["airplane",
     "alarm clock",
     "ambulance",
     "angel",
     "animal migration",
     "ant",
     "anvil",
     "apple",
     "arm",
     "asparagus",
     "axe",
     "backpack",
     "banana",
     "bandage",
     "barn",
     "baseball",
     "baseball bat",
     "basket",
     "basketball",
     "bat",
     "bathtub",
     "beach",
     "bear",
     "beard",
     "bed",
     "bee",
     "belt",
     "bench",
     "bicycle",
     "binoculars",
     "bird",
     "birthday cake",
     "blackberry",
     "blueberry",
     "book",
     "boomerang",
     "bottlecap",
     "bowtie",
     "bracelet",
     "brain",
     "bread",
     "bridge",
     "broccoli",
     "broom",
     "bucket",
     "bulldozer",
     "bus",
     "bush",
     "butterfly",
     "cactus",
     "cake",
     "calculator",
     "calendar",
     "camel",
     "camera",
     "camouflage",
     "campfire",
     "candle",
     "cannon",
     "canoe",
     "car",
     "carrot",
     "castle",
     "cat",
     "ceiling fan",
     "cell phone",
     "cello",
     "chair",
     "chandelier",
     "church",
     "circle",
     "clarinet",
     "clock",
     "cloud",
     "coffee cup",
     "compass",
     "computer",
     "cookie",
     "cooler",
     "couch",
     "cow",
     "crab",
     "crayon",
     "crocodile",
     "crown",
     "cruise ship",
     "cup",
     "diamond",
     "dishwasher",
     "diving board",
     "dog",
     "dolphin",
     "donut",
     "door",
     "dragon",
     "dresser",
     "drill",
     "drums",
     "duck",
     "dumbbell",
     "ear",
     "elbow",
     "elephant",
     "envelope",
     "eraser",
     "eye",
     "eyeglasses",
     "face",
     "fan",
     "feather",
     "fence",
     "finger",
     "fire hydrant",
     "fireplace",
     "firetruck",
     "fish",
     "flamingo",
     "flashlight",
     "flip flops",
     "floor lamp",
     "flower",
     "flying saucer",
     "foot",
     "fork",
     "frog",
     "frying pan",
     "garden",
     "garden hose",
     "giraffe",
     "goatee",
     "golf club",
     "grapes",
     "grass",
     "guitar",
     "hamburger",
     "hammer",
     "hand",
     "harp",
     "hat",
     "headphones",
     "hedgehog",
     "helicopter",
     "helmet",
     "hexagon",
     "hockey puck",
     "hockey stick",
     "horse",
     "hospital",
     "hot air balloon",
     "hot dog",
     "hot tub",
     "hourglass",
     "house",
     "house plant",
     "hurricane",
     "ice cream",
     "jacket",
     "jail",
     "kangaroo",
     "key",
     "keyboard",
     "knee",
     "ladder",
     "lantern",
     "laptop",
     "leaf",
     "leg",
     "light bulb",
     "lighthouse",
     "lightning",
     "line",
     "lion",
     "lipstick",
     "lobster",
     "lollipop",
     "mailbox",
     "map",
     "marker",
     "matches",
     "megaphone",
     "mermaid",
     "microphone",
     "microwave",
     "monkey",
     "moon",
     "mosquito",
     "motorbike",
     "mountain",
     "mouse",
     "moustache",
     "mouth",
     "mug",
     "mushroom",
     "nail",
     "necklace",
     "nose",
     "ocean",
     "octagon",
     "octopus",
     "onion",
     "oven",
     "owl",
     "paint can",
     "paintbrush",
     "palm tree",
     "panda",
     "pants",
     "paper clip",
     "parachute",
     "parrot",
     "passport",
     "peanut",
     "pear",
     "peas",
     "pencil",
     "penguin",
     "piano",
     "pickup truck",
     "picture frame",
     "pig",
     "pillow",
     "pineapple",
     "pizza",
     "pliers",
     "police car",
     "pond",
     "pool",
     "popsicle",
     "postcard",
     "potato",
     "power outlet",
     "purse",
     "rabbit",
     "raccoon",
     "radio",
     "rain",
     "rainbow",
     "rake",
     "remote control",
     "rhinoceros",
     "river",
     "roller coaster",
     "rollerskates",
     "sailboat",
     "sandwich",
     "saw",
     "saxophone",
     "school bus",
     "scissors",
     "scorpion",
     "screwdriver",
     "sea turtle",
     "see saw",
     "shark",
     "sheep",
     "shoe",
     "shorts",
     "shovel",
     "sink",
     "skateboard",
     "skull",
     "skyscraper",
     "sleeping bag",
     "smiley face",
     "snail",
     "snake",
     "snorkel",
     "snowflake",
     "snowman",
     "soccer ball",
     "sock",
     "speedboat",
     "spider",
     "spoon",
     "spreadsheet",
     "square",
     "squiggle",
     "squirrel",
     "stairs",
     "star",
     "steak",
     "stereo",
     "stethoscope",
     "stitches",
     "stop sign",
     "stove",
     "strawberry",
     "streetlight",
     "string bean",
     "submarine",
     "suitcase",
     "sun",
     "swan",
     "sweater",
     "swing set",
     "sword",
     "t-shirt",
     "table",
     "teapot",
     "teddy-bear",
     "telephone",
     "television",
     "tennis racquet",
     "tent",
     "The Eiffel Tower",
     "The Great Wall of China",
     "The Mona Lisa",
     "tiger",
     "toaster",
     "toe",
     "toilet",
     "tooth",
     "toothbrush",
     "toothpaste",
     "tornado",
     "tractor",
     "traffic light",
     "train",
     "tree",
     "triangle",
     "trombone",
     "truck",
     "trumpet",
     "umbrella",
     "underwear",
     "van",
     "vase",
     "violin",
     "washing machine",
     "watermelon",
     "waterslide",
     "whale",
     "wheel",
     "windmill",
     "wine bottle",
     "wine glass",
     "wristwatch",
     "yoga",
     "zebra",
     "zigzag"]
extension UIImage {
    
    public convenience init(view: UIView) {
        // draw view in context
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        // get image, return
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
    
    func resize(newSize: CGSize) -> UIImage {
        // create context - make sure we are on a 1.0 scale
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0);
        
        // draw with new size, get image, and return
        draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return newImage!
    }
    
    func image(byDrawingImage image: UIImage, inRect rect: CGRect) -> UIImage! {
        UIGraphicsBeginImageContext(size)
        
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image.draw(in: rect)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    func toCVPixelBuffer(size:Int = 28) -> CVPixelBuffer? {
        // create gray scale pixel buffer
        var optionalPixelBuffer: CVPixelBuffer?
        guard CVPixelBufferCreate(kCFAllocatorDefault, size, size, kCVPixelFormatType_OneComponent8, nil, &optionalPixelBuffer) == kCVReturnSuccess else {
            return nil
        }
        
        guard let pixelBuffer = optionalPixelBuffer else {
            return nil
        }
        
        // draw image in pixel buffer
        CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
        let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let context = CGContext(data: baseAddress, width: size, height: size, bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer), space: colorSpace, bitmapInfo: 0)
        context!.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size, height: size))
        CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)
        
        return pixelBuffer
    }
    
    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage! {
        let context = CIContext(options: nil)
        return context.createCGImage(inputImage, from: inputImage.extent)
    }
    
    func test(inputImage:UIImage){
        print(inputImage.size)
    }
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 500, height: 500)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    func inverseImage(cgResult: Bool) -> UIImage? {
        let coreImage = UIKit.CIImage(image: self)
        guard let filter = CIFilter(name: "CIColorInvert") else { return nil }
        filter.setValue(coreImage, forKey: kCIInputImageKey)
        guard let result = filter.value(forKey: kCIOutputImageKey) as? UIKit.CIImage else { return nil }
        if cgResult { // I've found that UIImage's that are based on CIImages don't work with a lot of calls properly
            return UIImage(cgImage: CIContext(options: nil).createCGImage(result, from: result.extent)!)
        }
        return UIImage(ciImage: result)
    }
    
    
}
