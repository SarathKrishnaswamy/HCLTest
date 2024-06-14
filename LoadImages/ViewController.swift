//
//  ViewController.swift
//  LoadImages
//
//  Created by Sarath krishnaswamy on 14/06/24.
//

import UIKit
import SDWebImage


class ViewController: UIViewController{
   
    

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = ImageViewModel()
    var activityIndicator = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //self.showActivityIndicator(activityIndicator)
        
        self.viewModel.onDataFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
               // self?.hideActivityIndicator(self?.activityIndicator ?? UIActivityIndicatorView())
            }
        }
        
        self.viewModel.onError = { error in
            self.showErrorAlert(error: error)
           // self.hideActivityIndicator(self.activityIndicator)
        }
        
        viewModel.fetchData()
    }
    
    func showErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }


}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.images?.hits.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
        let images = viewModel.images?.hits[indexPath.row].previewURL ?? ""
        cell.thumbnailImage.sd_setImage(with: URL(string: images))
        cell.titleLbl.text = viewModel.images?.hits[indexPath.row].tags ?? ""
        return cell
    }
}
