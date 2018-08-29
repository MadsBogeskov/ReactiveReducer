import Foundation
import ReSwift

enum MyActions: Action {
    case loadMore
    case loading
    case newTodo(Todo)
}
