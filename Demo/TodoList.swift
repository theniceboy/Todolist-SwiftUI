//
//  TodoList.swift
//  Demo
//
//  Created by David Chen on 8/2/19.
//  Copyright © 2019 David Chen. All rights reserved.
//

import SwiftUI


var exampletodos: [Todo] = [
    Todo(title: "擦地", dueDate: Date()),
    Todo(title: "洗锅", dueDate: Date().addingTimeInterval(30000)),
    Todo(title: "去驾校", dueDate: Date()),
    Todo(title: "做App", dueDate: Date()),
    Todo(title: "洗澡", dueDate: Date())
]

struct TodoList: View {
    @ObservedObject var main: Main
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(main.todos) { todo in
                    VStack {
                        if todo.i == 0 || formatter.string(from: self.main.todos[todo.i].dueDate) != formatter.string(from: self.main.todos[todo.i - 1].dueDate) {
                            HStack {
                                Spacer()
                                    .frame(width: 30)
                                Text(date2Word(date: self.main.todos[todo.i].dueDate))
                                Spacer()
                            }
                        }
                        HStack {
                            Spacer().frame(width: 20)
                            TodoItem(main: self.main, todoIndex: .constant(todo.i))
                                .cornerRadius(10.0)
                                .clipped()
                                .shadow(color: Color("todoItemShadow"), radius: 5)
                            Spacer().frame(width: 25)
                        }
                        Spacer().frame(height: 20)
                    }
                }
                Spacer()
                    .frame(height: 150)
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle(Text("待办事项").foregroundColor(Color("theme")))
            .onAppear {
                if let data = UserDefaults.standard.object(forKey: "todos") as? Data {
                    let todolist = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Todo] ?? []
                    for todo in todolist {
                        if !todo.checked {
                            self.main.todos.append(todo)
                        }
                    }
                    self.main.sort()
                } else {
                    self.main.todos = exampletodos
                    self.main.sort()
                }
            }
        }
    }
}


#if DEBUG
struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList(main: Main())
        //TodoDetails()
    }
}
#endif
