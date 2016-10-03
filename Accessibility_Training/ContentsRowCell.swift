//
//  ContentsTableViewCell.swift
//  Accessibility Training
//
//  Created by Will Richardson on 9/27/16.
//  Copyright © 2016 Will Richardson. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class ContentsRowCell: BaseTableViewCell {
    
    let UrlTagConst = "UrlTag"
    var layoutManagerSetup: Bool = false
    var myLayoutManager: NSLayoutManager? = nil
    var myTextContainer: NSTextContainer? = nil
    var myTextStorage: NSTextStorage? = nil
    var urlCount: Int = 0
    var myAcessibilityElements: [UIAccessibilityElement] = [UIAccessibilityElement]()
    
    @IBOutlet var textContentsLabel: UILabel!
    // @IBOutlet var textContentsLabel: TTTAttributedLabel!
    
    override func configure(rowModel: BaseRow) {
        
        super.configure(rowModel: rowModel)
        
        // remove accessibility for label and cell
        // textContentsLabel.isAccessibilityElement = false
        // self.isAccessibilityElement = false
        
        // set default state
        textContentsLabel.isUserInteractionEnabled = false
        if let recognizers = textContentsLabel.gestureRecognizers {
            for recognizer in recognizers {
                textContentsLabel.removeGestureRecognizer(recognizer)
            }
        }
        var hasUrlContent = false
        
        if let contentRow = rowModel as? ContentRow {
            
            if contentRow.textContentsArray.count > 0 {
                
                let str = buildAttributedText(contentRow: contentRow, hasUrlContent: &hasUrlContent, forAcessibility: false)
                textContentsLabel.attributedText = str
                let a11yStr = buildAttributedText(contentRow: contentRow, hasUrlContent: &hasUrlContent, forAcessibility: true)
                textContentsLabel.accessibilityLabel = a11yStr.string
            }
        }
        
        buildAccessibilityElements()
        
        if hasUrlContent {
            
            // setupLayoutManger(attribString: textContentsLabel.attributedText!)
            textContentsLabel.isUserInteractionEnabled = true
            textContentsLabel.addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(handleTapOnLabel)))
        }
    }
    
    func buildAttributedText(contentRow: ContentRow, hasUrlContent: inout Bool, forAcessibility: Bool) -> NSAttributedString {
        
        let str: NSMutableAttributedString = NSMutableAttributedString(string: "")
        for contents in contentRow.textContentsArray {
            
            var linkTxt = ""
            let attrSegment: NSAttributedString
            switch contents.type {
            case ContentsType.String:
                attrSegment = NSAttributedString(string: contents.text)
                str.append(attrSegment)
            case ContentsType.URL:
                hasUrlContent = true
                urlCount += 1
                let urlContents = contents as! UrlContents
                if (forAcessibility) {
                    linkTxt = " ,link, "
                }
                let urlAttrib = [NSLinkAttributeName: urlContents.link, UrlTagConst + String(urlCount): true] as [String : Any]
                attrSegment = NSAttributedString(string: urlContents.text + linkTxt, attributes: urlAttrib)
                str.append(attrSegment)
            default:
                attrSegment = NSMutableAttributedString(string: "")
                str.append(attrSegment)
            }
        }
        return str
    }
    
    func contentRowModel() -> ContentRow {
        
        return baseRowModel as! ContentRow
    }
    
