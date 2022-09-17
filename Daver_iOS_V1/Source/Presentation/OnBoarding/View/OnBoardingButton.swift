//
//  OnBoardingButton.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/05.
//

import UIKit

final class OnBoardingButton: UIButton{
    // MARK: - Init
    init(text: String, foregroundColor: UIColor, backgroundColor: UIColor){
        super.init(frame: .zero)
        self.setTitle(text, for: .normal)
        self.setTitleColor(foregroundColor, for: .normal)
        self.backgroundColor = backgroundColor
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI
private extension OnBoardingButton{
    func configureButton(){
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        self.layer.cornerRadius = 6
    }
}
