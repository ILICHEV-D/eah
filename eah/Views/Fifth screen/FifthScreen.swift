//
//  FifthScreen.swift
//  eah
//
//  Created by Danil Ilichev on 27.04.2021.
//



import SwiftUI

struct FifthScreen: View {
    
    
    @EnvironmentObject var viewModel: ContentViewModel
    
    @State private var selectorIndex = 0
    @State private var numbers = ["Избранные", "Помощь"]
    @State private var userName: () = AuthApi.loadName()
    @State private var userImage: UIImage? = AuthApi.userImage 
    @State private var selection: Int? = nil
    @State private var showingOptions = false
    @State private var show_modal: Bool = false
    
    @State var showImagePicker: Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                
                ZStack {
                    Spacer()
                    Text("Аккаунт")
                        .fontWeight(.semibold)
                    Spacer()
                    
                    
                    Button(action: {
                        self.show_modal = true
                    }, label: {
                        Spacer()
                        Image(systemName: "person.crop.rectangle")
                            .font(.title2)
                            .frame(width: 40, height: 40, alignment: .center).cornerRadius(9.5)
                            .background(Color(UIColor.systemGray).opacity(0.12))
                            .foregroundColor(.black)
                            .cornerRadius(9.5)
                    }).sheet(isPresented: self.$show_modal) {
                        AuthScreen()
                    }
                }.padding().frame(width: UIScreen.screenWidth, height: 50, alignment: .center)
                
                ScrollView{
                    
                    VStack(spacing: 10) {
                        
                        ZStack {
                            
                            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                                
                                Button(action: {
                                    showingOptions = true
                                }) {
                                    Image(uiImage: userImage ?? UIImage()).renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 120, height: 120, alignment: .center)
                                        .background(Color(.systemGray5))
                                        .cornerRadius(60)
                                }
                                .actionSheet(isPresented: $showingOptions) {
                                    ActionSheet(
                                        title: Text("Изменить изображение профиля"),
                                        buttons: [
                                            .default(Text("Изменить")) {
                                                self.showImagePicker.toggle()
                                            },
                                            .cancel(Text("Отмена")) {
                                                showingOptions = false
                                            },
                                            
                                                .destructive(Text("Удалить")) {
                                                    self.userImage = UIImage(named: "profile")
                                                },
                                        ]
                                    )
                                }
                                
                            })
                                .sheet(isPresented: $showImagePicker) {
                                    ImagePicker(sourceType: .photoLibrary) { image in
                                        self.userImage = image
                                    }
                                }
                        }
                        
                        Text(viewModel.userName)
                            .font(.system(size: 17))
                            .fontWeight(.medium)
                        
                        Picker("Numbers", selection: $selectorIndex) {
                            ForEach(0 ..< numbers.count) { index in
                                Text(self.numbers[index]).fontWeight(.medium).tag(index)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal, 19).padding(.top, 15)
                        
                        if selectorIndex == 0 {
                            VStack {
                                ScrollView(.horizontal, showsIndicators: false, content: {
                                    HStack(spacing: 16){
                                        ForEach(viewModel.favoriteMeals){
                                            item in
                                            NavigationLink(
                                                destination: MealView(item: item, fromMealPlanner: false),
                                                label: {
                                                    MealPlanner(item: item)
                                                }
                                            )
                                        }
                                    }.padding()
                                })
                                
                                NavigationLink(destination: ListOfMeals(searchStatus: true, items: viewModel.allItems, index: 0), tag: 0, selection: $selection)
                                {
                                    
                                    Button(action: {
                                        viewModel.allItemsLimit += 10
                                        viewModel.endpoint0 = Endpoint(index: 0, limit: viewModel.allItemsLimit)!
                                        self.selection = 0
                                    }) {
                                        HStack {
                                            Text("Больше рецептов")
                                                .font(.system(size: 16))
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                            Spacer()
                                            Image("arrow")
                                        }.padding()
                                            .frame(width: UIScreen.screenWidth - 100, height: 55, alignment: .center)
                                            .background(Color("mainColor"))
                                            .cornerRadius(16)
                                            .shadow(color: Color("mainColor").opacity(0.2), radius: 5, x: 3, y: 3)
                                    }
                                }
                            }
                        } else  if selectorIndex == 1 {
                            VStack{
                                Image("supportHeadphones")
                                Text("Как мы можем вам помочь?")
                                    .font(.system(size: 20))
                                    .fontWeight(.medium)
                                    .padding(.bottom, 20)
                                HStack(spacing: 20) {
                                    Button(action: {
                                        EmailHelper.shared.sendEmail(subject: "", body: "", to: "")
                                    }) {
                                        Image("email")
                                            .resizable()
                                            .frame(width: 35, height: 35, alignment: .center)
                                    }
                                    Button(action: {
                                        AuthApi.goToTelegram()
                                    }) {
                                        Image("telegram")
                                            .resizable()
                                            .frame(width: 32, height: 32, alignment: .center)
                                    }
                                }
                            }.padding(.top, 35)
                        }
                    }
                }.navigationBarHidden(true)
            }.navigationViewStyle(StackNavigationViewStyle())
        }
        
    }
}

struct FifthScreen_Previews: PreviewProvider {
    static var previews: some View {
        FifthScreen().environmentObject(ContentViewModel())
    }
}
