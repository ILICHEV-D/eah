//
//  AuthScreen.swift
//  eah
//
//  Created by Danil Ilichev on 22.11.2021.
//

import SwiftUI

struct AuthScreen: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    
    @State var loginQuery = ""
    @State var passwordQuery = ""
    @State var passwordСheckQuery = ""
    @State var nameQuery = ""
    @State var ageQuery = ""
    @State var errorMessage: String? = nil
    @State var tokenState = AuthApi.token
    var sexQuery: Bool? {
        if selectedStrength == "Мужской" {
            return true
        } else if selectedStrength == "Женский" {
            return false
        } else {
            return nil
        }
    }
    
    @State var registrationIsShow = false
    
    @State private var selectedStrength = "Не выбран"
    let strengths = ["Не выбран", "Мужской", "Женский"]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            VStack{
                
                HStack {
                    Spacer()
                    Text("Аккаунт").fontWeight(.semibold)
                    Spacer()
                }.padding().frame(width: UIScreen.screenWidth, height: 50, alignment: .center)
                
                ScrollView(showsIndicators: false){
                    VStack(spacing: 10) {
                        Image("door")
                            .resizable()
                            .frame(width: 180, height: 180, alignment: .center)
                            .padding(.bottom, 10)
                        
                        
                        if tokenState == nil {
                            Text("Чтобы узнать обо всех наших рецептах и функциях, пожалуйста, зарегистрируйтесь!")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                                .lineLimit(3)
                                .padding(.leading, 25)
                                .padding(.trailing, 25)
                                .multilineTextAlignment(.center)
                            
                            if errorMessage != nil {
                                Text(errorMessage!)
                                    .font(.system(size: 15))
                                    .fontWeight(.medium)
                                    .padding(.leading, 25)
                                    .padding(.trailing, 25)
                                    .multilineTextAlignment(.center)
                            }
                            
                            TextField("Email", text: $loginQuery, onCommit:  {
                                UIApplication.shared.endEditing()
                            }).padding()
                                .frame(width: UIScreen.screenWidth - 100, height: 55, alignment: .center)
                                .background(Color("arrowGrayColor"))
                                .cornerRadius(16)
                                .shadow(color: Color("arrowGrayColor").opacity(0.2), radius: 5, x: 3, y: 3)
                            
                            SecureField("Пароль", text: $passwordQuery, onCommit:  {
                                UIApplication.shared.endEditing()
                            }).padding()
                                .frame(width: UIScreen.screenWidth - 100, height: 55, alignment: .center)
                                .background(Color("arrowGrayColor"))
                                .cornerRadius(16)
                                .shadow(color: Color("arrowGrayColor").opacity(0.2), radius: 5, x: 3, y: 3)
                            
                            
                            if registrationIsShow {
                                
                                SecureField("Повторите парль", text: $passwordСheckQuery, onCommit:  {
                                    UIApplication.shared.endEditing()
                                }).padding()
                                    .frame(width: UIScreen.screenWidth - 100, height: 55, alignment: .center)
                                    .background(Color("arrowGrayColor"))
                                    .cornerRadius(16)
                                    .shadow(color: Color("arrowGrayColor").opacity(0.2), radius: 5, x: 3, y: 3)
                                
                                TextField("Имя", text: $nameQuery, onCommit:  {
                                    UIApplication.shared.endEditing()
                                }).padding()
                                    .frame(width: UIScreen.screenWidth - 100, height: 55, alignment: .center)
                                    .background(Color("arrowGrayColor"))
                                    .cornerRadius(16)
                                    .shadow(color: Color("arrowGrayColor").opacity(0.2), radius: 5, x: 3, y: 3)
                                
                                HStack(spacing: 5) {
                                    TextField("Возраст", text: $ageQuery, onCommit:  {
                                        UIApplication.shared.endEditing()
                                    }).padding()
                                        .frame(width: (UIScreen.screenWidth - 105)/2, height: 55, alignment: .center)
                                        .background(Color("arrowGrayColor"))
                                        .cornerRadius(16)
                                        .shadow(color: Color("arrowGrayColor").opacity(0.2), radius: 5, x: 3, y: 3)
                                        .keyboardType(.numberPad)
                                    
                                    
                                    Picker("Пол", selection: $selectedStrength) {
                                        ForEach(strengths, id: \.self) {
                                            Text($0)
                                                .foregroundColor(Color.red)
                                        }
                                    }
                                    .frame(width: (UIScreen.screenWidth - 105)/2, height: 55, alignment: .center)
                                    .pickerStyle(MenuPickerStyle())
                                    .background(Color("arrowGrayColor"))
                                    .cornerRadius(16)
                                    .shadow(color: Color("arrowGrayColor").opacity(0.2), radius: 5, x: 3, y: 3)
                                }
                            }
                            
                            Button(action: {
                                registrationIsShow = false
                                if loginQuery.count == 0 || passwordQuery.count == 0 {
                                    errorMessage = "Пустые поля"
                                } else {
                                    AuthApi.sendRequestSignIn(login: loginQuery, password: passwordQuery,  completion: { result in
                                        switch result {
                                        case .success(let response):
                                            if response.status == false {
                                                errorMessage = "Неправильно введенные данные"
                                            } else {
                                                self.presentationMode.wrappedValue.dismiss()
                                                AuthApi.saveAll(token: response.response.token, name: response.response.firstName ?? "", age: response.response.age ?? 0, sex: response.response.sex ?? true)
                                                DispatchQueue.main.sync {
                                                    viewModel.userName = response.response.firstName ?? ""
                                                }
                                                tokenState = AuthApi.token
                                                viewModel.loadFavorite()
                                                errorMessage = nil
                                            }
                                        case .failure(let error):
                                            errorMessage = error.localizedDescription
                                            print(error.localizedDescription)
                                        }
                                    })
                                }}, label: {
                                    if registrationIsShow {
                                        HStack {
                                            Text("Войти")
                                                .font(.system(size: 17))
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color("mainColor"))
                                        }.padding()
                                            .frame(width: UIScreen.screenWidth - 100, height: 55, alignment: .center)
                                            .cornerRadius(16)
                                    } else {
                                        HStack {
                                            Text("Войти")
                                                .font(.system(size: 17))
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                        }.padding()
                                            .frame(width: UIScreen.screenWidth - 100, height: 55, alignment: .center)
                                            .background(Color("mainColor"))
                                            .cornerRadius(16)
                                            .shadow(color: Color("mainColor").opacity(0.2), radius: 5, x: 3, y: 3)
                                    }
                                })
                            
                            
                            Button(action: {
                                registrationIsShow = true
                                guard passwordСheckQuery == passwordQuery else {
                                    errorMessage = "Пароли не совпадают"
                                    return
                                }
                                if loginQuery.count == 0 || passwordQuery.count == 0 {
                                    errorMessage = "Пустые поля"
                                } else {
                                    AuthApi.sendRequestSignUp(login: loginQuery, password: passwordQuery,  age: Int(ageQuery) ?? 0, sex: sexQuery, name: nameQuery, completion: { result in
                                        switch result {
                                        case .success(let response):
                                            if response.status == false {
                                                errorMessage = response.response
                                            } else {
                                                errorMessage = "Успешно зарегистрированы"
                                                AuthApi.sendRequestSignIn(login: loginQuery, password: passwordQuery,  completion: { result in
                                                    switch result {
                                                    case .success(let response):
                                                        if response.status == false {
                                                            errorMessage = "Неправильно введенные данные"
                                                        } else {
                                                            self.presentationMode.wrappedValue.dismiss()
                                                            AuthApi.saveAll(token: response.response.token, name: response.response.firstName ?? "", age: response.response.age ?? 0, sex: response.response.sex ?? true)
                                                            viewModel.userName = response.response.firstName ?? ""
                                                            tokenState = AuthApi.token
                                                            viewModel.loadFavorite()
                                                            errorMessage = nil
                                                        }
                                                    case .failure(let error):
                                                        errorMessage = "Неправильно введенные данные"
                                                        print(error.localizedDescription)
                                                    }
                                                })
                                            }
                                        case .failure(let error):
                                            errorMessage = "Ошибка"
                                            print(error.localizedDescription)
                                        }
                                    })
                                }}, label: {
                                    if registrationIsShow {
                                        Text("Зарегистрироваться")
                                            .font(.system(size: 17))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .padding()
                                            .frame(width: UIScreen.screenWidth - 100, height: 55, alignment: .center)
                                            .background(Color("mainColor"))
                                            .cornerRadius(16)
                                            .shadow(color: Color("mainColor").opacity(0.2), radius: 5, x: 3, y: 3)
                                    }
                                    else {
                                        Text("Зарегистрироваться")
                                            .font(.system(size: 17))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("mainColor"))
                                            .padding()
                                            .frame(width: UIScreen.screenWidth - 100, height: 55, alignment: .center)
                                            .cornerRadius(16)
                                    }
                                })
                            
                            
                        } else {
                            Button(action: {
                                AuthApi.deleteAll()
                                viewModel.userName = ""
                                viewModel.favoriteMeals = []
                                tokenState = AuthApi.token
                                
                            }, label: {
                                HStack {
                                    Text("Выйти")
                                        .font(.system(size: 17))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                }.padding()
                                    .frame(width: UIScreen.screenWidth - 100, height: 55, alignment: .center)
                                    .background(Color("mainColor"))
                                    .cornerRadius(16)
                                    .shadow(color: Color("mainColor").opacity(0.2), radius: 5, x: 3, y: 3)
                            })
                        }
                    }
                    
                    
                }
                .onAppear {UIScrollView.appearance().keyboardDismissMode = .interactive}
                .onTapGesture(perform: {hideKeyboard()})
                
            }.navigationBarHidden(true)
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
}


struct AuthScreen_Previews: PreviewProvider {
    static var previews: some View {
        AuthScreen()
    }
}
