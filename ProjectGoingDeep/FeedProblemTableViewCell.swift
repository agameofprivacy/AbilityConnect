//
//  FeedProblemTableViewCell.swift
//  ProjectGoingDeep
//
//  Created by Eddie Chen on 4/18/15.
//  Copyright (c) 2015 ProjectGoingDeep. All rights reserved.
//

import UIKit

class FeedProblemTableViewCell: UITableViewCell {

    var titleLabel:UILabel!
    var avatarImageView:UIImageView!
    var detailLabel:UILabel!
    var tagsLabel:UILabel!
    var upvoteButtonView:UIView!
    var numberOfUpvotesLabel:UILabel!
    var upvoteActionLabel:UILabel!
    var commentButtonView:UIView!
    var numberOfCommentsLabel:UILabel!
    var commentActionLabel:UILabel!
    var bottomSeparator:UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.titleLabel = UILabel(frame: CGRectZero)
        self.titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
        self.titleLabel.text = "this is title label text"
        contentView.addSubview(self.titleLabel)
        
        self.avatarImageView = UIImageView(frame: CGRectZero)
        self.avatarImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.avatarImageView.layer.cornerRadius = 35
        self.avatarImageView.clipsToBounds = true
        self.avatarImageView.image = UIImage(named: "avatarPlaceholder")
        self.avatarImageView.layer.borderWidth = 1
        self.avatarImageView.layer.borderColor = UIColor(white:0.85, alpha: 1)
        self.avatarImageView.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.addSubview(self.avatarImageView)
        
        self.detailLabel = UILabel(frame: CGRectZero)
        self.detailLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.detailLabel.numberOfLines = 0
        self.detailLabel.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        self.detailLabel.text = "this is detail label text"
        contentView.addSubview(self.detailLabel)
        
