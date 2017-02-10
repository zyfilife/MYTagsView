//
//  MYTagsView.swift
//  MYTagsViewDemo
//
//  Created by 朱益锋 on 2017/2/10.
//  Copyright © 2017年 朱益锋. All rights reserved.
//

import UIKit

class MYTagsView: UIScrollView {

    var viewType = 0
    
    //是否可删除
    var canDelete = false
    
    var tagSpace: CGFloat = 16
    
    var tagHorizontalSpace: CGFloat = 10
    
    var tagVerticalSpace: CGFloat = 5
    
    var tagHeight: CGFloat = 32
    
    var personTagHeight: CGFloat = 36
    
    var tagOriginX: CGFloat = 10
    
    var tagOriginY: CGFloat = 6
    
    var borderColor = UIColor.darkGray
    
    var borderWidth: CGFloat = 0.5
    
    var cornerRadius: CGFloat = 16
    
    var clipToBounds = true
    
    var maskToBounds = true
    
    var titleSize: CGFloat = 13
    
    var tagEndle = true
    
    var firstSelected = false
    
    var titleColor = UIColor.white
    
    var normalBackgroundColor = UIColor.gray
    
    var highlightedBackgroundColor = UIColor.lightGray
    
    var tagsBackgroundColorSetActionHandler: ((_ title: String) -> UIColor)?
    var clickButtonActionHandler: ((_ model: ModelItem?) -> Void)?
    
    var dataSource: [ModelItem]? = nil {
        didSet {
            
            for view in self.subviews {
                for subView in view.subviews {
                    subView.removeFromSuperview()
                }
                view.removeFromSuperview()
            }
            
            var contentWidth: CGFloat = 0
            
            var originXOfTotal: CGFloat = self.tagOriginX
            
            if let array = self.dataSource {
                if array.count > 0 {
                    let disposeTags = self.disposeDataSource(array, originX: originXOfTotal)
                    
                    var j = 0
                    
                    for tagDic in disposeTags {
                        var frame = CGRect.zero
                        if let originX = tagDic["originX"] , let buttonWith = tagDic["buttonWidth"] {
                            frame = CGRect(x: originX, y: self.tagOriginY, width: buttonWith, height: self.tagHeight)
                        }
                        let button = TagsButton(type: UIButtonType.custom)
                        button.item = array[j]
                        button.frame = frame
                        button.center.y = self.frame.size.height*0.5
                        button.setTitleColor(self.titleColor, for: UIControlState.normal)
                        button.titleLabel?.font = UIFont.systemFont(ofSize: self.titleSize)
                        button.layer.cornerRadius = self.cornerRadius
                        button.clipsToBounds = self.clipToBounds
                        
                        if let title = array[j].displayString {
                            button.setTitle(title, for: UIControlState.normal)
                            if self.tagsBackgroundColorSetActionHandler != nil {
                                button.backgroundColor = self.tagsBackgroundColorSetActionHandler?(title)
                            }else {
                                button.backgroundColor = self.normalBackgroundColor
                            }
                        }
                        button.tag = j
                        button.addTarget(self, action: #selector(MYTagsView.buttonClickAction(_:)), for: UIControlEvents.touchUpInside)
                        
                        self.addSubview(button)
                        
                        if j == disposeTags.count-1 {
                            contentWidth = button.frame.maxX
                            originXOfTotal = contentWidth + self.tagHorizontalSpace
                        }
                        j += 1
                    }
                }
            }
            
            self.contentSize = CGSize(width: contentWidth, height: self.frame.size.height)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func disposeDataSource(_ dataSource: [ModelItem], originX: CGFloat) -> [[String: CGFloat]] {
        
        var horizontalTags = [[String: CGFloat]]()
        
        var index = 0
        
        var originX = originX
        
        for item in dataSource {
            
            if let tagTitle = item.displayString {
                let contentSize = tagTitle.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)])
                
                var dictionary = [String: CGFloat]()
                
                let buttonWidth = contentSize.width + self.tagSpace
                
                dictionary["buttonWidth"] = buttonWidth
                
                dictionary["originX"] = originX
                
                horizontalTags.append(dictionary)
                
                originX += contentSize.width + self.tagHorizontalSpace + self.tagSpace
                
                index += 1
            }
        }
        
        return horizontalTags
    }
    
    func buttonClickAction(_ sender: TagsButton) {
        if let item = sender.item {
            self.clickButtonActionHandler?(item)
        }
    }
    
}

class TagsButton: UIButton {
    var item: ModelItem?
}

class ModelItem {
    
    var displayString: String!
}
