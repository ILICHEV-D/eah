import Foundation
import SwiftUI

enum helpEnumIngredients: String {
    case chickenThigh = "Курица"
    case cucumber = "Огурец"
    case cucumber1 = "Огурец маринованный"
    case tomato = "Помидор"
    case tomato1 = "Помидоры черри"
    case avocado = "Авокадо"
    case orange = "Апельсин"
    case cheese = "Сыр"
    case cheese2 = "Сыр твердый"
    case cheese3 = "Сыр мягкий"
    case cheese4 = "Сыр творожный"
    case cheese5 = "Сыр сливочный"
    case cheese6 = "Сыр полутвердый"
    case cheese7 = "Сыр плавленый"
    case cheese8 = "Сыр голландский"
    case cheese9 = "Сыр копченый"
    case bread = "Хлеб"
    case watermelon = "Арбуз"
    case corn = "Кукуруза"
    case potatoes = "Картофель"
    case apple = "Яблоко"
    case pear = "Груша"
    case limon = "Лимон"
    case banana = "Банан"
    case grape = "Виноград"
    case strawberry = "Клубника"
    case blueberries = "Черника"
    case melon = "Дыня"
    case cherry = "Вишня"
    case peach = "Персик"
    case mango = "Манго"
    case pineapple = "Ананас"
    case coconut = "Кокос"
    case kiwi = "Киви"
    case eggplant = "Баклажан"
    case broccoli = "Брокколи"
    case lettuce = "Листья салата"
    case redPepper = "Перец сладкий красный"
    case redPepper1 = "Перец болгарский"
    case redPepper2 = "Перец сладкий"
    case redPepper3 = "Перец сладкий зеленый"
    case redPepper4 = "Перец зеленый"
    case chili = "Перец"
    case chili1 = "Перец красный жгучий"
    case chili2 = "Перец чили"
    case chili3 = "Перец кайен"
    case carrot = "Морковь"
    case olives = "Оливки"
    case olives1 = "Оливки черные"
    case garlic = "Чеснок"
    case onion = "Лук"
    case onion1 = "Лук зеленый"
    case onion2 = "Лук репчатый"
    case onion3 = "Лук красный"
    case onion4 = "Лук-порей"
    case croissant = "Круассан"
    case bun = "Булочка"
    case egg = "Яйца"
    case egg1 = "Яйцо куриное"
    case egg2 = "Яйцо перепелиное"
    case butter = "Масло сливочное"
    case oil = "Масло растительное"
    case oil1 = "Масло оливковое"
    case oil2 = "Масло льняное"
    case oil3 = "Масло подсолнечное"
    case oil4 = "Масло кунжутное"
    case oil5 = "Масло кокосовое"
    case bacon = "Бекон"
    case meat = "Мясо"
    case beef = "Говядина"
    case flatbread = "Лепешка"
    case jam = "Джем абрикосовый"
    case jam1 = "Джем"
    case jam2 = "Варенье"
    case jam3 = "Джем апельсиновый"
    case shrimp = "Креветки"
    case oyster = "Устрица"
    case rice = "Рис"
    case iceCream = "Мороженное"
    case chocolate = "Шоколад"
    case chocolate1 = "Шоколад белый"
    case chocolate2 = "Шоколад темный"
    case chocolate3 = "Шоколад молочный"
    case chestnut = "Каштан"
    case peanut = "Арахис"
    case honey = "Мед"
    case milk = "Молоко"
    case milk1 = "Молоко топленое"
    case milk2 = "Молоко соевое"
    case milk3 = "Молоко кокосовое"
    case milk4 = "Кефир"
    case ice = "Лед"
    case wine = "Вино"
    case cognac = "Коньяк"
    case spices = "Приправа"
    case spices1 = "Специи"
    case spices2 = "Соль"
    case spices3 = "Сахар"
    case spices4 = "Сахарная пудра"
    case spices5 = "Сахар тростниковый"
    case spices6 = "Сахар коричневый"
}

