//
//  statusCell.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-21.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class statusCell: UITableViewCell {

    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var vipImage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var buttonView: ButtonView!
    @IBOutlet weak var statusPictureView: StatusPictureView!
    @IBOutlet weak var retweetLabel: UILabel?
    
    var statusViewModel: StatusViewModel? {
        didSet{
            // set status text
            contentLabel?.text = statusViewModel?.status.text
            // set screen name
            screenNameLabel.text = statusViewModel?.status.user?.screen_name
            // set member image
            memberImage.image = statusViewModel?.memberImage
            // set vip image
            vipImage.image = statusViewModel?.vipImage
            // set user profile image
            avatarImage.setImage(urlString: statusViewModel?.status.user?.profile_image_url, placeholderImage: UIImage(named: "avatar_default_big"), isRoundedCorner: true)
            // set button view cont
            buttonView.statusViewModel = statusViewModel
            
            statusPictureView.heightCons.constant = statusViewModel?.pictureViewSize.height ?? 0
            statusPictureView.pic_urls = statusViewModel?.picUrls
             
            // set retweet label text
            retweetLabel?.text = statusViewModel?.retweetText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
