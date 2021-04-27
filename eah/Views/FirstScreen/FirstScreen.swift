import SwiftUI

struct FirstScreen: View {
    
    init() {
        UINavigationBar.appearance().backgroundColor = .white
    //    UINavigationBar.appearance().isHidden = true
    }
//
    @EnvironmentObject var viewModel: ContentViewModel
    
//    let recomendationItems = Bundle.main.decode([Meal].self, from: "menu.json")
    
//    @State var selectedDay: Week = week.first!
    
 //   @State private var navBarHidden = false

    
    var body: some View {
        
        NavigationView{
            
            VStack {
//                HStack {
//                    Button(action: {}, label: {
//                        Image(systemName: "list.bullet")
//                            .font(.title2)
//                            .frame(width: 40, height: 40, alignment: .center).cornerRadius(9.5)
//                            .background(Color(UIColor.systemGray).opacity(0.12))
//                            .foregroundColor(.black)
//                    }).cornerRadius(9.5)
//
//                    Spacer()
//                    Text("Popular")
//                    Spacer()
//                    Button(action: {}, label: {
//                        Image(systemName: "magnifyingglass")
//                            .font(.title2)
//                            .frame(width: 40, height: 40, alignment: .center).cornerRadius(9.5)
//                            .background(Color(UIColor.systemGray).opacity(0.12))
//                            .foregroundColor(.black)
//                    }).cornerRadius(9.5)
//
//
//                }.padding()
                
            


                ScrollView(.vertical, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, content: {
                    VStack(spacing: 7.0){
                        Text("Hello Danil")
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .foregroundColor(Color("mainColor"))

                        Text("Wanna make some delicious food?")
                            .font(.system(size: 20))
                    }.padding()

                    HStack{

                        Text("Recomendation Recipe").font(.system(size: 18)).fontWeight(.semibold)

                        Spacer()


                        NavigationLink(destination: ListOfMeals(items: viewModel.recomendationItems)){
                            Text("See all").font(.system(size: 12))
                                .fontWeight(.medium)
                                .foregroundColor(Color("mainColor"))
                        }


                    }.padding(.trailing).padding(.leading)

                    ScrollView(.horizontal, showsIndicators: false, content: {

                        HStack(spacing: 16){
                            ForEach(viewModel.recomendationItems){
                                item in
                                NavigationLink(
                                    destination: MealView(item: item),
                                    label: {
                                        RecomendationRecipe(item: item)
                                    }
                                )

                            }
                        }.padding(.leading).padding(.bottom).padding(.trailing)
                    })



                    HStack{
                        Text("Popular").font(.system(size: 18)).fontWeight(.semibold)
                        Spacer()

                        NavigationLink(destination: ListOfMeals(items: viewModel.popular)){
                            Text("See all").font(.system(size: 12))
                                .fontWeight(.medium)
                                .foregroundColor(Color("mainColor"))
                        }

                    }.padding(.trailing).padding(.leading)

                    ScrollView(.horizontal, showsIndicators: false, content: {

                        HStack(spacing: 16){
                            ForEach(viewModel.popular){
                                item in
                                NavigationLink(
                                    destination: MealView(item: item),
                                    label: {
                                        Popular(item: item)
                                    }
                                )
                            }
                        }.padding(.leading).padding(.bottom).padding(.trailing)
                    })

                    HStack{
                        Text("Your Meal Planner").font(.system(size: 18)).fontWeight(.semibold)
                        Spacer()
                    }.padding(.trailing).padding(.leading)

                    ScrollView(.horizontal, showsIndicators: false, content: {

                        HStack(spacing: 16){
                            ForEach(viewModel.week){
                                item in
                                Button(action: {                                withAnimation(.spring()){
                                    viewModel.selectedDay = item
                                }}, label: {
                                    Text(item.name.prefix(3))
                                        .font(.system(size: 16))
                                        .fontWeight(.medium)
                                        .foregroundColor(viewModel.selectedDay.id == item.id ? Color("mainColor") : .gray)


                                }).padding(.vertical, 9)
                                .padding(.horizontal)
                                .background(viewModel.selectedDay.id == item.id ? Color("backColor") : Color(UIColor.systemGray6))
                                .cornerRadius(8)
                            }
                        }


                    }).padding()


                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing: 16){
                            ForEach(viewModel.mealPlanner){
                                item in

                                NavigationLink(
                                    destination: MealView(item: item),
                                    label: {
                                        MealPlanner(item: item)
                                    }
                                )
                            }
                        }.padding(.leading).padding(.bottom).padding(.trailing)
                    })
                })
            }//.navigationBarHidden(true)
            
            .navigationBarItems(leading:
                                    Image(systemName: "list.bullet")
                                    .font(.title2)
                                    .frame(width: 35, height: 35, alignment: .center).cornerRadius(9.5)
                                    .background(Color(UIColor.systemGray).opacity(0.12))
                                    .foregroundColor(.black)
                                    .cornerRadius(9.5)
                                , trailing:
                                    Button(action: {}, label: {
                                        Image(systemName: "magnifyingglass")
                                            .font(.title2)
                                            .frame(width: 35, height: 35, alignment: .center).cornerRadius(9.5)
                                            .background(Color(UIColor.systemGray).opacity(0.12))
                                            .foregroundColor(.black)
                                    }).cornerRadius(9.5)
            )
            .navigationBarTitle("Popular")
            .navigationBarTitleDisplayMode(.inline)
            


        }.navigationViewStyle(StackNavigationViewStyle())

       
        
    }
}

struct FirstScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen().environmentObject(ContentViewModel())
    }
}

