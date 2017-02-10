//
//  ViewController.swift
//  MYTagsViewDemo
//
//  Created by 朱益锋 on 2017/2/10.
//  Copyright © 2017年 朱益锋. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate lazy var tagsView: MYTagsView = {
        let view = MYTagsView()
        view.frame = self.view.bounds
        return view
    }()
    
    fileprivate var textArray = [
        "What is design?",
        "Design", "Design is not just", "what it looks like", "and feels like.",
        "Design", "is how it works.", "- Steve Jobs",
        "Older people", "sit down and ask,", "'What is it?'",
        "but the boy asks,", "'What can I do with it?'.", "- Steve Jobs",
        "Swift", "Objective-C", "iPhone", "iPad", "Mac Mini",
        "MacBook Pro🔥", "Mac Pro⚡️",
        "爱老婆",
        "老婆和女儿"
    ]
    
    fileprivate lazy var arrayOfModel: [ModelItem] = {
        var array = [ModelItem]()
        for text in self.textArray {
            let item = ModelItem()
            item.displayString = text
            array.append(item)
        }
        return array
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tagsView)
        
        self.tagsView.dataSource = self.arrayOfModel
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

