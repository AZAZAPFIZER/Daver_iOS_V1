//
//  FriendVC.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/11/08.
//

import UIKit
import FlexLayout
import PinLayout
import RxDataSources
import Then
import RxSwift
import RxCocoa
import RxViewController

final class FriendVC: baseVC<FriendReactor> {
    // MARK: - Properties
    private let rootContainer = UIView()
    private let friendTableView = UITableView().then {
        $0.register(FriendCell.self, forCellReuseIdentifier: FriendCell.reusableID)
        $0.rowHeight = 100
    }
    
    private let testLabel = UILabel().then {
        $0.text = "asdfasdfasdfasdf"
    }
    
    private let moreOptionButton = UIBarButtonItem(image: .init(systemName: "ellipsis")?.tintColor(.label),
                                                   style: .plain,
                                                   target: nil,
                                                   action: nil)
    
    // MARK: - Menu Action
    private lazy var modifyProfileMenuAction = UIAction(title: "친구요청 확인하기",image: UIImage(systemName: "person.line.dotted.person.fill"),handler: { [weak self] _ in
        self?.reactor?.action.onNext(.modifyButtonDidTap)
    })
    private lazy var cancelMenuAction = UIAction(title: "취소", attributes: .destructive, handler: { _ in return })
    
    // MARK: - UI
    override func setUp() {
        if #available(iOS 14.0, *) {
            moreOptionButton.menu = UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [
                modifyProfileMenuAction,
                cancelMenuAction
            ])
        }
        self.navigationItem.title = "친구"
    }
    
    override func configureNavigation() {
        self.navigationItem.title = "프로필"
        self.navigationItem.setRightBarButtonItems([moreOptionButton], animated: true)
        self.navigationItem.configBack()
    }
    
    override func addView() {
        view.addSubview(rootContainer)
    }
    
    override func setLayoutSubViews() {
        rootContainer.pin.all(view.pin.safeArea)
        rootContainer.flex.layout()
    }
    
    override func setLayout() {
        rootContainer.flex.define { flex in
            flex.addItem(friendTableView)
                .grow(1)
        }
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: FriendReactor) {
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.onAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: FriendReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        let friDS = RxTableViewSectionedReloadDataSource<FriendSection> { _, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withIdentifier: FriendCell.reusableID, for: ip) as? FriendCell else { return .init() }
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.friendList)
            .map { list in
                [FriendSection(items: list)]
            }
            .bind(to: friendTableView.rx.items(dataSource: friDS))
            .disposed(by: disposeBag)
    }
    
}
