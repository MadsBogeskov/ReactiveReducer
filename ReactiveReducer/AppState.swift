import ReSwift

struct AppState: StateType {
    var count: Int = 0
    var todos: [Todo] = []
    var loading = false
}
