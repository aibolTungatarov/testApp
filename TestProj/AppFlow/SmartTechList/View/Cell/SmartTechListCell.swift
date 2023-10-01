//
//  SmartTechListCell.swift
//  TestProj
//
//  Created by Айбол on 28.09.2023.
//

import UIKit
import SkeletonView
import SnapKit

final class SmartTechListCell: UITableViewCell {    
    private lazy var statusView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.isSkeletonable = true
        return view
    }()
    
    private lazy var statusLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = .white
        view.isSkeletonable = true
        view.linesCornerRadius = 6
        view.skeletonTextNumberOfLines = 1
        view.font = .systemFont(ofSize: 12, weight: .regular)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .mainPurple
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        label.skeletonTextLineHeight = .relativeToFont
        label.skeletonTextNumberOfLines = 1
        label.skeletonPaddingInsets = UIEdgeInsets(top: 0, left: 0, bottom: -40, right: 0)
        label.font = .systemFont(ofSize: 24, weight: .regular)
        return label
    }()
    
    private lazy var statusDescriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .buttonBackground
        view.isSkeletonable = true
        view.skeletonCornerRadius = 10
        return view
    }()
    
    private lazy var statusDescriptionImageView = UIImageView()
    private lazy var statusDescriptionLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = .white
        return view
    }()
    
    private lazy var deviceImageView = UIImageView()
    private let gradientLayer = CAGradientLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 20
        gradientLayer.frame = contentView.frame
        statusDescriptionView.layer.cornerRadius = 10
        statusView.layer.cornerRadius = statusView.frame.size.width / 2
        contentView.layoutSkeletonIfNeeded()
    }
    
    func configure(device: Device?) {
        guard let device = device else { return }
        titleLabel.text = device.name
        if let isOnline = device.isOnline {
            statusView.backgroundColor = isOnline ? .statusGreen : .statusRed
            statusLabel.text = isOnline ? "ONLINE" : "OFFLINE"
            statusDescriptionImageView.image = UIImage(named: isOnline ? "rocket" : "block")
        }
        deviceImageView.image = UIImage(named: "gasDetector")
        statusDescriptionLabel.text = device.status?.uppercased()
    }
    
    func hideSkeleton() {
        contentView.hideSkeleton()
        gradientLayer.isHidden = false
        [deviceImageView, statusDescriptionLabel, statusDescriptionImageView].forEach {
            $0.isHidden = false
        }
    }
    
    func showSkeleton() {
        contentView.showAnimatedSkeleton(usingColor: .skeletonMainPurple)
        contentView.backgroundColor = .skeletonGray
        gradientLayer.isHidden = true
        [deviceImageView, statusDescriptionLabel, statusDescriptionImageView].forEach {
            $0.isHidden = true
        }
    }
    
    private func setupViews() {
        makeGradientBackground()
        
        clipsToBounds = true
        contentView.isSkeletonable = true
        contentView.addSubview(titleLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(statusView)
        contentView.addSubview(statusDescriptionView)
        contentView.addSubview(deviceImageView)
        statusDescriptionView.addSubview(statusDescriptionImageView)
        statusDescriptionView.addSubview(statusDescriptionLabel)
    }
    
    private func makeGradientBackground() {
        let topColor = UIColor(hex: "#AB69FF")
        let bottomColor = UIColor(hex: "#494BEB")
        
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        contentView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func makeConstraints() {
        statusView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(17)
            make.width.height.equalTo(12)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(statusView.snp.trailing).offset(5)
            make.centerY.equalTo(statusView)
            make.trailing.equalTo(deviceImageView.snp.leading).offset(-20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(17)
            make.trailing.equalTo(deviceImageView.snp.leading).offset(-20)
            make.top.equalTo(statusLabel.snp.bottom).offset(14)
        }
        
        deviceImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            make.width.height.equalTo(100)
        }
        
        statusDescriptionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-11)
        }
        
        statusDescriptionImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-4)
            make.top.equalToSuperview().offset(4)
            make.width.equalTo(18)
            make.height.equalTo(19)
        }
        
        statusDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(statusDescriptionImageView.snp.trailing).offset(18)
            make.centerY.equalTo(statusDescriptionImageView)
            make.trailing.equalToSuperview().offset(-30)
        }
    }
}
