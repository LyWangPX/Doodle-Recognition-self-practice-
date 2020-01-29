//
//  ViewController.swift
//  FinalProject
//
//  Created by Yifan Wang on 2019/11/28.
//  Copyright © 2019 Yifan Wang. All rights reserved.
//

import UIKit
import PencilKit
import CoreML

@IBDesignable class ViewController: UIViewController {
    private let model = DrawnImageClassifier()
    
    //preset color plate
    //for theme [NOT ENABLED]
    let colorPlate = [
        "red":UIColor(displayP3Red: 113 / 255, green: 13 / 255, blue: 37 / 255, alpha: 1),
        "pink":UIColor(displayP3Red: 250 / 255, green: 49 / 255, blue: 101 / 255, alpha: 1),
        "lightBlue":UIColor(displayP3Red: 72 / 255, green: 118 / 255, blue: 134 / 255, alpha: 1),
        "darkBlue":UIColor(displayP3Red: 19 / 255, green: 51 / 255, blue: 76 / 255, alpha: 1),
        "backgroundBlue":UIColor(displayP3Red: 9 / 255, green: 25 / 255, blue: 48 / 255, alpha: 1)
    ]
    var labelNames = [String]()
    var JPLabelNames = [String]()
    var LabelBeta = [String]()
    var top5:ArraySlice<(key: String, value: Double)>!
    var challenge = String(){
        willSet{
            let challengeString = returnAttributedStrings(string: "これを描いてみて:  " + newValue, success: false)
            challengeLabel.attributedText = challengeString
        }
    }
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var challengeLabel: UILabel!
    @IBOutlet weak var probability: UILabel!
    @IBOutlet weak var prediction: UILabel!
    @IBOutlet weak var judgment:UILabel!
    @IBOutlet weak var explanation:UILabel!
    
    @IBAction func refresh(_ sender: UIButton) {
        updateChallenge()
        freshup()
    }
    
    func freshup(){
        canvasView.drawing = PKDrawing()
        prediction.text = ""
        probability.text = ""
        judgment.text = ""
        explanation.text = ""
    }
    // drawing size
    let drawSize = CGFloat(500)
    var PKRect:CGRect!
    var canvasView:PKCanvasView!
    override func viewDidLoad() {
        super.viewDidLoad()
        PKRect = CGRect(x: (view.frame.size.width - drawSize ) / 2, y:(view.frame.size.height - drawSize)/2, width: drawSize, height: drawSize)
        canvasView = PKCanvasView(frame: PKRect)
        view.backgroundColor = #colorLiteral(red: 0.03712524474, green: 0.0591712147, blue: 0.09289320558, alpha: 1)
        canvasView.backgroundColor = .black
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.layer.borderWidth = 5
        canvasView.layer.borderColor = #colorLiteral(red: 0.07344979793, green: 0.8984792233, blue: 0.9565586448, alpha: 1)
        canvasView.layer.cornerRadius = 40
        view.addSubview(canvasView)
        //Set up navigation bar
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor.black
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        
        if JPLabelNames.isEmpty{
            prepareText()
        }
        if LabelBeta.isEmpty{
            prepareTextBeta()
        }
        updateChallenge()
        
    }
    
    func updateChallenge(){
        challenge = (JPLabelNames.randomElement() ?? "we met nil LOL")
    }
    
    func prepareText(){
        //  Loading labels and results
        let names = ["labels", "labels.en.ja"]
        for name in names{
            if let path = Bundle.main.path(forResource: name, ofType: "txt") {
                do {
                    let data = try String(contentsOfFile: path, encoding: .utf8)
                    let labelNames = data.components(separatedBy: .newlines).filter { $0.count > 0 }
                    if name == "labels"{
                        self.labelNames.append(contentsOf: labelNames)
                    }else{
                        self.JPLabelNames.append(contentsOf: labelNames)
                    }
                } catch {
                    print("error loading labels: \(error)")
                }
            }
        }
    }
    
    func preprocessImage(beta:Bool = false) -> UIImage
    {
        /*
         This function is written  to do two things:
         1. Add a black square as a background
         2. Redraw the object with correct location and ratio
         3. If the object is too small, scale it
         4. [DELETED] if the object is passed to a model not trained on black
         based picture, inverse all pixel information inside of it
         */
        
        var image = canvasView.drawing.image(from: canvasView.drawing.bounds, scale: 10.0)
        if let newImage = UIImage(color: .black, size: CGSize(width: 500/2, height: 500/2)){
            var newWidth = image.size.width
            var newHeight = image.size.height
            let ratio = image.size.width / image.size.height
            if max(newWidth, newHeight) < 400 || min(newWidth, newHeight) > 420{
                if ratio > 1{
                    // wider
                    newWidth = 420
                    newHeight = newWidth / ratio
                } else{
                    newHeight = 420
                    newWidth = newHeight / ratio
                }
            }
            if let overlayedImage = newImage.image(byDrawingImage: image, inRect: CGRect(x: newImage.size.width/2 - newWidth/2, y: newImage.size.height/2 - newHeight/2, width: newWidth, height: newHeight)){
                image = overlayedImage
            }
        }
        if beta{
            image = image.inverseImage(cgResult: true)!
        }
        
        return image
    }
    
