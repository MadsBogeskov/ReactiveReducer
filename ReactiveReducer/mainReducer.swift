import Foundation
import ReSwift

func mainReducer(action: Action, appState: AppState?) -> AppState {
    var appState = appState ?? AppState(count: 1, todos: [], loading: false)
    
    switch action {
    case let a as MyActions:
        switch a {
        case .loadMore: break
        case .loading: appState.loading = true
        case .newTodo(let todo):
            appState.count = appState.count + 1
            appState.loading = false
            appState.todos += [todo]
        }
    default: break
    }
    
    return appState
}
