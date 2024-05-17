//
//  GameListView.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation
import UIKit
import PinLayout

final class GameListView: MvvmUIKitView
<
    GameListViewModel,
    GameListViewState,
    GameListViewModel.ViewAction,
    GameListViewModel.Eff
>,
    UITableViewDataSource,
    UITableViewDelegate
{
    // MARK: - Subviews
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .none
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        tableView.estimatedRowHeight = 10
        tableView.estimatedSectionHeaderHeight = 10
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = UIRefreshControl()
    
    private lazy var loadingView = LoadingView(
        indicatorColor: Design.Colors.loadingIndicatorGray,
        backdropColor: Design.Colors.loadingBackdropColor
    )
    
    
    // MARK: - Init
    override init(viewModel: GameListViewModel) {
        super.init(viewModel: viewModel)
        
        backgroundColor = Design.Colors.defaultBackground
        
        addSubview(tableView)
        addSubview(loadingView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DateSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: DateSectionHeaderView.reuseIdentifier)
        tableView.register(CompetitionTableViewCell.self, forCellReuseIdentifier: CompetitionTableViewCell.reuseIdentifier)
        tableView.register(GameTableViewCell.self, forCellReuseIdentifier: GameTableViewCell.reuseIdentifier)
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(onRefreshControlRefresh(_:)), for: UIControl.Event.valueChanged)
    }
    
    
    // MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        self.pin.width(size.width)
        return layout()
    }
    
    override func safeAreaInsetsDidChange() {
        super.safeAreaInsetsDidChange()
        setNeedsLayout()
    }
    
    
    // MARK: - Layout
    @discardableResult
    private func layout() -> CGSize {
        tableView.pin
            .top(pin.safeArea.top)
            .horizontally()
            .bottom()
        
        loadingView.pin.all()
        
        return frame.size
    }
    
    
    // MARK: - Control's Actions
    @objc
    private func onRefreshControlRefresh(_ sender: AnyObject) {
        viewModel.sendViewAction(.pullToRefresh)
    }
    
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.state.sectionItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionItem = viewModel.state.sectionItems[section]
        return sectionItem.gameItems.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionItem = viewModel.state.sectionItems[section]
        let dateHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DateSectionHeaderView.reuseIdentifier) as! DateSectionHeaderView
        dateHeaderView.setViewItem(sectionItem)
        return dateHeaderView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionItem = viewModel.state.sectionItems[indexPath.section]
        let gameItemType = sectionItem.gameItems[indexPath.row]
        switch gameItemType {
        case .competition(let competitionItem):
            let cell = tableView.dequeueReusableCell(withIdentifier: CompetitionTableViewCell.reuseIdentifier) as! CompetitionTableViewCell
            cell.setViewItem(competitionItem)
            return cell
        case .game(let gameItem):
            let cell = tableView.dequeueReusableCell(withIdentifier: GameTableViewCell.reuseIdentifier) as! GameTableViewCell
            cell.setViewItem(gameItem)
            return cell
        }
    }
    
    
    // MARK: - State and effects
    override func onState(_ state: GameListViewState) {
        super.onState(state)
        
        switch state.loadingState {
        case .idle:
            loadingView.setLoading(false)
            tableView.stopRefreshControl()
        case .initialLoading:
            loadingView.setLoading(true)
            tableView.stopRefreshControl()
        case .refreshControlRefreshing:
            loadingView.setLoading(false)
            tableView.startRefreshControl(animated: true)
        }
        // Don't worry about full reload because of Demo. Moreover Cells are very lightful.
        tableView.reloadData()
        setNeedsLayout()
    }
    
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
