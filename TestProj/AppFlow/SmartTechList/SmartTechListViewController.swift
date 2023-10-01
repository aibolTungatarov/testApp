//
//  SmartTechListViewController.swift
//  TestProj
//
//  Created by Айбол on 28.09.2023.
//

import UIKit
import SkeletonView
import SnapKit

final class SmartTechListViewController: UIViewController {
    enum Route: String {
      case warningDeleteItem
   }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Умные\nвещи"
        label.numberOfLines = 0
        label.textColor = .skeletonGray
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 44
        view.register(SmartTechListCell.self, forCellReuseIdentifier: "\(SmartTechListCell.self)")
        return view
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(refreshButtonTap), for: .touchUpInside)
        button.backgroundColor = .white
        button.setTitle("обновить".uppercased(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 24, bottom: 15, right: 24)
        return button
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView {
            self.errorView.isHidden = true
            self.refreshButtonTap()
        }
        return view
    }()
    
    private var viewModel : SmartTechListViewModel
    private var router: Router
    private var shouldShowSkeleton = true
    
    init(viewModel: SmartTechListViewModel, router: Router) {
        self.router = router
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        makeConstraints()
        loadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        refreshButton.layer.cornerRadius = 20
    }
    
    private func setupViews() {
        errorView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.bindEmployeeViewModelToController = { [weak self] in
            self?.updateDataSource()
        }
        
        view.backgroundColor = .mainPurple
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(refreshButton)
        view.addSubview(errorView)
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-32)
            make.bottom.equalToSuperview()
        }
        
        refreshButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-17)
            make.bottom.equalToSuperview().offset(-26)
            make.height.equalTo(50)
        }
        
        errorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func loadData() {
        viewModel.getDevices()
        shouldShowSkeleton = true
        tableView.reloadData()
    }
    
    private func updateDataSource() {
        DispatchQueue.main.async {
            self.shouldShowSkeleton = false
            self.titleLabel.textColor = .textPurple
            self.errorView.isHidden = !(self.viewModel.devices?.isEmpty ?? true)
            self.tableView.reloadData()
        }
    }
    
    private func showDeleteWarningView(index: Int) {
        router.route(to: Route.warningDeleteItem.rawValue, from: self, parameters: index)
    }
    
    @objc private func refreshButtonTap() {
        titleLabel.textColor = .skeletonGray
        viewModel.getDevices()
        shouldShowSkeleton = true
        tableView.reloadData()
    }
}

extension SmartTechListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.devices?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            showDeleteWarningView(index: indexPath.section)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SmartTechListCell = tableView.dequeueReusableCell(withIdentifier: "\(SmartTechListCell.self)", for: indexPath) as? SmartTechListCell else {
            return UITableViewCell()
        }
        
        if shouldShowSkeleton {
            cell.showSkeleton()
        } else {
            cell.hideSkeleton()
            cell.configure(device: viewModel.devices?[indexPath.section])
        }
        cell.selectionStyle = .none
        
        return cell
    }
}
