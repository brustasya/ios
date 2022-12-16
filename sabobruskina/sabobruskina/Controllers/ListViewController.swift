//
//  ListViewController.swift
//  sabobruskina
//
//  Created by Станислава on 15.12.2022.
//

import UIKit

final class ListViewController: UIViewController {
    private var tableView = UITableView(frame: .zero, style: .plain)
    private var background = UIColor(rgb: "#aca095")
    private var tableBackground = UIColor(rgb: "#efe9e5")
    private var itemsViewModels = [ItemViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI(){
        view.backgroundColor = background
        configureTableView()
    }
    
    private func configureTableView() {
        setTableViewUI()
        setTableViewDelegate()
        setTableViewCell()
    }
    
    private func setTableViewUI() {
        view.addSubview(tableView)
        tableView.backgroundColor = tableBackground
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = 50
        tableView.pinLeft(to: view)
        tableView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        tableView.pinRight(to: view)
        tableView.pinBottom(to: view)
    }
    
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setTableViewCell() {
        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.reuseIdentifier)
    }
    
    private func fetchItems() {
        itemsViewModels.append(
            ItemViewModel (
                title: "Список вещей",
                controller: ThingsViewController()
            )
        )
        
        itemsViewModels.append(
            ItemViewModel (
                title: "Фотографии",
                controller: PhotoListViewController()
            )
        )
    }
    
    // MARK: - Public Methods
    public func setupNavbar(with name: String) {
        navigationItem.title = name
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(goBack)
        )
        
        navigationItem.leftBarButtonItem?.tintColor = .label
    }
    
    // MARK: - Objc functions
    @objc
    private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = itemsViewModels[indexPath.row]
        if let itemCell = tableView.dequeueReusableCell (
            withIdentifier: ItemCell.reuseIdentifier,
            for: indexPath
        ) as? ItemCell {
            itemCell.configure(with: viewModel)
            return itemCell
        }
        return UITableViewCell()
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
        navigationController?.pushViewController(itemsViewModels[indexPath.row].controller!, animated: true)
    }
}


