//
//  CompetitionTableViewCell.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation
import UIKit
import PinLayout

final class CompetitionTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CompetitionTableViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Design.Fonts.mediumText
        label.textColor = Design.Colors.secondaryText
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = Design.Colors.competitionCellBackground
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
            .top(Design.Metrics.verticalGap)
            .sizeToFit(.width)
        
        contentView.pin.all()
        
        return CGSize(
            width: frame.width,
            height: titleLabel.frame.maxY + Design.Metrics.verticalGap
        )
    }
    
    
    // MARK: - Configure ViewState
    func setViewItem(_ viewItem: GameListViewState.CompetitionItem) {
        titleLabel.text = viewItem.competitionName
    }
}

private extension Design.Colors {
    static var competitionCellBackground: UIColor { .orange.withAlphaComponent(0.4) }
}
