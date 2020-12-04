//
//  UIImageView+Additionals.swift
//  MatchAnimation
//
//  Created by Data Kondzhariia on 02.12.2020.
//  Copyright © 2020 Data Kondzhariia. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {

    func load(url: URL) {
        let options = ImageLoadingOptions(
            placeholder: R.image.placeholder(),
            transition: .fadeIn(duration: 0.33)
        )
        Nuke.loadImage(with: url, options: options, into: self)
    }
}
