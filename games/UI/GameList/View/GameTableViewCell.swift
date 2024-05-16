//
//  GameTableViewCell.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation
import UIKit
import PinLayout

final class GameTableViewCell: UITableViewCell {
    static let reuseIdentifier = "GameTableViewCell"
    
    private lazy var centerTableuLabel: UILabel = {
        let label = UILabel()
        label.font = Design.Fonts.bigText
        label.textColor = Design.Colors.secondaryText
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var gameTimeLabel: UILabel = {
        let label = UILabel()
        label.font = Design.Fonts.smallText
        label.textColor = Design.Colors.secondaryText
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var team1Label: UILabel = {
        let label = UILabel()
        label.font = Design.Fonts.mediumText
        label.textColor = Design.Colors.primaryText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var team2Label: UILabel = {
        let label = UILabel()
        label.font = Design.Fonts.mediumText
        label.textColor = Design.Colors.primaryText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = Design.Colors.gameCellBackground
        
        contentView.addSubview(centerTableuLabel)
        contentView.addSubview(gameTimeLabel)
        contentView.addSubview(team1Label)
        contentView.addSubview(team2Label)
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
        
        centerTableuLabel.text = nil
        gameTimeLabel.text = nil
        gameTimeLabel.isHidden = true
        team1Label.text = nil
        team2Label.text = nil
    }
    
    
    // MARK: - Layout
    @discardableResult
    private func layout() -> CGSize {
        centerTableuLabel.pin
            .sizeToFit()
            .hCenter()
        if !gameTimeLabel.isHidden {
            gameTimeLabel.pin
                .top(Design.Metrics.verticalGap)
                .sizeToFit()
                .hCenter()
            
            centerTableuLabel.pin
                .below(of: gameTimeLabel)
                .marginTop(Design.Metrics.smallVerticalGap)
        } else {
            centerTableuLabel.pin.vCenter()
        }
        
        team1Label.pin
            .top(Design.Metrics.verticalGap)
            .start(to: contentView.edge.start)
            .end(to: centerTableuLabel.edge.start)
            .marginStart(Design.Metrics.horizontalGap)
            .marginEnd(Design.Metrics.smallHorizontalGap)
            .sizeToFit(.width)
        
        team2Label.pin
            .top(Design.Metrics.verticalGap)
            .start(to: centerTableuLabel.edge.end)
            .end(to: contentView.edge.end)
            .marginStart(Design.Metrics.smallHorizontalGap)
            .marginEnd(Design.Metrics.horizontalGap)
            .sizeToFit(.width)
        
        let maxY = [team1Label, team2Label, centerTableuLabel]
            .map({ $0.frame.maxY })
            .max() ?? 0
        contentView.pin.all()
        
        team1Label.pin.vCenter()
        team2Label.pin.vCenter()
        
        return CGSize(
            width: frame.width,
            height: maxY + Design.Metrics.verticalGap
        )
    }
    
    
    // MARK: - Configure ViewState
    func setViewItem(_ viewItem: GameListViewState.GameItem) {
        centerTableuLabel.text = viewItem.centeredTableuText
        gameTimeLabel.text = viewItem.currentTimeText
        gameTimeLabel.isHidden = viewItem.currentTimeText == nil
        team1Label.text = viewItem.team1NameText
        team2Label.text = viewItem.team2NameText
    }
}

private extension Design.Colors {
    static var gameCellBackground: UIColor { .green.withAlphaComponent(0.4) }
}

