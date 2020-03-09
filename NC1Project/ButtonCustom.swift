//
//  CustomButton.swift
//  NC1Project
//
//  Created by Erlina Fabiola on 05/03/20.
//  Copyright © 2020 Erlina Fabiola. All rights reserved.
//

import UIKit

class ButtonCustom: UIView {

    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var activityLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var viewBackground: UIView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        buttonCarousel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buttonCarousel()
    }
    
    func buttonCarousel(){
        
        let customView = Bundle(for: ButtonCustom.self).loadNibNamed("Button", owner: self, options: nil)?.first as! UIView
        
        customView.frame = bounds
        addSubview(customView)
        
        viewBackground.layer.cornerRadius = frame.size.width / 2
        viewBackground.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}