//    override func accessibilityElementCount() -> Int {
//        
//        if myAcessibilityElements.count < 1 {
//            
//            buildAccessibilityElements()
//        }
//        return myAcessibilityElements.count
//    }
//    
//    override func accessibilityElement(at index: Int) -> Any? {
//        
//        return myAcessibilityElements[index]
//    }
//    
//    override func index(ofAccessibilityElement element: Any) -> Int {
//        
//        let uiAccEle = element as! UIAccessibilityElement
//        return myAcessibilityElements.index(of: uiAccEle)!
//    }
//    
//    override var accessibilityElements: [Any]? {
//        get {
//            return myAcessibilityElements;
//        }
//        set {
//            
//        }
//    }
    
    func buildAccessibilityElements() {
        
        let contentRow = contentRowModel()
        for contents in contentRow.textContentsArray {
            
            let accElement: UIAccessibilityElement = UIAccessibilityElement(accessibilityContainer: self)
            accElement.accessibilityFrame = self.frame
            
            switch contents.type {
            case ContentsType.String:
                accElement.accessibilityTraits |= UIAccessibilityTraitStaticText;
                accElement.accessibilityLabel = contents.toAttribString().string
            case ContentsType.URL:
                accElement.accessibilityTraits |= UIAccessibilityTraitLink;
                accElement.accessibilityLabel = contents.toAttribString().string
            default:
                accElement.accessibilityTraits = UIAccessibilityTraitStaticText;
            }
            
            myAcessibilityElements.append(accElement)
        }
    }
    
    func setupLayoutManger(attribString: NSAttributedString) {
        
        if layoutManagerSetup {
            return
        }
        
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        myLayoutManager = NSLayoutManager()
        myTextContainer = NSTextContainer(size: textContentsLabel.frame.size)
        myTextStorage = NSTextStorage(attributedString: attribString)
        myTextStorage!.addAttribute(NSFontAttributeName,
                                    value: UIFont .systemFont(ofSize: textContentsLabel.font.pointSize),
                                    range: NSMakeRange(0, textContentsLabel.text!.characters.count))
        
        // Configure layoutManager and textStorage
        myLayoutManager!.addTextContainer(myTextContainer!)
        myTextStorage!.addLayoutManager(myLayoutManager!)
        
        // Configure textContainer
        myTextContainer!.lineFragmentPadding = 0.0;
        myTextContainer!.lineBreakMode = textContentsLabel.lineBreakMode;
        myTextContainer!.maximumNumberOfLines = textContentsLabel.numberOfLines;
        
        layoutManagerSetup = true
    }
    
    func handleTapWithVoiceOver() {
        
        let contentsRow = contentRowModel()
        for content in contentsRow.textContentsArray {
            
            if content.type == ContentsType.URL {
                
                let urlContent = content as! UrlContents
                UIApplication.shared.openURL(urlContent.link!)
            }
        }
    }
    
    func handleTapOnLabel(recognizer: UIGestureRecognizer) {
        
        let voRunning = UIAccessibilityIsVoiceOverRunning()
        if voRunning {
            
            self.handleTapWithVoiceOver()
        }
        
        setupLayoutManger(attribString: textContentsLabel.attributedText!)
        
        let label = recognizer.view as! UILabel
        var location: CGPoint = recognizer.location(in: label)
        location.x -= label.alignmentRectInsets.left
        location.y -= label.alignmentRectInsets.top
        var characterIndex: Int
        characterIndex = myLayoutManager!.characterIndex(for: location,
                                                            in: myTextContainer!,
                                                            fractionOfDistanceBetweenInsertionPoints: nil)
        
        // let textContainerLength = textContentsLabel.text!.characters.count
        //NSLog("text: \(textContainerLength) length, mapped to char index: \(characterIndex) for location: \(location)")
        
        // unsigned numberOfLines, index, numberOfGlyphs = [layoutManager numberOfGlyphs];
//        let numberOfGlyphs = myLayoutManager!.numberOfGlyphs
//        var lineRange: NSRange = NSMakeRange(0, 0)
//        var index: Int = 0
//        var numberOfLines: Int = 0
//        while index < numberOfGlyphs {
//            
//            let lineRect = myLayoutManager!.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
//            index = NSMaxRange(lineRange)
//            numberOfLines += 1
//            let range: Range = lineRange.toRange()!
//            let txt: String = textContentsLabel.text!
//            let myNSString = txt as NSString
//            let portion = myNSString.substring(with: NSRange(location: lineRange.location, length: lineRange.length))
//            NSLog("line rect: \(lineRect) for glyphs: \(range) value: \(portion)")
//        }
        
        if characterIndex < (myTextStorage?.length)! {

            var range: NSRange = NSMakeRange(0, 0)
            let result = myTextStorage!.attribute("NSLink", at: characterIndex, effectiveRange: &range)
            if (result != nil) {
                UIApplication.shared.openURL(result as! URL)
            } else {
                NSLog("No link found")
            }
        }
    }
    
}
