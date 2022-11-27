//
//  MainTabbarVC.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/10/24.
//

import UIKit

final class MainTabbarVC: UITabBarController {
    // MARK: - Color
    enum Color {
        static var gray = UIColor(named: "Daver_Gray")!
    }
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        configureVC()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainTabbarVC {
    func configureVC() {
        UITabBar.clearShadow()
        tabBar.backgroundColor = .white
        tabBar.layer.applyShadow(
            color: Color.gray,
            offSet: .init(width: 0, height: 0),
            blur: 5)
    }
}

extension UITabBar {
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}

extension CALayer {
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        offSet: CGSize = .init(width: 0, height: 2),
        blur: CGFloat = 4
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = offSet
        shadowRadius = blur / 2
    }
}
