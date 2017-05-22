//
//  Constants.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-14.
//  Copyright © 2017 Allan. All rights reserved.
//

import Foundation
import UIKit


// constants of weibo
let BASE_WB_URL = "https://api.weibo.com/"

let WB_APP_KEY = "1518831897"

let WB_APP_SECRET = "e12abeb7bab100c577df6b2e8a398b13"

let WB_REDIRECT_URL = "http://www.weibo.com"

let WB_STATUS_URL = "\(BASE_WB_URL)2/statuses/home_timeline.json"

let WB_UNREAD_COUNT_URL = "\(BASE_WB_URL)2/remind/unread_count.json"

let WB_AUTHORIZE_URL = "\(BASE_WB_URL)oauth2/authorize?client_id=\(WB_APP_KEY)&redirect_uri=\(WB_REDIRECT_URL)"

let WB_ACCESSTOKEN_URL = "\(BASE_WB_URL)oauth2/access_token"

let WB_USER_URL = "\(BASE_WB_URL)users/show.json"

// notifications
let loginRequire = "loginRequire"

let loginSuccess = "loginSuccess"

// picture view outter margin
let StatusOutterMargin = CGFloat(12)

// picture view inner margin
let StatusInnerMargin = CGFloat(3)

// picture view width
let statusPictureViewWidth = UIScreen.main.bounds.width - 2 * StatusOutterMargin

// single image width
let singlePictureWidth = (statusPictureViewWidth - 2 * StatusInnerMargin) / 3



