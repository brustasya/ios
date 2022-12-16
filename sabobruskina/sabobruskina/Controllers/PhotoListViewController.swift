//
//  PhotoListViewController.swift
//  sabobruskina
//
//  Created by Станислава on 15.12.2022.
//

import UIKit

final class PhotoListViewController: UIViewController {
    private var tableView = UITableView(frame: .zero, style: .plain)
    private var background = UIColor(rgb: "#aca095")
    private var tableBackground = UIColor(rgb: "#efe9e5")
    private var photoesViewModels = [TripViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
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
        navigationItem.title = "Фотографии"
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
        tableView.rowHeight = 120
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
        tableView.register(TripCell.self, forCellReuseIdentifier: TripCell.reuseIdentifier)
    }
    
    private func addPhoto() {
        photoesViewModels.append(
            TripViewModel (
                title: "Название",
                description: "Описание"
            )
        )
        
        tableView.reloadData()
    }
    
    // MARK: - Public methods
    private func handleDelete(indexPath: IndexPath) {
        photoesViewModels.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    // MARK: - Objc functions
    @objc
    private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func addNewCell() {
        addPhoto()
    }
}

extension PhotoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoesViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = photoesViewModels[indexPath.row]
        
        if let photoCell = tableView.dequeueReusableCell (
            withIdentifier: TripCell.reuseIdentifier,
            for: indexPath
        ) as? TripCell {
            photoCell.setController(controller: self)
            photoCell.configure(with: viewModel)
            
            viewModel.image = photoCell.getImage()
            viewModel.title = photoCell.getTitle()
            viewModel.description = photoCell.getDescription()
            
            return photoCell
        }
        
        return UITableViewCell()
    }
}

extension PhotoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
        
        let photoVC = PhotoViewController()
        photoVC.configure(with: photoesViewModels[indexPath.row])
        navigationController?.pushViewController(photoVC, animated: true)
    }
    
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

