//
//  ErrorView.swift
//  TestProj
//
//  Created by Айбол on 30.09.2023.
//

import UIKit
import SnapKit

final class ErrorView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Что то пошло не так,\n ошибка"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        return label
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.setTitle("повторить".uppercased(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor = .buttonBackground
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 18, bottom: 10, right: 18)
        button.addTarget(self, action: #selector(refreshButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private var refreshClosure: (() -> ())?
    
    init(refreshClosure: (() -> ())?) {
        super.init(frame: .zero)
        
        self.refreshClosure = refreshClosure
        setupViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        refreshButton.layer.cornerRadius = 20
    }
    
    private func setupViews() {
        backgroundColor = .mainPurple
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(refreshButton)
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-60)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        
        refreshButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(55)
            make.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    @objc private func refreshButtonTap() {
        refreshClosure?()
    }
}
