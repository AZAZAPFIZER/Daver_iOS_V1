//
//  baseVC.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/08/30.
//

import UIKit
import ReactorKit
import RxSwift
import CoreLocation

class baseVC<T: Reactor>: UIViewController, CLLocationManagerDelegate  {
    // MARK: - Properties
    var disposeBag: DisposeBag = .init()
    
    // MARK: - LifeCycle
    @available(*, unavailable)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        d()
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
    let locationManager = CLLocationManager()
    func d() {
        locationManager.delegate = self
        
        // 위치 권한 체크해서 없는 경우 요청하는 코드
        switch locationManager.authorizationStatus {
        case .denied:
            // 거부 상태라면 알럿을 띄워 허용하도록 유도하는 코드를 넣을 수 있다.
            print("위치 비허용")
        case .notDetermined, .restricted:
            // request
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
        
        // 위치 범위가 대략적 범위로 되어있다면 정확한 위치를 공유하도록 요청하기
        switch locationManager.accuracyAuthorization {
        case .reducedAccuracy:
            locationManager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: "")
        case .fullAccuracy:
            // 이미 정확한 위치를 공유하고 있는데 또 요청하면 오류가 발생한다.
            break
        @unknown default:
            break
        }
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
