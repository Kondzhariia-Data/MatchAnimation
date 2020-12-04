//
//  MoviesTableViewCell.swift
//  MatchAnimation
//
//  Created by Data Kondzhariia on 02.12.2020.
//  Copyright © 2020 Data Kondzhariia. All rights reserved.
//

import UIKit
import Hero

class MoviesTableViewCell: UITableViewCell {
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var summaryLabel: UILabel!
}

// MARK: - Public Methods
extension MoviesTableViewCell {

    public func configure(movie: Movies.Load.ViewModel.DisplayedMovie) {
        if let url = URL(string: movie.avatarUrl) {
            avatarImageView.load(url: url)
        } else {
            avatarImageView.image = R.image.placeholder()
        }

        summaryLabel.attributedText = movie.summary.htmlToAttributedString
        summaryLabel.lineBreakMode = .byTruncatingTail
    }

    public func setAnimationIDs() {
        avatarImageView.hero.id = "AvatarImage"
        summaryLabel.hero.id = "Summary"
    }

    public func clearAnimationIDs() {
        avatarImageView.hero.id = nil
        summaryLabel.hero.id = nil
    }
}
