//
//  Bundle+Extensions.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-12.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

extension Bundle {

    //  computed property
    var namespace: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
