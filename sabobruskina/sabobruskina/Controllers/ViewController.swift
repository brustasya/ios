//
//  ViewController.swift
//  sabobruskina
//
//  Created by Станислава on 09.12.2022.
//

import UIKit

final class ViewController: UIViewController {
    private var tableView = UITableView(frame: .zero, style: .plain)
    private var tripsViewModels = [TripViewModel]()
    private var background = UIColor(rgb: "#aca095")
    private var tableBackground = UIColor(rgb: "#efe9e5")
    
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
        navigationItem.title = "Мои поездки"
        
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
    
    private func addTrip() {
        tripsViewModels.append(
            TripViewModel (
                title: "Название",
                description: "Описание"
            )
        )
        
        tableView.reloadData()
    }
    
    private func handleDelete(indexPath: IndexPath) {
        tripsViewModels.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    
    // MARK: - Objc functions
    @objc
    private func addNewCell() {
        addTrip()
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripsViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = tripsViewModels[indexPath.row]
        
        if let tripCell = tableView.dequeueReusableCell (
            withIdentifier: TripCell.reuseIdentifier,
            for: indexPath
        ) as? TripCell {
            tripCell.setController(controller: self)
            tripCell.configure(with: viewModel)
            
            viewModel.image = tripCell.getImage()
            viewModel.title = tripCell.getTitle()
            viewModel.description = tripCell.getDescription()
            
            return tripCell
        }
        
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
        let listVC = tripsViewModels[indexPath.row].controller! as! ListViewController
        listVC.setupNavbar(with: tripsViewModels[indexPath.row].title)
        navigationController?.pushViewController(listVC, animated: true)
    }
}

extension UIColor {
    
    static func subString(str: String, startIndex: Int, endIndex: Int) -> String {
        let start = str.index(str.startIndex, offsetBy: startIndex)
        let end = str.index(str.startIndex, offsetBy: endIndex)
        let range = start ..< end
        return String(str[range])
    }
    
    convenience init?(rgb: String) {
        let str = rgb.filter { $0 != "#" }
        if (str.count != 6) {
            return nil
        }
        
        let redHex = Self.subString(str: str, startIndex: 0, endIndex: 2)
        let greenHex = Self.subString(str: str, startIndex: 2, endIndex: 4)
        let blueHex = Self.subString(str: str, startIndex: 4, endIndex: 6)
        
        if let red = Int(redHex, radix: 16),
           let green = Int(greenHex, radix: 16),
           let blue = Int(blueHex, radix: 16) {
            self.init(
                red: CGFloat(red) / 255.0,
                green: CGFloat(green) / 255.0,
                blue: CGFloat(blue) / 255.0,
                alpha: 1
            )
        } else {
            return nil
        }
    }
}