func convertIngridient(item: helpEnumIngredients?, ingr: Ingredient) -> Ingredient {
    var ingredient = Ingredient(uid: ingr.uid, name: ingr.name, amount: ingr.amount, unit: ingr.unit)
    switch item {
    case .chickenThigh:
        ingredient.imageSmile = "🍗"
        ingredient.color = Color("breadColor")
        return ingredient
    case .cucumber, .cucumber1:
        ingredient.imageSmile = "🥒"
        ingredient.color = Color("cucumberColor")
        return ingredient
    case .tomato, .tomato1:
        ingredient.imageSmile = "🍅"
        ingredient.color = Color("tomatoColor")
        return ingredient
    case .chili:
        ingredient.imageSmile = "🌶"
        ingredient.color = Color("chiliColor")
        return ingredient
    case .egg:
        ingredient.imageSmile = "🥚"
        ingredient.color = Color("eggColor")
        return ingredient
    case .potatoes:
        ingredient.imageSmile = "🍠"
        ingredient.color = Color("potatoesColor")
        return ingredient
    case .avocado:
        ingredient.imageSmile = "🥑"
        ingredient.color = Color("avocadoColor")
        return ingredient
    case .orange:
        ingredient.imageSmile = "🍊"
        ingredient.color = Color("orangeColor")
        return ingredient
    case .cheese, .cheese2, .cheese3, .cheese4, .cheese5, .cheese6, .cheese7, .cheese8, .cheese9:
        ingredient.imageSmile = "🧀"
        ingredient.color = Color("cheeseColor")
        return ingredient
    case .bread:
        ingredient.imageSmile = "🍞"
        ingredient.color = Color("breadColor")
        return ingredient
    case .watermelon:
        ingredient.imageSmile = "🍉"
        ingredient.color = Color("watermelonColor")
        return ingredient
    case .corn:
        ingredient.imageSmile = "🌽"
        ingredient.color = Color("cornColor")
        return ingredient
    case .apple:
        ingredient.imageSmile = "🍎"
        ingredient.color = Color("cornColor")
        return ingredient
    case .pear:
        ingredient.imageSmile = "🍐"
        ingredient.color = Color("cornColor")
        return ingredient
    case .limon:
        ingredient.imageSmile = "🍋"
        ingredient.color = Color("cornColor")
        return ingredient
    case .banana:
        ingredient.imageSmile = "🍌"
        ingredient.color = Color("cornColor")
        return ingredient
    case .grape:
        ingredient.imageSmile = "🍇"
        ingredient.color = Color("cornColor")
        return ingredient
    case .strawberry:
        ingredient.imageSmile = "🍓"
        ingredient.color = Color("cornColor")
        return ingredient
    case .blueberries:
        ingredient.imageSmile = "🫐"
        ingredient.color = Color("cornColor")
        return ingredient
    case .melon:
        ingredient.imageSmile = "🍈"
        ingredient.color = Color("cornColor")
        return ingredient
    case .cherry:
        ingredient.imageSmile = "🍒"
        ingredient.color = Color("cornColor")
        return ingredient
    case .peach:
        ingredient.imageSmile = "🍑"
        ingredient.color = Color("cornColor")
        return ingredient
    case .mango:
        ingredient.imageSmile = "🥭"
        ingredient.color = Color("cornColor")
        return ingredient
    case .pineapple:
        ingredient.imageSmile = "🍍"
        ingredient.color = Color("cornColor")
        return ingredient
    case .coconut:
        ingredient.imageSmile = "🥥"
        ingredient.color = Color("cornColor")
        return ingredient
    case .kiwi:
        ingredient.imageSmile = "🥝"
        ingredient.color = Color("cornColor")
        return ingredient
    case .eggplant:
        ingredient.imageSmile = "🍆"
        ingredient.color = Color("cornColor")
        return ingredient
    case .broccoli:
        ingredient.imageSmile = "🥦"
        ingredient.color = Color("cornColor")
        return ingredient
    case .lettuce:
        ingredient.imageSmile = "🥬"
        ingredient.color = Color("cornColor")
        return ingredient
    case .redPepper:
        ingredient.imageSmile = "🌶"
        ingredient.color = Color("cornColor")
        return ingredient
    case .redPepper1, .redPepper2, .redPepper3, .redPepper4:
        ingredient.imageSmile = "🫑"
        ingredient.color = Color("cornColor")
        return ingredient
    case  .chili1, .chili2, .chili3:
        ingredient.imageSmile = "🌶"
        ingredient.color = Color("cornColor")
        return ingredient
    case .carrot:
        ingredient.imageSmile = "🥕"
        ingredient.color = Color("cornColor")
        return ingredient
    case  .olives, .olives1:
        ingredient.imageSmile = "🫒"
        ingredient.color = Color("cornColor")
        return ingredient
    case .garlic:
        ingredient.imageSmile = "🧄"
        ingredient.color = Color("cornColor")
        return ingredient
    case .onion, .onion1, .onion2, .onion3, .onion4:
        ingredient.imageSmile = "🧅"
        ingredient.color = Color("cornColor")
        return ingredient
    case .croissant:
        ingredient.imageSmile = "🌽"
        ingredient.color = Color("cornColor")
        return ingredient
    case .bun:
        ingredient.imageSmile = "🥔"
        ingredient.color = Color("cornColor")
        return ingredient
    case .egg1, .egg2:
        ingredient.imageSmile = "🥚"
        ingredient.color = Color("cornColor")
        return ingredient
    case .butter:
        ingredient.imageSmile = "🧈"
        ingredient.color = Color("cornColor")
        return ingredient
    case .oil, .oil1, .oil2, .oil3, .oil4, .oil5:
        ingredient.imageSmile = "🍶"
        ingredient.color = Color("cornColor")
        return ingredient
    case  .bacon:
        ingredient.imageSmile = "🥓"
        ingredient.color = Color("cornColor")
        return ingredient
    case  .meat:
        ingredient.imageSmile = "🥩"
        ingredient.color = Color("cornColor")
        return ingredient
    case .beef:
        ingredient.imageSmile = "🍖"
        ingredient.color = Color("cornColor")
        return ingredient
    case .flatbread:
        ingredient.imageSmile = "🫓"
        ingredient.color = Color("cornColor")
        return ingredient
    case .jam, .jam1, .jam2, .jam3:
        ingredient.imageSmile = "🥫"
        ingredient.color = Color("cornColor")
        return ingredient
    case  .shrimp:
        ingredient.imageSmile = "🍤"
        ingredient.color = Color("cornColor")
        return ingredient
    case  .oyster:
        ingredient.imageSmile = "🦪"
        ingredient.color = Color("cornColor")
        return ingredient
    case  .rice:
        ingredient.imageSmile = "🍚"
        ingredient.color = Color("cornColor")
        return ingredient
    case  .iceCream:
        ingredient.imageSmile = "🍨"
        ingredient.color = Color("cornColor")
        return ingredient
    case .chocolate, .chocolate1, .chocolate2, .chocolate3:
        ingredient.imageSmile = "🍫"
        ingredient.color = Color("cornColor")
        return ingredient
    case .chestnut:
        ingredient.imageSmile = "🌰"
        ingredient.color = Color("cornColor")
        return ingredient
    case .peanut:
        ingredient.imageSmile = "🥜"
        ingredient.color = Color("cornColor")
        return ingredient
    case .honey:
        ingredient.imageSmile = "🍯"
        ingredient.color = Color("cornColor")
        return ingredient
    case .milk, .milk1, .milk2, .milk3, .milk4:
        ingredient.imageSmile = "🥛"
        ingredient.color = Color("cornColor")
        return ingredient
    case  .ice:
        ingredient.imageSmile = "🧊"
        ingredient.color = Color("cornColor")
        return ingredient
    case .wine:
        ingredient.imageSmile = "🍷"
        ingredient.color = Color("cornColor")
        return ingredient
    case .cognac:
        ingredient.imageSmile = "🥃"
        ingredient.color = Color("cornColor")
        return ingredient
    case .spices, .spices1, .spices2, .spices3, .spices4, .spices5, .spices6:
        ingredient.imageSmile = "🧂"
        ingredient.color = Color("cornColor")
        return ingredient
    case .none:
        ingredient.imageSmile = "🍽"
        ingredient.color = Color("cornColor")
        return ingredient
    }
}
