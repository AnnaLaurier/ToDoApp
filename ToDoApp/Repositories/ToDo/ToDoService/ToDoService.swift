//
//  ToDoService.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import Foundation

final class ToDoService {
}

extension ToDoService: IToDoService {

    func getToDoList(
        completionQueue: DispatchQueue,
        completion: @escaping (Result<[ToDos], Error>) -> Void
    ) {
        guard let apiURL = URL(string: "https://dummyjson.com/todos") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: apiURL) { data, urlResponse, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }

            guard let data else {
                print("No data received")
                return
            }

            do {
                let fileData = try JSONDecoder().decode(ToDoDataModel.self, from: data)
                completionQueue.async {
                    completion(.success(fileData.todos))
                }
            } catch {
                completionQueue.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
