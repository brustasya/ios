//
//  ThingsViewController.swift
//  sabobruskina
//
//  Created by Станислава on 15.12.2022.
//

import UIKit
final class ThingsViewController: UIViewController {
    private var tableView = UITableView(frame: .zero, style: .plain)
    private var background = UIColor(rgb: "#aca095")
    private var tableBackground = UIColor(rgb: "#efe9e5")
    private var thingsModels = [ItemViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI(){
        view.backgroundColor = background
        setupNavbar()
        configureTableView()
        
    }
    
    private func setupNavbar() {
        navigationItem.title = "Список вещей"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(goBack)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus.circle"),
            style: .plain,
            target: self,
            action: #selector(addNewCell)
        )
        
        navigationItem.leftBarButtonItem?.tintColor = .label
        navigationItem.rightBarButtonItem?.tintColor = .label
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
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setTableViewCell() {
        tableView.register(ThingCell.self, forCellReuseIdentifier: ThingCell.reuseIdentifier)
    }
    
    private func addThings() {
        thingsModels.append(
            ItemViewModel (
                title: "Название",
                controller: self
            )
        )
        
        tableView.reloadData()
    }
    
    private func handleDelete(indexPath: IndexPath) {
        thingsModels.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    // MARK: - Objc functions
    @objc
    private func goBack() {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc
    private func addNewCell() {
        addThings()
    }
}

extension ThingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thingsModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = thingsModels[indexPath.row]
        
        if let thingCell = tableView.dequeueReusableCell (
            withIdentifier: ThingCell.reuseIdentifier,
            for: indexPath
        ) as? ThingCell {
            thingCell.configure(with: viewModel)
            viewModel.title = thingCell.getTitle()
            return thingCell
        }
        
        return UITableViewCell()
    }
}

extension ThingsViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: .none
        ) { [weak self] (action, view, completion) in
            self?.handleDelete(indexPath: indexPath)
            completion(true)
        }
        
        deleteAction.image = UIImage(
            systemName: "trash.fill",
            withConfiguration: UIImage.SymbolConfiguration(weight: .bold)
        )?.withTintColor(.white)
        
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

