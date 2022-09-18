//
//  baseVC.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/08/30.
//

import UIKit
import ReactorKit
import RxSwift

class baseVC<T: Reactor>: UIViewController  {
    // MARK: - Properties
    var disposeBag: DisposeBag = .init()
    
    // MARK: - LifeCycle
    @available(*, unavailable)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUp()
        addView()
        setLayout()
        configureVC()
        configureNavigation()
        if traitCollection.userInterfaceStyle == .dark { darkConfigure() }
    }
    
    override func viewDidLayoutSubviews() {
        setLayoutSubViews()
    }

    init(reactor: T?) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("❎ \(type(of: self)): \(#function)")
    }
    
    func setUp() {}
    func addView() {}
    func setLayout() {}
    func setLayoutSubViews() {}
    func configureVC() {}
    func configureNavigation() {}
    func darkConfigure() {}

    func bindView(reactor: T) {}
    func bindAction(reactor: T) {}
    func bindState(reactor: T) {}
}

extension baseVC: View {
    func bind(reactor: T) {
        bindView(reactor: reactor)
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
}
