//
//  DateSectionHeaderView.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation
import UIKit
import PinLayout

final class DateSectionHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "DateSectionHeaderView"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Design.Fonts.bigText
        label.textColor = Design.Colors.primaryText
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    
    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = Design.Colors.dateHeaderBackground
        contentView.addSubview(titleLabel)
    }
    
    @available(*, unavailable, message: "Use another init()")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        return layout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    
    // MARK: - Layout
    @discardableResult
    private func layout() -> CGSize {
        titleLabel.pin
            .horizontally(Design.Metrics.horizontalGap)
            .top(Design.Metrics.bigVerticalGap)
            .sizeToFit(.width)
        
        contentView.pin.all()
        
        return CGSize(
            width: frame.width,
            height: titleLabel.frame.maxY + Design.Metrics.bigVerticalGap
        )
    }
    
    
    // MARK: - Configure ViewState
    func setViewItem(_ viewItem: GameListViewState.DateSectionItem) {
        titleLabel.text = viewItem.dateText
    }
}

private extension Design.Colors {
    static var dateHeaderBackground: UIColor { .lightGray }
}
