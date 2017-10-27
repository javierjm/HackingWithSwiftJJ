
import UIKit
import RxSwift
import RxCocoa

class ViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var shownCities = [String]() // Data source for UITableView
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"] // Our mocked API data source
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchBar
            .rx.text // Observable property thanks to RxCocoa
            .orEmpty // Non Optional
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait for 0.5 seconds
            .filter { !$0.isEmpty } // If the new value is really new, filter for non-empty query.
            .subscribe(onNext: {[unowned self] query in // Here we subscribe to every new value
                self.shownCities = self.allCities.filter{$0.hasPrefix(query)} // We now do our "API Request" to find cities
                    self.tableView.reloadData()
                })
        .disposed(by:disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: TableView Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
    
    //      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -&gt; UITableViewCell {
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        cell.textLabel?.text = shownCities[indexPath.row]
        
        return cell
    }

}

