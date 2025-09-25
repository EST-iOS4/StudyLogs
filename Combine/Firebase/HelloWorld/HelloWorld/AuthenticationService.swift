//
//  AuthenticationService.swift
//  HelloWorld
//
//  Created by Jungman Bae on 9/25/25.
//
import Firebase
import Combine
import FirebaseAuth

class AuthenticationService: ObservableObject {
  @Published var user: User?
  @Published var isAuthenticated = false

  private var authStateHandle: AuthStateDidChangeListenerHandle?

  init() {
    addAuthStateListener()
  }

  deinit {
    if let handle = authStateHandle {
      Auth.auth().removeStateDidChangeListener(handle)
    }
  }

  private func addAuthStateListener() {
    authStateHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
      DispatchQueue.main.async {
        self?.user = user
        self?.isAuthenticated = user != nil
      }
    }
  }

  func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { result, error in
      if let error = error {
        completion(.failure(error))
      } else {
        completion(.success(()))
      }
    }
  }

  func signOut() {
    do {
      try Auth.auth().signOut()
    } catch {
      print("Sign out error: \(error.localizedDescription)")
    }
  }

}
