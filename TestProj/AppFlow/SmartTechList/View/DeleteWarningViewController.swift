//
//  DeleteWarningViewController.swift
//  TestProj
//
//  Created by Айбол on 01.10.2023.
//

import UIKit
import SnapKit

final class DeleteWarningViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы хотите удалить\n\(warningTitle ?? "")?"
        label.textAlignment = .left
        label.textColor = .mainPurple
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("отмена".uppercased(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor = .buttonBackgroundGray
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 35, bottom: 12, right: 35)
        button.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("удалить".uppercased(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor = .buttonBackgroundRed
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 35, bottom: 12, right: 35)
        button.addTarget(self, action: #selector(deleteButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var warningTitle: String?
    private var cancelButtonClosure: (() -> ())?
    private var deleteButtonClosure: (() -> ())?
    
    init(warningTitle: String?, cancelButtonClosure: (() -> ())?, deleteButtonClosure: (() -> ())?) {
        self.warningTitle = warningTitle
        super.init(nibName: nil, bundle: nil)
        
        self.cancelButtonClosure = cancelButtonClosure
        self.deleteButtonClosure = deleteButtonClosure
        
        setupViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        cancelButton.layer.cornerRadius = 20
        deleteButton.layer.cornerRadius = 20
        containerView.layer.cornerRadius = 25
    }
    
    private func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(cancelButton)
        containerView.addSubview(deleteButton)
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.top.equalToSuperview().offset(25)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(55)
            make.leading.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-25)
            make.height.equalTo(40)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(cancelButton.snp.trailing)
            make.bottom.equalToSuperview().offset(-25)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(40)
        }
    }
    
    @objc private func cancelButtonTap() {
        cancelButtonClosure?()
    }
    
    @objc private func deleteButtonTap() {
        deleteButtonClosure?()
    }
}
