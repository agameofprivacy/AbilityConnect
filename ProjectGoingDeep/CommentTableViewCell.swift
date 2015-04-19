//
//  CommentTableViewCell.swift
//  ProjectGoingDeep
//
//  Created by Eddie Chen on 4/19/15.
//  Copyright (c) 2015 ProjectGoingDeep. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    var authorLabel:UILabel!
    var timeStampLabel:UILabel!
    var commentContentLabel:UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.authorLabel = UILabel(frame: CGRectZero)
        self.authorLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.authorLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 14.0)
        contentView.addSubview(self.authorLabel)
        
        self.timeStampLabel = UILabel(frame: CGRectZero)
        self.timeStampLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.timeStampLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 14.0)
        contentView.addSubview(self.timeStampLabel)
        
        self.commentContentLabel = UILabel(frame: CGRectZero)
        self.commentContentLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.commentContentLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        
        var metricsDictionary = ["sideMargin":15]
        var viewsDictionary = ["authorLabel":self.authorLabel, "timeStampLabel":self.timeStampLabel, "commentContentLabel":self.commentContentLabel]
        
        var topHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[authorLabel]-[timeStampLabel]-sideMargin-|", options: NSLayoutFormatOptions.AlignAllTop, metrics: metricsDictionary, views: viewsDictionary)
        
        var bottomHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[commentContentLabel]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var leftVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-sideMargin-[authorLabel]-4-[commentContentLabel]-sideMargin-|", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metricsDictionary, views: viewsDictionary)
        
        var rightVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-sideMargin-[timeStampLabel]-4-[commentContentLabel]-sideMargin-|", options: NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        contentView.addConstraints(topHorizontalConstraints)
        contentView.addConstraints(bottomHorizontalConstraints)
        contentView.addConstraints(leftVerticalConstraints)
        contentView.addConstraints(rightVerticalConstraints)        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
