

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identified)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .black
        table.isScrollEnabled = false
        return table
    }()
    
    private let viewModels: [CollectionTableViewCellViewModel] = [
        CollectionTableViewCellViewModel(viewModels: [
            TileCollectionViewCellViewModel(name: "Apple", backgroundColor: .systemBlue),
            TileCollectionViewCellViewModel(name: "Google", backgroundColor: .systemRed ),
            TileCollectionViewCellViewModel(name: "Nvidia", backgroundColor: .systemYellow),
        ])
    ]
    
    private let url = "http://krokapp.by/api/get_points/11/"
    private var places: [Places] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getImagePlaces(url: url)
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 190),
        ])
    }
    
    private func getImagePlaces(url: String) {
        Alamofire.request(url).responseJSON { responce in
            guard let result = responce.data else { return }
            do {
                self.places = try JSONDecoder().decode([Places].self, from: result)
                print(self.places)
            } catch  {
                print(error)
            }
        }
    }
    
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identified,for: indexPath) as? CollectionTableViewCell else { fatalError() }
        cell.configure(with: viewModel)

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.width/2
    }
    
    
}

