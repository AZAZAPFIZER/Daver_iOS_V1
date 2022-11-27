//
//  HomeVC.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/10/24.
//

import UIKit
import NMapsMap
import PinLayout
import FlexLayout
import RxSwift
import Then
import ReactorKit
import RxSwift

final class HomeVC: baseVC<HomeReactor> {
    // MARK: - People
    private let person1 = Person(name: "우상범", address: "대구 중구 태평로 45", lat: 35.8778969, lon: 128.583359)
    private let person2 = Person(name: "고용빈", address: "대구 수성구 달구벌대로 3091", lat: 35.8434897, lon: 128.695189)
    private let person3 = Person(name: "박종현", address: "대구 수성구 달구벌대로 3210", lat: 35.8396277, lon: 128.707657)
    private let person4 = Person(name: "유은재", address: "대구 수성구 신매동 567", lat: 35.8403382, lon: 128.705215)
    private let person5 = Person(name: "박소영", address: "대구 수성구 노변로 91", lat: 35.8399272, lon: 128.699872)
    private let person6 = Person(name: "임재청", address: "대구 수성구 달구벌대로 3080", lat: 35.8428777, lon: 128.693859)
    private let person7 = Person(name: "곽도윤", address: "대구 수성구 시지로 66", lat: 35.8381758, lon: 128.694357)
    private let person8 = Person(name: "정현진", address: "대구 수성구 노변공원로 52", lat: 35.8376177, lon: 128.697510)
    private let person9 = Person(name: "배진영", address: "대구 수성구 달구벌대로 3170", lat: 35.8352527, lon: 128.700978)
    private let person10 = Person(name: "이승우", address: "대구 수성구 신매동 580", lat: 35.8372994, lon: 128.704718)
    
    // MARK: - Properties
    private let locationManager1 = CLLocationManager()
    private var mapView: NMFMapView!
    
    // MARK: - UI
    override func setUp() {
        self.mapView = NMFMapView(frame: view.frame)
        mapView.positionMode = .direction
        view.addSubview(mapView)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        print("위치 서비스 On 상태")
        locationManager.startUpdatingLocation()
        print(locationManager.location?.coordinate  ?? "")
        
        // 10초에 한번 씩 현 위치로 카메라 이동
        Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(cameraUpdate), userInfo: nil, repeats: true)
        
        let marker1 = NMFMarker()
        marker1.position = NMGLatLng(lat: person1.lat, lng: person1.lon)
        marker1.captionText = person1.name
        marker1.captionAligns = [NMFAlignType.top]
        marker1.isHideCollidedSymbols = true
        marker1.iconImage = NMFOverlayImage(name: "m")
        marker1.mapView = mapView
        
        let marker2 = NMFMarker()
        marker2.position = NMGLatLng(lat: person2.lat, lng: person2.lon)
        marker2.isHideCollidedSymbols = true
        marker2.captionText = person2.name
        marker2.captionAligns = [NMFAlignType.top]
        marker2.iconImage = NMFOverlayImage(name: "m")
        marker2.mapView = mapView
        
        let marker3 = NMFMarker()
        marker3.position = NMGLatLng(lat: person3.lat, lng: person3.lon)
        marker3.isHideCollidedSymbols = true
        marker3.captionText = person3.name
        marker3.captionAligns = [NMFAlignType.top]
        marker3.iconImage = NMFOverlayImage(name: "m")
        marker3.mapView = mapView
        
        let marker4 = NMFMarker()
        marker4.position = NMGLatLng(lat: person4.lat, lng: person4.lon)
        marker4.isHideCollidedSymbols = true
        marker4.captionText = person4.name
        marker4.captionAligns = [NMFAlignType.top]
        marker4.iconImage = NMFOverlayImage(name: "m")
        marker4.mapView = mapView
        
        let marker5 = NMFMarker()
        marker5.position = NMGLatLng(lat: person5.lat, lng: person5.lon)
        marker5.isHideCollidedSymbols = true
        marker5.captionText = person5.name
        marker5.captionAligns = [NMFAlignType.top]
        marker5.iconImage = NMFOverlayImage(name: "m")
        marker5.mapView = mapView
        
        let marker6 = NMFMarker()
        marker6.position = NMGLatLng(lat: person6.lat, lng: person6.lon)
        marker6.isHideCollidedSymbols = true
        marker6.captionText = person6.name
        marker6.captionAligns = [NMFAlignType.top]
        marker6.iconImage = NMFOverlayImage(name: "m")
        marker6.mapView = mapView
        
        let marker7 = NMFMarker()
        marker7.position = NMGLatLng(lat: person7.lat, lng: person7.lon)
        marker7.isHideCollidedSymbols = true
        marker7.captionText = person7.name
        marker7.captionAligns = [NMFAlignType.top]
        marker7.iconImage = NMFOverlayImage(name: "m")
        marker7.mapView = mapView
        
        let marker8 = NMFMarker()
        marker8.position = NMGLatLng(lat: person8.lat, lng: person8.lon)
        marker8.isHideCollidedSymbols = true
        marker8.captionText = person8.name
        marker8.captionAligns = [NMFAlignType.top]
        marker8.iconImage = NMFOverlayImage(name: "m")
        marker8.mapView = mapView
        
        let marker9 = NMFMarker()
        marker9.position = NMGLatLng(lat: person9.lat, lng: person9.lon)
        marker9.isHideCollidedSymbols = true
        marker9.captionText = person9.name
        marker9.captionAligns = [NMFAlignType.top]
        marker9.iconImage = NMFOverlayImage(name: "m")
        marker9.mapView = mapView
        
        let marker10 = NMFMarker()
        marker10.position = NMGLatLng(lat: person10.lat, lng: person10.lon)
        marker10.isHideCollidedSymbols = true
        marker10.captionText = person10.name
        marker10.captionAligns = [NMFAlignType.top]
        marker10.iconImage = NMFOverlayImage(name: "m")
        marker10.mapView = mapView
    }
    @objc func cameraUpdate() {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
        cameraUpdate.animation = .easeIn
        mapView.moveCamera(cameraUpdate)
        refresh()
    }
    
    private func refresh() {
        Observable.just(.refresh)
            .bind(to: reactor!.action)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Reactor
    override func bindState(reactor: HomeReactor) {
        
    }
    
    
}

class Person {
    var name: String = ""
    var address: String = ""
    var lat: Double = 0.0
    var lon: Double = 0.0
    
    init(name: String, address: String, lat: Double, lon: Double) {
        self.name = name
        self.address = address
        self.lat = lat
        self.lon = lon
    }
}