        self.tagsLabel = UILabel(frame: CGRectZero)
        self.tagsLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.tagsLabel.numberOfLines = 0
        self.tagsLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 16.0)
        self.tagsLabel.text = "this is tags label text"
        contentView.addSubview(self.tagsLabel)
        
        self.upvoteButtonView = UIView(frame: CGRectZero)
        self.upvoteButtonView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.upvoteButtonView.layer.borderColor = UIColor.blackColor().CGColor
        self.upvoteButtonView.layer.borderWidth = 1
        self.upvoteButtonView.layer.cornerRadius = 8
        contentView.addSubview(self.upvoteButtonView)
        
        self.numberOfUpvotesLabel = UILabel(frame: CGRectZero)
        self.numberOfUpvotesLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.numberOfUpvotesLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 14.0)
        self.numberOfUpvotesLabel.numberOfLines = 1
        self.numberOfUpvotesLabel.text = "this is number of upvotes label text"
        self.numberOfUpvotesLabel.textAlignment = NSTextAlignment.Center
        self.upvoteButtonView.addSubview(self.numberOfUpvotesLabel)
        
        self.upvoteActionLabel = UILabel(frame: CGRectZero)
        self.upvoteActionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.upvoteActionLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        self.upvoteActionLabel.numberOfLines = 1
        self.upvoteActionLabel.text = "I Relate, Too"
        self.upvoteActionLabel.textAlignment = NSTextAlignment.Center
        self.upvoteButtonView.addSubview(self.upvoteActionLabel)
        
        self.commentButtonView = UIView(frame: CGRectZero)
        self.commentButtonView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.commentButtonView.layer.borderColor = UIColor.blackColor().CGColor
        self.commentButtonView.layer.borderWidth = 1
        self.commentButtonView.layer.cornerRadius = 8
        contentView.addSubview(self.commentButtonView)
        
        self.numberOfCommentsLabel = UILabel(frame: CGRectZero)
        self.numberOfCommentsLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.numberOfCommentsLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 14.0)
        self.numberOfCommentsLabel.numberOfLines = 1
        self.numberOfCommentsLabel.text = "this is number of comments label text"
        self.numberOfCommentsLabel.textAlignment = NSTextAlignment.Center
        self.commentButtonView.addSubview(self.numberOfCommentsLabel)
        
        self.commentActionLabel = UILabel(frame: CGRectZero)
        self.commentActionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.commentActionLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        self.commentActionLabel.numberOfLines = 1
        self.commentActionLabel.text = "I Have Something to Say"
        self.commentActionLabel.textAlignment = NSTextAlignment.Center
        self.commentButtonView.addSubview(self.commentActionLabel)
        
        self.bottomSeparator = UIView(frame: CGRectZero)
        self.bottomSeparator.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.bottomSeparator.backgroundColor = UIColor(white: 0.85, alpha: 1)
        contentView.addSubview(self.bottomSeparator)
        
        var metricsDictionary = ["sideMargin":15]
        var viewsDictionary = ["titleLabel":self.titleLabel, "detailLabel":self.detailLabel, "avatarImageView":self.avatarImageView, "tagsLabel":self.tagsLabel, "upvoteButtonView":self.upvoteButtonView, "numberOfUpvotesLabel":self.numberOfUpvotesLabel, "upvoteActionLabel":self.upvoteActionLabel, "commentButtonView":self.commentButtonView, "numberOfCommentsLabel":self.numberOfCommentsLabel, "commentActionLabel":self.commentActionLabel, "bottomSeparator":self.bottomSeparator]
        
        
        var upvoteButtonViewHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[numberOfUpvotesLabel]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var upvoteButtonViewVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[numberOfUpvotesLabel]-4-[upvoteActionLabel]-10-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        var commentButtonViewHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[numberOfCommentsLabel]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        
        var commentButtonViewVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[numberOfCommentsLabel]-4-[commentActionLabel]-10-|", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        
        
        self.upvoteButtonView.addConstraints(upvoteButtonViewHorizontalConstraints)
        self.upvoteButtonView.addConstraints(upvoteButtonViewVerticalConstraints)
        self.commentButtonView.addConstraints(commentButtonViewHorizontalConstraints)
        self.commentButtonView.addConstraints(commentButtonViewVerticalConstraints)
        

        
        var topHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[titleLabel]-sideMargin-[avatarImageView(70)]-sideMargin-|", options: NSLayoutFormatOptions.AlignAllTop, metrics: metricsDictionary, views: viewsDictionary)
        contentView.addConstraints(topHorizontalConstraints)

        var detailLabelHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[detailLabel]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        contentView.addConstraints(detailLabelHorizontalConstraints)

        var tagsLabelHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-sideMargin-[tagsLabel]-sideMargin-|", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        contentView.addConstraints(tagsLabelHorizontalConstraints)

        
        var leftVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[titleLabel]->=sideMargin-[detailLabel]", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        contentView.addConstraints(leftVerticalConstraints)
        
        var rightVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[avatarImageView(70)]->=sideMargin-[detailLabel]", options: NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        contentView.addConstraints(rightVerticalConstraints)

        
        var fullWidthVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[detailLabel]-sideMargin-[tagsLabel]-sideMargin-[upvoteButtonView]-sideMargin-[commentButtonView]", options: NSLayoutFormatOptions.AlignAllLeft | NSLayoutFormatOptions.AlignAllRight, metrics: metricsDictionary, views: viewsDictionary)
        contentView.addConstraints(fullWidthVerticalConstraints)
        
        var bottomSeparatorVerticalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[commentButtonView]-30-[bottomSeparator(1)]|", options:NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        contentView.addConstraints(bottomSeparatorVerticalConstraints)
        
        var bottomSeparatorHorizontalConstraints:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[bottomSeparator]|", options:NSLayoutFormatOptions(0), metrics: metricsDictionary, views: viewsDictionary)
        contentView.addConstraints(bottomSeparatorHorizontalConstraints)


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
