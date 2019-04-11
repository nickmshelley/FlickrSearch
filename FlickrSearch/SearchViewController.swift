
import UIKit

class SearchViewController: UIViewController {
    let searchBar = UISearchBar(frame: .zero)
    let tableView = UITableView(frame: .zero, style: .plain)
    var images: [FlickrImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ImageCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.rowHeight = 99
        
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
        searchBar.delegate = self
    }
}

extension SearchViewController {
    func loadImages(text: String, isInitialSearch: Bool) {
        if isInitialSearch {
            images = []
        }
        
        let page = (images.count / 25) + 1
        
        SearchInteractor.search(text: text, page: page) { images in
            DispatchQueue.main.async { [weak self] in
                self?.images.append(contentsOf: images)
                self?.tableView.reloadData()
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadImages(text: searchBar.text ?? "", isInitialSearch: true)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let image = images[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ImageCell
        
        cell.configure(url: image.imageURL(isThumbnail: true), title: image.title)
        
        if indexPath.row == images.count - 1 {
            loadImages(text: searchBar.text ?? "", isInitialSearch: false)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ImageViewController(url: images[indexPath.row].imageURL())
        navigationController?.pushViewController(vc, animated: true)
    }
}
