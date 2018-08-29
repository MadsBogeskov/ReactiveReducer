import Foundation
import ReSwift

let loggingMiddleware: Middleware<Any> = { dispatch, getState in
    return { next in
        return { action in
            // perform middleware logic
            print(action)
            
            // call next middleware
            return next(action)
        }
    }
}

let fetchTodoMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            guard let todoAction = action as? MyActions else {
                next(action)
                return
            }
            
            guard case MyActions.loadMore = todoAction else {
                next(action)
                return
            }
            
            next(MyActions.loading)
            let count = getState()?.count ?? 1
            URLSession.shared.dataTask(with: URL(string: "https://jsonplaceholder.typicode.com/todos/\(count)")!, completionHandler: { (data, response, error) in
                let todo = try! JSONDecoder().decode(Todo.self, from: data!)
                next(MyActions.newTodo(todo))
            }).resume()
        }
    }
}
