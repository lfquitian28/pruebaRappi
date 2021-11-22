//
//  MenuRappiCategoryViewController.swift
//  PruebaRappi
//
//  Created by luis quitan on 15/11/21.
//

import UIKit

class MenuRappiCategoryViewController: UIViewController {

    @IBOutlet weak var tableOptionsCategorys: UITableView!
    
    private let categorys = ["popular", "upcoming", "top_rated"]
    
    private var viewModel: RappiMovieCategoryViewModel!
    
    static func create(with viewModel: RappiMovieCategoryViewModel) -> MenuRappiCategoryViewController {
        let view = MenuRappiCategoryViewController(nibName: "MenuRappiCategoryViewController", bundle: Bundle.main)
        view.viewModel = viewModel
        return view
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        // Do any additional setup after loading the view.
    }

    private func configureTableView(){
        self.tableOptionsCategorys?.register(UINib(nibName: "OptionsCategoryViewCell", bundle: nil), forCellReuseIdentifier: "OptionsCategoryViewCell")
        
        let cellNib = UINib(nibName: "OptionsCategoryViewCell",bundle: nil)
        self.tableOptionsCategorys.register(cellNib, forCellReuseIdentifier: "OptionsCategoryViewCell")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MenuRappiCategoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "OptionsCategoryViewCell", for: indexPath) as? OptionsCategoryViewCell else {
            return UITableViewCell()
        }
        
        cell.createMenu(name: categorys[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorys.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.searchRappiCategory(width: categorys[indexPath.row])
        
    }
}
