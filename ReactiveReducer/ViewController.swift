import UIKit
import ReSwift

class ViewController: UITableViewController, StoreSubscriber {
    // Define the type of substate that we are interesting in for this class
    typealias StoreSubscriberStateType = [Todo]
    
    let store = Store<AppState>(reducer: mainReducer, state: nil, middleware: [loggingMiddleware, fetchTodoMiddleware])
    
    @IBAction func add() {
        store.dispatch(MyActions.loadMore)
    }
    
    var currState: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.subscribe(self) { $0.select { $0.todos } }
        store.dispatch(MyActions.loadMore)
    }
    
    func newState(state: ViewController.StoreSubscriberStateType) {
        currState = state
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if store.state.loading {
            return currState.count + 1
        } else {
            return currState.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item >= currState.count {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = "Loading"
            return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = currState[indexPath.item].title
            return cell
        }
    }
}
