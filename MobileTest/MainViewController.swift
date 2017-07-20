import UIKit



class MainViewController: UIViewController, EmployeesSource, HierarchyStoring {
    let companyService = CompanyService.main
    
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var managerView: EmployeeView!
    @IBOutlet weak var collectionHeader: UILabel!
    
    var manager: Employee?
    var employees: [Employee] = []
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.heading.text = "LOADING..."

        func update(with employees: [Employee]) {
            self.employees = employees
            self.collectionView?.reloadData()
        }
        
        switch self.manager {
        case .some(let manager):
            self.heading.text = manager.department
            self.managerView.fill(for: manager)
            
            companyService.getAvatar(from: URL(string: manager.profilePic)!, into: self.managerView.set(avatar:))
            companyService.getEmployees(forManagerId: manager.id, completion: update(with:))
            
        case .none:
            self.collectionHeader.isHidden = true
            self.managerView.isHidden = true
            
            companyService.getTopLevelEmployees(completion: update(with:))
            
            companyService.getCompanyName() { name in
                self.heading.text = name
            }
        }
        
        self.navigationItem.title = self.hierarchyString()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = (self.manager == nil)
    }
    
    // user actions
    
    func selected(at index: Int) {
        let manager = self.employees[index]
        
        switch manager.isManager {
        case true:
            if let managerViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: MainViewController.self)) as? MainViewController {
                managerViewController.manager = manager
                self.navigationController?.pushViewController(managerViewController, animated: true)
            }
            
        case false:
            if let detailesViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: DetailsViewController.self)) as? DetailsViewController {
                detailesViewController.employee = manager
                self.navigationController?.pushViewController(detailesViewController, animated: true)
            }
        }
        
        
    }
    
    // collection view
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case String(describing: EmployeeCollectionViewController.self):
            if let collectionViewController = segue.destination as? EmployeeCollectionViewController {
                collectionViewController.dataSource = self
                self.collectionView = collectionViewController.collectionView
            }
        default: break
        }
    }
}
