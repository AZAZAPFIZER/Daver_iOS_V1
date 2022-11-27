//
//  SignInTextField.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/21.
//

import UIKit

final class SignInTextField: UITextField {
    init(placeholder: String) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 15
        self.font = .systemFont(ofSize: 18, weight: .regular)
        self.placeholder = placeholder
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "Daver_Gray")?.cgColor
        self.leftSpace(20)
        self.rightSpace(40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