    func prepareTextBeta(){
        
        self.LabelBeta = labels
    }
    
    @IBAction func cameraDetect(){
        //create function to share the screenshot with airdrop
        
        let imageToShare = self.view.toImage()
        
        let activityItems : NSMutableArray = []
        activityItems.add(imageToShare)
        
        let activityVC = UIActivityViewController(activityItems:activityItems as [AnyObject] , applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = super.view
        self.present(activityVC, animated: true, completion: {print("shit")})
    }
    
    @IBAction func detectImage() {
        let image = preprocessImage()
        predictImage(image: image)
    }
    
    @IBAction func clear() {
        canvasView.drawing = PKDrawing()
        prediction.text = ""
        probability.text = ""
        judgment.text = ""
        explanation.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard
            let window = view.window,
            let toolPicker = PKToolPicker.shared(for: window) else { return }
        
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
    
    func toJapanese(from top5: ArraySlice<(key: String, value: Double)>, beta:Bool = false) -> [String] {
        //original label is not english, translate it using position detection
        var indices = top5.map{labelNames.firstIndex(of: $0.key)}
        if beta{
            indices = top5.map{LabelBeta.firstIndex(of: $0.key)}
        }
        var result = [String]()
        if beta{
            for index in indices{
                result.append(self.LabelBeta[index!])
            }
        } else{
            for index in indices{
                result.append(JPLabelNames[index!])
            }
        }
        print(top5)
        print(result)
        return result
    }
    
    func returnAttributedStrings(string: String, success:Bool = false) -> NSAttributedString{
        // this is one of the most tangled functio in this program
        // it is responsible for setting all colors of strings that
        // needs to be printed out
        let largeAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        let contrastAttributes = [NSAttributedString.Key.foregroundColor: colorPlate["pink"], NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]
        let successAttributes = [NSAttributedString.Key.foregroundColor: colorPlate["pink"]]
        let attributedSentence = NSMutableAttributedString(string: string)
        if string.contains(":"){
            attributedSentence.setAttributes(largeAttributes, range: NSRange(location: 0, length: string.indexDistance(of: ":")!))
            attributedSentence.setAttributes(contrastAttributes as [NSAttributedString.Key : Any], range: NSRange(location: string.indexDistance(of: ":")! + 1, length: string.count - string.indexDistance(of: ":")! - 1))
        }else{
            if success{
                attributedSentence.setAttributes(successAttributes as [NSAttributedString.Key : Any], range: NSRange(location: string.indexDistance(of: challenge.first!)!, length: challenge.count))
            }
            attributedSentence.setAttributes(largeAttributes, range: NSRange(location: 0, length: string.indexDistance(of: " ")!))
        }
        return attributedSentence
    }
    
    
    func predictImage(image: UIImage, advanced:Bool = false){
        // resize picture, set pixelBuffer and send it to model
        let resized = image.resize(newSize: CGSize(width: 28, height: 28))
        
        guard let pixelBuffer = resized.toCVPixelBuffer() else {
            print("couldn't create pixel buffer")
            return
        }
        
        do {
            var success = false
            let output = try model.prediction(image: pixelBuffer)
            let sorted = output.category_softmax_scores.sorted { $0.value > $1.value }
            self.top5 = sorted.prefix(9)
            let predictString = "予測  \n\n" + toJapanese(from: top5).joined(separator:
                "\n\n")
            let probString = "自信度  \n\n" + top5.map {String(100 * $0.value).prefix(4) + "%"}
                .joined(separator: "\n\n")
            
            if predictString.contains(challenge){
                success = true
            }
            if success {
                judgment.text = "成  功"
                judgment.textColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
                judgment.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                explanation.text = "君は絵の神だ！"
                explanation.textColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
                explanation.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            } else {
                judgment.text = "残  念"
                judgment.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                judgment.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                explanation.text = "俺のAIのせいだ、気にしない"
                explanation.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                explanation.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
            let attributedPredictString = returnAttributedStrings(string: predictString, success:success)
            let attributedProbString = returnAttributedStrings(string: probString, success:false)
            
            prediction.attributedText = attributedPredictString
            probability.attributedText = attributedProbString
            
        }
        catch {
            print("error making prediction: \(error)")
        }
    }
}


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension StringProtocol {
    func indexDistance(of element: Element) -> Int? { firstIndex(of: element)?.distance(in: self) }
    func indexDistance<S: StringProtocol>(of string: S) -> Int? { range(of: string)?.lowerBound.distance(in: self) }
}

extension String.Index {
    func distance<S: StringProtocol>(in string: S) -> Int { string.distance(from: string.startIndex, to: self) }
}
//UIView extension which converts the UIView into an image.
extension UIView {
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)

        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
