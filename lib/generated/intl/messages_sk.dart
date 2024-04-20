// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a sk locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'sk';

  static String m0(x) => "Aktívne ${x}";

  static String m1(attribute) => "Akékoľvek ${attribute}";

  static String m2(point) => "Vaše body: ${point}";

  static String m3(state) => "Adaptér Bluetooth je ${state}";

  static String m4(currency) => "Mena bola zmenená na ${currency}";

  static String m5(priceRate, pointRate) => "${priceRate} = ${pointRate} bodov";

  static String m6(currency) => "${currency} nie je podporované";

  static String m7(day) => " pred${day} dňami";

  static String m8(total) => "~${total} km";

  static String m9(timeLeft) => "Končí o ${timeLeft}";

  static String m10(captcha) => "Zadajte ${captcha} na potvrdenie:";

  static String m11(message) => "Chyba: ${message}";

  static String m12(time) => "Platnosť vyprší o ${time}";

  static String m13(total) => ">${total} km";

  static String m14(hour) => " pred${hour} hodinami";

  static String m15(message) =>
      "Počas vyžiadania údajov sa vyskytol problém s aplikáciou. Kontaktujte správcu, aby problémy vyriešil: ${message}";

  static String m16(currency, amount) =>
      "Maximálna suma na použitie tejto platby je {${currency}} {${amount}}";

  static String m17(size) => "Maximálna veľkosť súboru: ${size} MB";

  static String m18(currency, amount) =>
      "Minimálna suma na použitie tejto platby je {${currency}} {${amount}}";

  static String m19(minute) => " pred${minute} minútami";

  static String m20(month) => " pred${month} mesiacmi";

  static String m21(store) => "Viac od používateľa ${store}";

  static String m22(itemCount) => " ${itemCount} položiek";

  static String m23(price) => "Celkom: ${price}";

  static String m24(total) => "Množstvo: ${total}";

  static String m25(percent) => "Zľava ${percent}%";

  static String m26(second) => " pred ${second} sek.";

  static String m27(totalCartQuantity) =>
      "Nákupný košík, ${totalCartQuantity} položiek";

  static String m28(numberOfUnitsSold) => "Predané: ${numberOfUnitsSold}";

  static String m29(fieldName) => "Pole ${fieldName} je povinné";

  static String m30(total) => "${total} produktov";

  static String m31(maxPointDiscount, maxPriceDiscount) =>
      "Použite maximálny počet bodov ${maxPointDiscount} na zľavu ${maxPriceDiscount} na túto objednávku!";

  static String m32(date) => "Platí do ${date}";

  static String m33(message) => "Upozornenie: ${message}";

  static String m34(defaultCurrency) =>
      "Aktuálna mena nie je dostupná pre funkciu Peňaženka. Zmeňte ju na ${defaultCurrency}";

  static String m35(length) => "Našli sme ${length} produktov";

  static String m36(week) => " ${week}. týždeň";

  static String m37(name) => "Vitajte ${name}";

  static String m38(year) => " pred${year} rokmi";

  static String m39(total) => "Pridelili ste objednávke č.${total}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "UserNameInCorrect": MessageLookupByLibrary.simpleMessage(
            "Používateľské meno alebo heslo je nesprávne"),
        "aboutUs": MessageLookupByLibrary.simpleMessage("O nás"),
        "account": MessageLookupByLibrary.simpleMessage("účet"),
        "accountDeleteDescription": MessageLookupByLibrary.simpleMessage(
            "Vymazaním svojho účtu odstránite osobné údaje z našej databázy. Váš e-mail sa stáva trvalo rezervovaným a rovnaký e-mail nie je možné znova použiť na registráciu nového účtu."),
        "accountIsPendingApproval":
            MessageLookupByLibrary.simpleMessage("Účet čaká na schválenie."),
        "accountNumber": MessageLookupByLibrary.simpleMessage("Číslo účtu"),
        "accountSetup": MessageLookupByLibrary.simpleMessage("Nastavenie účtu"),
        "active": MessageLookupByLibrary.simpleMessage("aktívny"),
        "activeFor": m0,
        "activeLongAgo":
            MessageLookupByLibrary.simpleMessage("Aktívny už dávno"),
        "activeNow": MessageLookupByLibrary.simpleMessage("Aktívny teraz"),
        "addAName": MessageLookupByLibrary.simpleMessage("Pridať meno"),
        "addANewPost":
            MessageLookupByLibrary.simpleMessage("Pridať nový príspevok"),
        "addASlug": MessageLookupByLibrary.simpleMessage("Pridať skratku"),
        "addAnAttr": MessageLookupByLibrary.simpleMessage("Pridať atribút"),
        "addListing": MessageLookupByLibrary.simpleMessage("Pridať záznam"),
        "addNew": MessageLookupByLibrary.simpleMessage("Nové"),
        "addNewBlog": MessageLookupByLibrary.simpleMessage("Pridať nový blog"),
        "addNewPost":
            MessageLookupByLibrary.simpleMessage("Vytvoriť nový príspevok"),
        "addProduct": MessageLookupByLibrary.simpleMessage("Pridať produkt"),
        "addToCart": MessageLookupByLibrary.simpleMessage("Do košíka"),
        "addToCartMaximum": MessageLookupByLibrary.simpleMessage(
            "Maximálne množstvo bolo prekročené"),
        "addToCartSucessfully":
            MessageLookupByLibrary.simpleMessage("boli pridané do košíka"),
        "addToOrder":
            MessageLookupByLibrary.simpleMessage("Pridať do objednávky"),
        "added": MessageLookupByLibrary.simpleMessage("Vložené"),
        "addedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Úspešne pridané"),
        "addingYourImage":
            MessageLookupByLibrary.simpleMessage("Pridáva sa váš obrázok"),
        "additionalInformation":
            MessageLookupByLibrary.simpleMessage("ĎALŠIE INFORMÁCIE"),
        "additionalServices":
            MessageLookupByLibrary.simpleMessage("Doplnkové služby"),
        "address": MessageLookupByLibrary.simpleMessage("Adresa"),
        "adults": MessageLookupByLibrary.simpleMessage("Dospelí"),
        "afternoon": MessageLookupByLibrary.simpleMessage("POPOLUDNIE"),
        "agree": MessageLookupByLibrary.simpleMessage("súhlasiť"),
        "agreeWithPrivacy": MessageLookupByLibrary.simpleMessage(
            "Súhlasím so spracovaním osobných údajov"),
        "albanian": MessageLookupByLibrary.simpleMessage("albánsky"),
        "all": MessageLookupByLibrary.simpleMessage("Všetko"),
        "allBrands": MessageLookupByLibrary.simpleMessage("Všetky značky"),
        "allDeliveryOrders":
            MessageLookupByLibrary.simpleMessage("Všetky doručené objednávky"),
        "allOrders": MessageLookupByLibrary.simpleMessage("Všetky objednávky"),
        "allProducts": MessageLookupByLibrary.simpleMessage("Všetky produkty"),
        "allow": MessageLookupByLibrary.simpleMessage("dovoliť"),
        "allowCameraAccess": MessageLookupByLibrary.simpleMessage(
            "Povoliť prístup k fotoaparátu?"),
        "almostSoldOut":
            MessageLookupByLibrary.simpleMessage("Takmer vypredané"),
        "amount": MessageLookupByLibrary.simpleMessage("Suma"),
        "anyAttr": m1,
        "appearance": MessageLookupByLibrary.simpleMessage("vzhľad"),
        "apply": MessageLookupByLibrary.simpleMessage("Potvrdiť"),
        "approve": MessageLookupByLibrary.simpleMessage("Schváliť"),
        "approved": MessageLookupByLibrary.simpleMessage("Schválený"),
        "arabic": MessageLookupByLibrary.simpleMessage("arabčina"),
        "areYouSure": MessageLookupByLibrary.simpleMessage("Ste si istý?"),
        "areYouSureDeleteAccount": MessageLookupByLibrary.simpleMessage(
            "Naozaj chcete odstrániť svoj účet?"),
        "assigned": MessageLookupByLibrary.simpleMessage("Pridelených"),
        "atLeastThreeCharacters":
            MessageLookupByLibrary.simpleMessage("Aspoň 3 znaky..."),
        "attributeAlreadyExists":
            MessageLookupByLibrary.simpleMessage("Atribút už existuje"),
        "attributes": MessageLookupByLibrary.simpleMessage("Atribúty"),
        "audioDetected": MessageLookupByLibrary.simpleMessage(
            "Rozpoznaná zvuková položka. Chcete pridať do prehrávača zvuku?"),
        "availability": MessageLookupByLibrary.simpleMessage("Dostupnosť"),
        "availablePoints": m2,
        "averageRating":
            MessageLookupByLibrary.simpleMessage("Priemerné hodnotenie"),
        "back": MessageLookupByLibrary.simpleMessage("Späť"),
        "backOrder": MessageLookupByLibrary.simpleMessage("Predobjednávka"),
        "backToShop": MessageLookupByLibrary.simpleMessage("SPÄŤ DO OBCHODU"),
        "backToWallet":
            MessageLookupByLibrary.simpleMessage("Späť ku peňaženke"),
        "bagsCollections":
            MessageLookupByLibrary.simpleMessage("Kolekcia tašiek"),
        "balance": MessageLookupByLibrary.simpleMessage("Zostatok"),
        "bank": MessageLookupByLibrary.simpleMessage("breh"),
        "bannerListType":
            MessageLookupByLibrary.simpleMessage("Typ zoznamu bannerov"),
        "bannerType": MessageLookupByLibrary.simpleMessage("Typ bannera"),
        "bannerYoutubeURL": MessageLookupByLibrary.simpleMessage(
            "Bannerová adresa URL na YouTube"),
        "basicInformation":
            MessageLookupByLibrary.simpleMessage("Základné informácie"),
        "bengali": MessageLookupByLibrary.simpleMessage("bengálčina"),
        "billingAddress":
            MessageLookupByLibrary.simpleMessage("Fakturačná adresa"),
        "bleHasNotBeenEnabled":
            MessageLookupByLibrary.simpleMessage("Bluetooth nebolo povolené"),
        "bleState": m3,
        "blog": MessageLookupByLibrary.simpleMessage("Blog"),
        "booked": MessageLookupByLibrary.simpleMessage("Už rezervované"),
        "booking": MessageLookupByLibrary.simpleMessage("Rezervácia"),
        "bookingCancelled":
            MessageLookupByLibrary.simpleMessage("Zrušenie rezervácie"),
        "bookingConfirm": MessageLookupByLibrary.simpleMessage("Potvrdená"),
        "bookingError": MessageLookupByLibrary.simpleMessage(
            "Niečo nie je v poriadku. Skúste neskôr prosím."),
        "bookingHistory":
            MessageLookupByLibrary.simpleMessage("História rezervácií"),
        "bookingNow": MessageLookupByLibrary.simpleMessage("Rezervovať"),
        "bookingSuccess":
            MessageLookupByLibrary.simpleMessage("Úspešne rezervované"),
        "bookingSummary":
            MessageLookupByLibrary.simpleMessage("Zhrnutie rezervácie"),
        "bookingUnavailable": MessageLookupByLibrary.simpleMessage(
            "Rezervácia nie je k dispozícii"),
        "bosnian": MessageLookupByLibrary.simpleMessage("bosnianska"),
        "brand": MessageLookupByLibrary.simpleMessage("Značka"),
        "brazil": MessageLookupByLibrary.simpleMessage("brazilský"),
        "burmese": MessageLookupByLibrary.simpleMessage("barmská"),
        "buyNow": MessageLookupByLibrary.simpleMessage("Kúpiť teraz"),
        "byCategory": MessageLookupByLibrary.simpleMessage("Podľa kategórie"),
        "byPrice": MessageLookupByLibrary.simpleMessage("Podľa ceny"),
        "bySignup": MessageLookupByLibrary.simpleMessage(
            "Registráciou súhlasíte s našimi"),
        "byTag": MessageLookupByLibrary.simpleMessage("Podľa značky"),
        "call": MessageLookupByLibrary.simpleMessage("Volať"),
        "callTo": MessageLookupByLibrary.simpleMessage("Zavolajte na"),
        "callToVendor": MessageLookupByLibrary.simpleMessage(
            "Zavolajte majiteľovi predajne"),
        "canNotCreateOrder": MessageLookupByLibrary.simpleMessage(
            "Nie je možné vytvoriť objednávku"),
        "canNotCreateUser": MessageLookupByLibrary.simpleMessage(
            "Nie je možné vytvoriť používateľa."),
        "canNotGetPayments": MessageLookupByLibrary.simpleMessage(
            "Nie je možné získať spôsoby platby"),
        "canNotGetShipping": MessageLookupByLibrary.simpleMessage(
            "Nie je možné získať spôsoby dopravy"),
        "canNotGetToken": MessageLookupByLibrary.simpleMessage(
            "Nie je možné získať informácie o tokene."),
        "canNotLaunch": MessageLookupByLibrary.simpleMessage(
            "Táto aplikácia sa nedá spustiť, uistite sa, že sú vaše nastavenia na config.dart správne"),
        "canNotLoadThisLink":
            MessageLookupByLibrary.simpleMessage("Tento odkaz sa nedá načítať"),
        "canNotSaveOrder": MessageLookupByLibrary.simpleMessage(
            "Objednávku nie je možné uložiť na web"),
        "canNotUpdateInfo": MessageLookupByLibrary.simpleMessage(
            "Nie je možné aktualizovať informácie o používateľovi."),
        "cancel": MessageLookupByLibrary.simpleMessage("Zrušiť"),
        "cantFindThisOrderId": MessageLookupByLibrary.simpleMessage(
            "Toto ID objednávky sa nepodarilo nájsť"),
        "cantPickDateInThePast": MessageLookupByLibrary.simpleMessage(
            "Dátum v minulosti nie je povolený"),
        "cardHolder": MessageLookupByLibrary.simpleMessage("Držiteľ karty"),
        "cardNumber": MessageLookupByLibrary.simpleMessage("Číslo karty"),
        "cart": MessageLookupByLibrary.simpleMessage("Košík"),
        "cartDiscount": MessageLookupByLibrary.simpleMessage("Zľava v košíku"),
        "cash": MessageLookupByLibrary.simpleMessage("Hotovosť"),
        "categories": MessageLookupByLibrary.simpleMessage("Kategórie"),
        "category": MessageLookupByLibrary.simpleMessage("Kategória"),
        "change": MessageLookupByLibrary.simpleMessage("Zmena"),
        "changeLanguage": MessageLookupByLibrary.simpleMessage("Zmeniť jazyk"),
        "changePrinter":
            MessageLookupByLibrary.simpleMessage("Zmeniť tlačiareň"),
        "changedCurrencyTo": m4,
        "chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "chatGPT": MessageLookupByLibrary.simpleMessage("Chat GPT"),
        "chatListScreen": MessageLookupByLibrary.simpleMessage("Správy"),
        "chatViaFacebook": MessageLookupByLibrary.simpleMessage(
            "Chatujte cez Facebook Messenger"),
        "chatViaWhatApp":
            MessageLookupByLibrary.simpleMessage("Chatujte cez WhatsApp"),
        "chatWithBot": MessageLookupByLibrary.simpleMessage("Chatujte s Botom"),
        "chatWithStoreOwner": MessageLookupByLibrary.simpleMessage(
            "Chatujte s vlastníkom obchodu"),
        "checkConfirmLink": MessageLookupByLibrary.simpleMessage(
            "Skontrolujte svoj e-mail, kde nájdete potvrdzovací odkaz"),
        "checking":
            MessageLookupByLibrary.simpleMessage("Prebieha kontrola..."),
        "checkout": MessageLookupByLibrary.simpleMessage("PLATBA"),
        "chinese": MessageLookupByLibrary.simpleMessage("Čínština"),
        "chineseSimplified":
            MessageLookupByLibrary.simpleMessage("Zjednodušená čínština)"),
        "chineseTraditional":
            MessageLookupByLibrary.simpleMessage("Tradične čínske)"),
        "chooseCategory":
            MessageLookupByLibrary.simpleMessage("Vyberte kategóriu"),
        "chooseFromGallery":
            MessageLookupByLibrary.simpleMessage("Vyberte z galérie"),
        "chooseFromServer":
            MessageLookupByLibrary.simpleMessage("Vyberte položku zo servera"),
        "choosePlan": MessageLookupByLibrary.simpleMessage("Vyberte plán"),
        "chooseStaff":
            MessageLookupByLibrary.simpleMessage("Vyberte operátora"),
        "chooseType": MessageLookupByLibrary.simpleMessage("Vyberte typ"),
        "chooseYourPaymentMethod":
            MessageLookupByLibrary.simpleMessage("Vyberte si spôsob platby"),
        "city": MessageLookupByLibrary.simpleMessage("Mesto"),
        "cityIsRequired":
            MessageLookupByLibrary.simpleMessage("Mesto je povinné"),
        "clear": MessageLookupByLibrary.simpleMessage("Prázdny"),
        "clearCart": MessageLookupByLibrary.simpleMessage("Vymazať košík"),
        "clearConversation":
            MessageLookupByLibrary.simpleMessage("Jasná konverzácia"),
        "close": MessageLookupByLibrary.simpleMessage("Zavrieť"),
        "closeNow":
            MessageLookupByLibrary.simpleMessage("Momentálne zatvorené"),
        "codExtraFee":
            MessageLookupByLibrary.simpleMessage("Doplatok za dobierku"),
        "color": MessageLookupByLibrary.simpleMessage("Farba"),
        "comment": MessageLookupByLibrary.simpleMessage("Komentár"),
        "commentFirst":
            MessageLookupByLibrary.simpleMessage("Napíšte svoj komentár"),
        "commentSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Komentár úspešne uložený, počkajte, kým bude schválený"),
        "complete": MessageLookupByLibrary.simpleMessage("Kompletné"),
        "confirm": MessageLookupByLibrary.simpleMessage("Potvrdiť"),
        "confirmAccountDeletion":
            MessageLookupByLibrary.simpleMessage("Potvrďte vymazanie účtu"),
        "confirmClearCartWhenTopUp":
            MessageLookupByLibrary.simpleMessage("Košík sa po dobití vyčistí."),
        "confirmClearTheCart": MessageLookupByLibrary.simpleMessage(
            "Naozaj chcete vyčistiť košík?"),
        "confirmDelete": MessageLookupByLibrary.simpleMessage(
            "Naozaj to chcete odstrániť? Túto akciu nie je možné vrátiť späť."),
        "confirmDeleteItem": MessageLookupByLibrary.simpleMessage(
            "Naozaj chcete odstrániť túto položku?"),
        "connect": MessageLookupByLibrary.simpleMessage("pripojiť"),
        "contact": MessageLookupByLibrary.simpleMessage("Kontakt"),
        "content": MessageLookupByLibrary.simpleMessage("Obsah"),
        "continueToPayment":
            MessageLookupByLibrary.simpleMessage("Pokračovať na platbu"),
        "continueToReview":
            MessageLookupByLibrary.simpleMessage("Pokračovať ku recenzii"),
        "continueToShipping":
            MessageLookupByLibrary.simpleMessage("Pokračovať na doručenie"),
        "continues": MessageLookupByLibrary.simpleMessage("Pokračovanie"),
        "conversations": MessageLookupByLibrary.simpleMessage("konverzácia"),
        "convertPoint": m5,
        "copied": MessageLookupByLibrary.simpleMessage("skopírované"),
        "copy": MessageLookupByLibrary.simpleMessage("kópie"),
        "country": MessageLookupByLibrary.simpleMessage("Krajina"),
        "countryIsRequired":
            MessageLookupByLibrary.simpleMessage("Pole krajina je povinné"),
        "couponCode": MessageLookupByLibrary.simpleMessage("Kód kupónu"),
        "couponHasBeenSavedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Kupón bol úspešne uložený."),
        "couponInvalid": MessageLookupByLibrary.simpleMessage(
            "Kód vášho kupónu je neplatný"),
        "couponMsgSuccess": MessageLookupByLibrary.simpleMessage(
            "Gratulujeme! Kód kupónu bol úspešne použitý"),
        "createAnAccount":
            MessageLookupByLibrary.simpleMessage("Vytvoriť účet"),
        "createNewPostSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Váš príspevok bol úspešne vytvorený. Pozrite sa prosím na svoju správcovskú stránku."),
        "createPost":
            MessageLookupByLibrary.simpleMessage("Vytvoriť príspevok"),
        "createProduct":
            MessageLookupByLibrary.simpleMessage("Vytvoriť produkt"),
        "createVariants":
            MessageLookupByLibrary.simpleMessage("Vytvorte všetky varianty"),
        "createdOn": MessageLookupByLibrary.simpleMessage("Vytvorené:"),
        "currencies": MessageLookupByLibrary.simpleMessage("Mena"),
        "currencyIsNotSupported": m6,
        "currentPassword":
            MessageLookupByLibrary.simpleMessage("Aktuálne heslo"),
        "currentlyWeOnlyHave":
            MessageLookupByLibrary.simpleMessage("V súčasnosti máme len"),
        "customer": MessageLookupByLibrary.simpleMessage("Zákazník"),
        "customerDetail":
            MessageLookupByLibrary.simpleMessage("Detail zákazníka"),
        "customerNote":
            MessageLookupByLibrary.simpleMessage("Poznámka zákazníka"),
        "cvv": MessageLookupByLibrary.simpleMessage("CVV"),
        "czech": MessageLookupByLibrary.simpleMessage("český"),
        "danish": MessageLookupByLibrary.simpleMessage("dánsky"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Tmavá téma"),
        "dashboard": MessageLookupByLibrary.simpleMessage("Nástenka"),
        "dataEmpty": MessageLookupByLibrary.simpleMessage("Údaje sú prázdne"),
        "date": MessageLookupByLibrary.simpleMessage("Dátum"),
        "dateASC": MessageLookupByLibrary.simpleMessage("Dátum vzostupne"),
        "dateBooking":
            MessageLookupByLibrary.simpleMessage("Termín rezervácie"),
        "dateDESC": MessageLookupByLibrary.simpleMessage("Dátum zostupne"),
        "dateEnd": MessageLookupByLibrary.simpleMessage("Konečný dátum"),
        "dateLatest": MessageLookupByLibrary.simpleMessage("Dátum: Najnovšie"),
        "dateOldest": MessageLookupByLibrary.simpleMessage("Dátum: najstarší"),
        "dateStart": MessageLookupByLibrary.simpleMessage("Začiatočný dátum"),
        "dateTime": MessageLookupByLibrary.simpleMessage("Dátum Čas"),
        "dateWiseClose":
            MessageLookupByLibrary.simpleMessage("Dátum je príliš blízko"),
        "daysAgo": m7,
        "debit": MessageLookupByLibrary.simpleMessage("dlh"),
        "decline": MessageLookupByLibrary.simpleMessage("pokles"),
        "delete": MessageLookupByLibrary.simpleMessage("Vymazať"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("Zmazať účet"),
        "deleteAccountMsg": MessageLookupByLibrary.simpleMessage(
            "Naozaj chcete odstrániť svoj účet? Prečítajte si, ako ovplyvní vymazanie účtu."),
        "deleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
            "Účet bol úspešne odstránený. Platnosť vašej relácie vypršala."),
        "deleteAll": MessageLookupByLibrary.simpleMessage("Vymazať všetko"),
        "delivered": MessageLookupByLibrary.simpleMessage("Dodaný"),
        "deliveredTo": MessageLookupByLibrary.simpleMessage("Doručené pre"),
        "deliveryBoy": MessageLookupByLibrary.simpleMessage("Kuriér:"),
        "deliveryDate": MessageLookupByLibrary.simpleMessage("Dátum doručenia"),
        "deliveryDetails":
            MessageLookupByLibrary.simpleMessage("Detaily doručenia"),
        "deliveryManagement":
            MessageLookupByLibrary.simpleMessage("Správa doručenia"),
        "deliveryNotificationError": MessageLookupByLibrary.simpleMessage(
            "Žiadne dáta.\nTáto objednávka bola odstránená."),
        "description": MessageLookupByLibrary.simpleMessage("Popis"),
        "didntReceiveCode":
            MessageLookupByLibrary.simpleMessage("Nedostali ste kód?"),
        "direction": MessageLookupByLibrary.simpleMessage("Smer"),
        "disablePurchase":
            MessageLookupByLibrary.simpleMessage("Zakázaný nákup"),
        "discount": MessageLookupByLibrary.simpleMessage("Zľava"),
        "displayName": MessageLookupByLibrary.simpleMessage("Zobraziť meno"),
        "distance": m8,
        "doNotAnyTransactions": MessageLookupByLibrary.simpleMessage(
            "Zatiaľ nemáte žiadne transakcie"),
        "doYouWantToExitApp":
            MessageLookupByLibrary.simpleMessage("Chcete ukončiť aplikáciu"),
        "doYouWantToLogout":
            MessageLookupByLibrary.simpleMessage("Chcete sa odhlásiť?"),
        "doesNotSupportApplePay": MessageLookupByLibrary.simpleMessage(
            "Služba ApplePay nie je podporovaná. Skontrolujte si peňaženku a kartu"),
        "done": MessageLookupByLibrary.simpleMessage("Hotovo"),
        "dontHaveAccount": MessageLookupByLibrary.simpleMessage("Nemáte účet?"),
        "download": MessageLookupByLibrary.simpleMessage("Stiahnuť ▼"),
        "downloadApp":
            MessageLookupByLibrary.simpleMessage("Stiahnite si aplikáciu"),
        "draft": MessageLookupByLibrary.simpleMessage("Návrh"),
        "driverAssigned":
            MessageLookupByLibrary.simpleMessage("Vodič pridelený"),
        "duration": MessageLookupByLibrary.simpleMessage("Trvanie"),
        "dutch": MessageLookupByLibrary.simpleMessage("holandský"),
        "earnings": MessageLookupByLibrary.simpleMessage("Zárobok"),
        "edit": MessageLookupByLibrary.simpleMessage("Upraviť"),
        "editProductInfo": MessageLookupByLibrary.simpleMessage(
            "Upraviť informácie o produkte"),
        "editWithoutColon": MessageLookupByLibrary.simpleMessage("Editovať"),
        "egypt": MessageLookupByLibrary.simpleMessage("egypt"),
        "email": MessageLookupByLibrary.simpleMessage("E-mail"),
        "emailDeleteDescription": MessageLookupByLibrary.simpleMessage(
            "Odstránením účtu sa odhlásite zo všetkých zoznamov adries."),
        "emailDoesNotExist": MessageLookupByLibrary.simpleMessage(
            "E-mailový účet, ktorý ste zadali, neexistuje. Prosím skúste znova."),
        "emailIsRequired":
            MessageLookupByLibrary.simpleMessage("Pole e-mailu je povinné"),
        "emailSubscription":
            MessageLookupByLibrary.simpleMessage("E-mailové predplatné"),
        "emptyCartSubtitle": MessageLookupByLibrary.simpleMessage(
            "Zdá sa, že ste do košíka ešte nepridali žiadne položky. Začnite nakupovať ..."),
        "emptyComment": MessageLookupByLibrary.simpleMessage(
            "Váš komentár nemôže byť prázdny"),
        "emptySearch": MessageLookupByLibrary.simpleMessage(
            "Zatiaľ ste nehľadali položky. Začnime teraz – pomôžeme vám."),
        "emptyShippingMsg": MessageLookupByLibrary.simpleMessage(
            "Nie sú k dispozícii žiadne možnosti dopravy. Uistite sa, že vaša adresa bola zadaná správne, alebo nás kontaktujte, ak potrebujete pomoc."),
        "emptyUsername": MessageLookupByLibrary.simpleMessage(
            "Používateľské meno/e-mail je prázdne"),
        "emptyWishlistSubtitle": MessageLookupByLibrary.simpleMessage(
            "Klepnutím na ľubovoľné srdce vedľa produktu ho zaradíte medzi obľúbené. Tu vám ich uložíme!"),
        "enableForCheckout":
            MessageLookupByLibrary.simpleMessage("Povoliť pre službu Checkout"),
        "enableForLogin":
            MessageLookupByLibrary.simpleMessage("Povoliť pre prihlásenie"),
        "enableForWallet":
            MessageLookupByLibrary.simpleMessage("Povoliť pre Peňaženku"),
        "enableVacationMode":
            MessageLookupByLibrary.simpleMessage("Povoliť dovolenkový režim"),
        "endDateCantBeAfterFirstDate": MessageLookupByLibrary.simpleMessage(
            "Vyberte dátum po prvom dátume"),
        "endsIn": m9,
        "english": MessageLookupByLibrary.simpleMessage("angličtina"),
        "enterCaptcha": m10,
        "enterSendedCode":
            MessageLookupByLibrary.simpleMessage("Zadajte kód odoslaný na"),
        "enterYourEmail":
            MessageLookupByLibrary.simpleMessage("Zadajte svoj e-mail"),
        "enterYourEmailOrUsername": MessageLookupByLibrary.simpleMessage(
            "Zadajte svoj e-mail alebo používateľské meno"),
        "enterYourFirstName":
            MessageLookupByLibrary.simpleMessage("Zadajte svoje meno"),
        "enterYourLastName":
            MessageLookupByLibrary.simpleMessage("Zadajte svoje priezvisko"),
        "enterYourMobile":
            MessageLookupByLibrary.simpleMessage("Zadajte svoje mobilné číslo"),
        "enterYourPassword":
            MessageLookupByLibrary.simpleMessage("Zadajte svoje heslo"),
        "enterYourPhone": MessageLookupByLibrary.simpleMessage(
            "Začnite zadaním telefónneho čísla."),
        "enterYourPhoneNumber": MessageLookupByLibrary.simpleMessage(
            "Zadajte svoje telefónne číslo"),
        "error": m11,
        "errorAmountTransfer": MessageLookupByLibrary.simpleMessage(
            "Zadaná suma je väčšia ako aktuálna suma v peňaženke. Prosím skúste znova!"),
        "errorEmailFormat": MessageLookupByLibrary.simpleMessage(
            "Prosím zadajte platnú emailovú adresu."),
        "errorPasswordFormat": MessageLookupByLibrary.simpleMessage(
            "Zadajte heslo s aspoň 8 znakmi"),
        "evening": MessageLookupByLibrary.simpleMessage("Večer"),
        "events": MessageLookupByLibrary.simpleMessage("Udalosti"),
        "expectedDeliveryDate":
            MessageLookupByLibrary.simpleMessage("Predpokladaný dátum dodania"),
        "expired": MessageLookupByLibrary.simpleMessage("Expirované"),
        "expiredDate": MessageLookupByLibrary.simpleMessage("Dátum spotreby"),
        "expiredDateHint": MessageLookupByLibrary.simpleMessage("MM/RR"),
        "expiringInTime": m12,
        "external": MessageLookupByLibrary.simpleMessage("Vonkajšie"),
        "extraServices": MessageLookupByLibrary.simpleMessage("Extra služby"),
        "failToAssign": MessageLookupByLibrary.simpleMessage(
            "Používateľa sa nepodarilo priradiť"),
        "failedToGenerateLink": MessageLookupByLibrary.simpleMessage(
            "Nepodarilo sa vygenerovať odkaz"),
        "failedToLoadAppConfig": MessageLookupByLibrary.simpleMessage(
            "Nepodarilo sa načítať konfiguráciu aplikácie. Skúste to znova alebo reštartujte aplikáciu."),
        "failedToLoadImage": MessageLookupByLibrary.simpleMessage(
            "Nepodarilo sa načítať obrázok"),
        "favorite": MessageLookupByLibrary.simpleMessage("Obľúbené"),
        "featureNotAvailable":
            MessageLookupByLibrary.simpleMessage("Funkcia nie je k dispozícii"),
        "featureProducts":
            MessageLookupByLibrary.simpleMessage("Naše produkty"),
        "featured": MessageLookupByLibrary.simpleMessage("Špeciálne"),
        "features": MessageLookupByLibrary.simpleMessage("Vlastnosti"),
        "fileIsTooBig": MessageLookupByLibrary.simpleMessage(
            "Súbor je príliš veľký. Vyberte menší súbor!"),
        "fileUploadFailed":
            MessageLookupByLibrary.simpleMessage("Nahranie súboru zlyhalo!"),
        "files": MessageLookupByLibrary.simpleMessage("Súbory"),
        "filter": MessageLookupByLibrary.simpleMessage("Filter"),
        "fingerprintsTouchID":
            MessageLookupByLibrary.simpleMessage("Odtlačky prstov, Touch ID"),
        "finishSetup":
            MessageLookupByLibrary.simpleMessage("Dokončite nastavenie"),
        "finnish": MessageLookupByLibrary.simpleMessage("fínsky"),
        "firstComment": MessageLookupByLibrary.simpleMessage(
            "Buďte prvý, kto komentuje tento príspevok!"),
        "firstName": MessageLookupByLibrary.simpleMessage("Meno"),
        "firstNameIsRequired":
            MessageLookupByLibrary.simpleMessage("Pole meno je povinné"),
        "firstRenewal": MessageLookupByLibrary.simpleMessage("Prvá obnova"),
        "fixedCartDiscount":
            MessageLookupByLibrary.simpleMessage("Pevná zľava na košík"),
        "fixedProductDiscount":
            MessageLookupByLibrary.simpleMessage("Pevná zľava na produkt"),
        "forThisProduct":
            MessageLookupByLibrary.simpleMessage("pre tento produkt"),
        "freeOfCharge": MessageLookupByLibrary.simpleMessage("zadarmo"),
        "french": MessageLookupByLibrary.simpleMessage("francúzsky"),
        "from": MessageLookupByLibrary.simpleMessage("z"),
        "fullName": MessageLookupByLibrary.simpleMessage("Celé meno"),
        "gallery": MessageLookupByLibrary.simpleMessage("Galéria"),
        "generalSetting":
            MessageLookupByLibrary.simpleMessage("Všeobecné nastavenie"),
        "generatingLink":
            MessageLookupByLibrary.simpleMessage("Generuje sa odkaz..."),
        "german": MessageLookupByLibrary.simpleMessage("nemecky"),
        "getNotification": MessageLookupByLibrary.simpleMessage("Upozorniť"),
        "getNotified":
            MessageLookupByLibrary.simpleMessage("Nechajte sa upozorniť!"),
        "getPasswordLink":
            MessageLookupByLibrary.simpleMessage("Získať odkaz na heslo"),
        "getStarted": MessageLookupByLibrary.simpleMessage("Začať"),
        "goBack": MessageLookupByLibrary.simpleMessage("Vráť sa"),
        "goBackHomePage":
            MessageLookupByLibrary.simpleMessage("Späť na domovskú stránku"),
        "goBackToAddress":
            MessageLookupByLibrary.simpleMessage("Späť na adresu"),
        "goBackToReview":
            MessageLookupByLibrary.simpleMessage("Späť na recenziu"),
        "goBackToShipping":
            MessageLookupByLibrary.simpleMessage("Späť k preprave"),
        "greaterDistance": m13,
        "greek": MessageLookupByLibrary.simpleMessage("grécky"),
        "grossSales": MessageLookupByLibrary.simpleMessage("Hrubý predaj"),
        "grouped": MessageLookupByLibrary.simpleMessage("Zoskupené"),
        "guests": MessageLookupByLibrary.simpleMessage("Hostia"),
        "hasBeenDeleted": MessageLookupByLibrary.simpleMessage("bolo vymazané"),
        "hebrew": MessageLookupByLibrary.simpleMessage("hebrejčina"),
        "hideAbout": MessageLookupByLibrary.simpleMessage("Skryť informácie"),
        "hideAddress": MessageLookupByLibrary.simpleMessage("Skryť adresu"),
        "hideEmail": MessageLookupByLibrary.simpleMessage("Skryť e-mail"),
        "hideMap": MessageLookupByLibrary.simpleMessage("Skryť mapu"),
        "hidePhone": MessageLookupByLibrary.simpleMessage("Skryť telefón"),
        "hidePolicy": MessageLookupByLibrary.simpleMessage("Skryť pravidlá"),
        "hindi": MessageLookupByLibrary.simpleMessage("hindčina"),
        "history": MessageLookupByLibrary.simpleMessage("História"),
        "historyTransaction":
            MessageLookupByLibrary.simpleMessage("História obratov"),
        "home": MessageLookupByLibrary.simpleMessage("Domov"),
        "hour": MessageLookupByLibrary.simpleMessage("Hodina"),
        "hoursAgo": m14,
        "hungarian": MessageLookupByLibrary.simpleMessage("maďarsky"),
        "hungary": MessageLookupByLibrary.simpleMessage("maďarsky"),
        "iAgree": MessageLookupByLibrary.simpleMessage("Súhlasím s"),
        "imIn": MessageLookupByLibrary.simpleMessage("som v"),
        "imageFeature": MessageLookupByLibrary.simpleMessage("Titulný obrázok"),
        "imageGallery":
            MessageLookupByLibrary.simpleMessage("Galéria obrázkov"),
        "imageGenerate":
            MessageLookupByLibrary.simpleMessage("Generovať obrázok"),
        "imageNetwork": MessageLookupByLibrary.simpleMessage("Image Network"),
        "inStock": MessageLookupByLibrary.simpleMessage("Na sklade"),
        "incorrectPassword":
            MessageLookupByLibrary.simpleMessage("Nesprávne heslo"),
        "india": MessageLookupByLibrary.simpleMessage("hindčina"),
        "indonesian": MessageLookupByLibrary.simpleMessage("indonézsky"),
        "instantlyClose":
            MessageLookupByLibrary.simpleMessage("Okamžité zatvorenie"),
        "invalidPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Neplatné telefónne číslo"),
        "invalidSMSCode":
            MessageLookupByLibrary.simpleMessage("Neplatný SMS overovací kód"),
        "invalidYearOfBirth":
            MessageLookupByLibrary.simpleMessage("Neplatný rok narodenia"),
        "invoice": MessageLookupByLibrary.simpleMessage("faktúra"),
        "isEverythingSet":
            MessageLookupByLibrary.simpleMessage("Je všetko nastavené...?"),
        "isTyping": MessageLookupByLibrary.simpleMessage("píše..."),
        "italian": MessageLookupByLibrary.simpleMessage("taliansky"),
        "item": MessageLookupByLibrary.simpleMessage("Položka"),
        "itemTotal": MessageLookupByLibrary.simpleMessage("Celkom:"),
        "items": MessageLookupByLibrary.simpleMessage("Položky"),
        "itsOrdered":
            MessageLookupByLibrary.simpleMessage("Objednané úspešne!"),
        "iwantToCreateAccount":
            MessageLookupByLibrary.simpleMessage("Chcem si vytvoriť účet"),
        "japanese": MessageLookupByLibrary.simpleMessage("japonský"),
        "kannada": MessageLookupByLibrary.simpleMessage("kanadský"),
        "keep": MessageLookupByLibrary.simpleMessage("Zachovať"),
        "khmer": MessageLookupByLibrary.simpleMessage("khmer"),
        "korean": MessageLookupByLibrary.simpleMessage("kórejský"),
        "kurdish": MessageLookupByLibrary.simpleMessage("kurdský"),
        "language": MessageLookupByLibrary.simpleMessage("Jazyk"),
        "languageSuccess": MessageLookupByLibrary.simpleMessage(
            "Jazyk bol úspešne aktualizovaný"),
        "lao": MessageLookupByLibrary.simpleMessage("lao"),
        "lastName": MessageLookupByLibrary.simpleMessage("Priezvisko"),
        "lastNameIsRequired":
            MessageLookupByLibrary.simpleMessage("Pole priezvisko je povinné"),
        "lastTransactions":
            MessageLookupByLibrary.simpleMessage("Posledné transakcie"),
        "latestProducts":
            MessageLookupByLibrary.simpleMessage("Najnovšie produkty"),
        "layout": MessageLookupByLibrary.simpleMessage("Rozloženie"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Svetlá téma"),
        "link": MessageLookupByLibrary.simpleMessage("Odkaz"),
        "listBannerType": MessageLookupByLibrary.simpleMessage("Typ bannera"),
        "listBannerVideo":
            MessageLookupByLibrary.simpleMessage("Bannerové video"),
        "listMessages":
            MessageLookupByLibrary.simpleMessage("Upozorniť na správy"),
        "listening": MessageLookupByLibrary.simpleMessage("Počúvanie..."),
        "loadFail": MessageLookupByLibrary.simpleMessage("Načítanie zlyhalo!"),
        "loading": MessageLookupByLibrary.simpleMessage("Načítava sa ..."),
        "loadingLink":
            MessageLookupByLibrary.simpleMessage("Načítava sa odkaz..."),
        "location": MessageLookupByLibrary.simpleMessage("Umiestnenie"),
        "lockScreenAndSecurity": MessageLookupByLibrary.simpleMessage(
            "Uzamknutie obrazovky a zabezpečenie"),
        "login": MessageLookupByLibrary.simpleMessage("Prihlásiť sa"),
        "loginCanceled":
            MessageLookupByLibrary.simpleMessage("Prihlásenie zrušené"),
        "loginErrorServiceProvider": m15,
        "loginFailed":
            MessageLookupByLibrary.simpleMessage("Prihlásenie zlyhalo!"),
        "loginInvalid": MessageLookupByLibrary.simpleMessage(
            "Nemáte povolené používať túto aplikáciu."),
        "loginSuccess":
            MessageLookupByLibrary.simpleMessage("Prihlásenie úspešné!"),
        "loginToComment": MessageLookupByLibrary.simpleMessage(
            "Ak chcete komentovať, prihláste sa"),
        "loginToContinue": MessageLookupByLibrary.simpleMessage(
            "Prosím prihláste sa pre pokračovanie"),
        "loginToYourAccount":
            MessageLookupByLibrary.simpleMessage("Prihláste sa do svojho účtu"),
        "logout": MessageLookupByLibrary.simpleMessage("Odhlásiť sa"),
        "malay": MessageLookupByLibrary.simpleMessage("malajský"),
        "manCollections":
            MessageLookupByLibrary.simpleMessage("Výber pre mužov"),
        "manageApiKey":
            MessageLookupByLibrary.simpleMessage("Spravovať kľúč API"),
        "manageStock": MessageLookupByLibrary.simpleMessage("Spravovať zásoby"),
        "map": MessageLookupByLibrary.simpleMessage("MAPA"),
        "marathi": MessageLookupByLibrary.simpleMessage("marathi"),
        "markAsRead":
            MessageLookupByLibrary.simpleMessage("Označiť ako prečítané"),
        "markAsShipped":
            MessageLookupByLibrary.simpleMessage("Označiť ako odoslané"),
        "markAsUnread":
            MessageLookupByLibrary.simpleMessage("Označiť ako neprečítané"),
        "maxAmountForPayment": m16,
        "maximumFileSizeMb": m17,
        "maybeLater": MessageLookupByLibrary.simpleMessage("Možno neskôr"),
        "menuOrder": MessageLookupByLibrary.simpleMessage("Poradie menu"),
        "message": MessageLookupByLibrary.simpleMessage("SPRÁVA"),
        "messageTo": MessageLookupByLibrary.simpleMessage("Odoslať správu pre"),
        "minAmountForPayment": m18,
        "minimumQuantityIs":
            MessageLookupByLibrary.simpleMessage("Minimálne množstvo je"),
        "minutesAgo": m19,
        "mobileVerification":
            MessageLookupByLibrary.simpleMessage("Mobilné overenie"),
        "momentAgo": MessageLookupByLibrary.simpleMessage("pred chvíľou"),
        "monthsAgo": m20,
        "more": MessageLookupByLibrary.simpleMessage("...viac"),
        "moreFromStore": m21,
        "moreInformation":
            MessageLookupByLibrary.simpleMessage("Viac informácií"),
        "morning": MessageLookupByLibrary.simpleMessage("Ráno"),
        "mustSelectOneItem":
            MessageLookupByLibrary.simpleMessage("Vyberte aspoň 1 položku"),
        "myCart": MessageLookupByLibrary.simpleMessage("Košík"),
        "myPoints": MessageLookupByLibrary.simpleMessage("Moje body"),
        "myProducts": MessageLookupByLibrary.simpleMessage("Moje produkty"),
        "myProductsEmpty": MessageLookupByLibrary.simpleMessage(
            "Nemáte žiadne produkty. Skúste ich vytvoriť!"),
        "myWallet": MessageLookupByLibrary.simpleMessage("Moja peňaženka"),
        "myWishList": MessageLookupByLibrary.simpleMessage("Môj želania"),
        "nItems": m22,
        "name": MessageLookupByLibrary.simpleMessage("Názov"),
        "nearbyPlaces": MessageLookupByLibrary.simpleMessage("Miesta v okolí"),
        "needToLoginAgain": MessageLookupByLibrary.simpleMessage(
            "Na vykonanie aktualizácie sa musíte znova prihlásiť"),
        "netherlands": MessageLookupByLibrary.simpleMessage("holandský"),
        "newAppConfig":
            MessageLookupByLibrary.simpleMessage("K dispozícii je nový obsah!"),
        "newPassword": MessageLookupByLibrary.simpleMessage("Nové heslo"),
        "newVariation": MessageLookupByLibrary.simpleMessage("Nová variácia"),
        "next": MessageLookupByLibrary.simpleMessage("Ďalšie"),
        "niceName": MessageLookupByLibrary.simpleMessage("Zobrazované meno"),
        "no": MessageLookupByLibrary.simpleMessage("Žiadny"),
        "noBackHistoryItem": MessageLookupByLibrary.simpleMessage(
            "Žiadna ďalšia položka histórie"),
        "noBlog": MessageLookupByLibrary.simpleMessage(
            "Upps, zdá sa, že blog neexistuje"),
        "noCameraPermissionIsGranted": MessageLookupByLibrary.simpleMessage(
            "Nie je udelené žiadne povolenie pre fotoaparát. Udeľte ho v Nastaveniach svojho zariadenia."),
        "noConversation":
            MessageLookupByLibrary.simpleMessage("Zatiaľ žiadna konverzácia"),
        "noConversationDescription": MessageLookupByLibrary.simpleMessage(
            "Zobrazí sa, keď s vami vaši zákazníci začnú chatovať"),
        "noData": MessageLookupByLibrary.simpleMessage("Žiadne dáta"),
        "noFavoritesYet":
            MessageLookupByLibrary.simpleMessage("Zatiaľ žiadne obľúbené."),
        "noFileToDownload":
            MessageLookupByLibrary.simpleMessage("Žiadny súbor na stiahnutie."),
        "noForwardHistoryItem": MessageLookupByLibrary.simpleMessage(
            "Žiadna ďalšia položka histórie"),
        "noInternetConnection": MessageLookupByLibrary.simpleMessage(
            "Žiadne internetové pripojenie"),
        "noListingNearby": MessageLookupByLibrary.simpleMessage(
            "V blízkosti som nič nenašiel!"),
        "noOrders": MessageLookupByLibrary.simpleMessage("Žiadne objednávky"),
        "noPermissionToViewProduct": MessageLookupByLibrary.simpleMessage(
            "Tento produkt je dostupný pre používateľov so špecifickými rolami. Ak chcete získať prístup k tomuto produktu, prihláste sa pomocou príslušných poverení alebo nás kontaktujte pre ďalšie informácie."),
        "noPost": MessageLookupByLibrary.simpleMessage(
            "Upps, zdá sa, že táto stránka už neexistuje!"),
        "noPrinters": MessageLookupByLibrary.simpleMessage("Žiadne tlačiarne"),
        "noProduct": MessageLookupByLibrary.simpleMessage("Žiadny produkt"),
        "noResultFound":
            MessageLookupByLibrary.simpleMessage("Nenašiel sa žiadny výsledok"),
        "noReviews": MessageLookupByLibrary.simpleMessage("Žiadne recenzie"),
        "noSlotAvailable": MessageLookupByLibrary.simpleMessage(
            "Nie je k dispozícii žiadny slot"),
        "noThanks": MessageLookupByLibrary.simpleMessage("Nie ďakujem"),
        "none": MessageLookupByLibrary.simpleMessage("Nikto"),
        "notFindResult": MessageLookupByLibrary.simpleMessage(
            "Ľutujeme, nenašli sme žiadne výsledky."),
        "notFound": MessageLookupByLibrary.simpleMessage("Nenájdené"),
        "note": MessageLookupByLibrary.simpleMessage("Poznámka k objednávke"),
        "noteMessage": MessageLookupByLibrary.simpleMessage("Poznámka"),
        "noteTransfer":
            MessageLookupByLibrary.simpleMessage("Poznámka (voliteľné)"),
        "notice": MessageLookupByLibrary.simpleMessage("oznámenia"),
        "notifications": MessageLookupByLibrary.simpleMessage("Oznámenia"),
        "notifyLatestOffer": MessageLookupByLibrary.simpleMessage(
            "Informujte o najnovších ponukách a dostupnosti produktov"),
        "ofThisProduct": MessageLookupByLibrary.simpleMessage("tohto produktu"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "on": MessageLookupByLibrary.simpleMessage("NA"),
        "onSale": MessageLookupByLibrary.simpleMessage("Na predaj"),
        "onVacation": MessageLookupByLibrary.simpleMessage("Na dovolenke"),
        "online": MessageLookupByLibrary.simpleMessage("Online"),
        "openMap": MessageLookupByLibrary.simpleMessage("MAPA"),
        "openNow": MessageLookupByLibrary.simpleMessage("Otvoriť hneď"),
        "options": MessageLookupByLibrary.simpleMessage("Možnosti"),
        "optionsTotal": m23,
        "or": MessageLookupByLibrary.simpleMessage("alebo"),
        "orLoginWith":
            MessageLookupByLibrary.simpleMessage("alebo sa prihláste pomocou"),
        "orderConfirmation":
            MessageLookupByLibrary.simpleMessage("potvrdenie objednávky"),
        "orderConfirmationMsg": MessageLookupByLibrary.simpleMessage(
            "Ste si istý, že vytvoríte objednávku?"),
        "orderDate": MessageLookupByLibrary.simpleMessage("Dátum objednávky"),
        "orderDetail":
            MessageLookupByLibrary.simpleMessage("Detaily objednávky"),
        "orderHistory":
            MessageLookupByLibrary.simpleMessage("História objednávok"),
        "orderId": MessageLookupByLibrary.simpleMessage("Číslo objednávky:"),
        "orderIdWithoutColon":
            MessageLookupByLibrary.simpleMessage("Číslo objednávky"),
        "orderNo": MessageLookupByLibrary.simpleMessage("Číslo objednávky."),
        "orderNotes":
            MessageLookupByLibrary.simpleMessage("Poznámky k objednávke"),
        "orderNumber": MessageLookupByLibrary.simpleMessage("Číslo objednávky"),
        "orderStatusCanceledReversal":
            MessageLookupByLibrary.simpleMessage("Zrušený obrat"),
        "orderStatusCancelled": MessageLookupByLibrary.simpleMessage("Zrušená"),
        "orderStatusChargeBack":
            MessageLookupByLibrary.simpleMessage("Vrátenie platby"),
        "orderStatusCompleted":
            MessageLookupByLibrary.simpleMessage("Dokončená"),
        "orderStatusDenied": MessageLookupByLibrary.simpleMessage("Zamietnutá"),
        "orderStatusExpired": MessageLookupByLibrary.simpleMessage("Vypršaná"),
        "orderStatusFailed": MessageLookupByLibrary.simpleMessage("Neúspešná"),
        "orderStatusOnHold": MessageLookupByLibrary.simpleMessage("Podržaná"),
        "orderStatusPending": MessageLookupByLibrary.simpleMessage("Čaká sa"),
        "orderStatusPendingPayment":
            MessageLookupByLibrary.simpleMessage("Čakajúca platba"),
        "orderStatusProcessed":
            MessageLookupByLibrary.simpleMessage("Spracovaná"),
        "orderStatusProcessing":
            MessageLookupByLibrary.simpleMessage("Spracovávanie"),
        "orderStatusRefunded":
            MessageLookupByLibrary.simpleMessage("Vrátená platba"),
        "orderStatusReversed": MessageLookupByLibrary.simpleMessage("Obrátená"),
        "orderStatusShipped": MessageLookupByLibrary.simpleMessage("Dodaná"),
        "orderStatusVoided": MessageLookupByLibrary.simpleMessage("Neplatná"),
        "orderSuccessMsg1": MessageLookupByLibrary.simpleMessage(
            "Stav svojej objednávky môžete sledovať vo Vašom konte. Pošleme Vám e-mail s potvrdením a podrobnosťami o vašej objednávke."),
        "orderSuccessMsg2": MessageLookupByLibrary.simpleMessage(
            "Do svojho účtu sa môžete prihlásiť pomocou e-mailu a hesla definovaného vyššie. Vo svojom účte môžete upravovať údaje svojho profilu, kontrolovať históriu objednávok, upravovať odber newslettera."),
        "orderSuccessTitle1": MessageLookupByLibrary.simpleMessage(
            "Úspešne ste zadali objednávku"),
        "orderSuccessTitle2": MessageLookupByLibrary.simpleMessage("Váš účet"),
        "orderSummary":
            MessageLookupByLibrary.simpleMessage("Zhrnutie objednávky"),
        "orderTotal":
            MessageLookupByLibrary.simpleMessage("Celková suma objednávky"),
        "orderTracking":
            MessageLookupByLibrary.simpleMessage("Sledovanie objednávky"),
        "orders": MessageLookupByLibrary.simpleMessage("Objednávky"),
        "otpVerification": MessageLookupByLibrary.simpleMessage("Overenie OTP"),
        "ourBankDetails":
            MessageLookupByLibrary.simpleMessage("Naše bankové údaje"),
        "outOfStock": MessageLookupByLibrary.simpleMessage("Vypredané"),
        "pageView": MessageLookupByLibrary.simpleMessage("Zobrazenie stránky"),
        "paid": MessageLookupByLibrary.simpleMessage("Zaplatené"),
        "paidStatus": MessageLookupByLibrary.simpleMessage("Stav platby"),
        "password": MessageLookupByLibrary.simpleMessage("Heslo"),
        "pasteYourImageUrl": MessageLookupByLibrary.simpleMessage(
            "Prilepte webovú adresu obrázka"),
        "payByWallet":
            MessageLookupByLibrary.simpleMessage("Plaťte peňaženkou"),
        "payNow": MessageLookupByLibrary.simpleMessage("Zaplatiť teraz"),
        "payment": MessageLookupByLibrary.simpleMessage("Platba"),
        "paymentMethod": MessageLookupByLibrary.simpleMessage("Spôsob platby"),
        "paymentMethodIsNotSupported": MessageLookupByLibrary.simpleMessage(
            "Tento spôsob platby nie je podporovaný"),
        "paymentMethods":
            MessageLookupByLibrary.simpleMessage("Spôsoby platby"),
        "paymentSuccessful":
            MessageLookupByLibrary.simpleMessage("Platba úspešná"),
        "pending": MessageLookupByLibrary.simpleMessage("Čaká sa"),
        "persian": MessageLookupByLibrary.simpleMessage("perzský"),
        "phone": MessageLookupByLibrary.simpleMessage("Telefón"),
        "phoneEmpty":
            MessageLookupByLibrary.simpleMessage("Telefón je prázdny"),
        "phoneHintFormat":
            MessageLookupByLibrary.simpleMessage("Formát: +421123456789"),
        "phoneIsRequired": MessageLookupByLibrary.simpleMessage(
            "Pole telefónneho čísla je povinné"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Telefónne číslo"),
        "phoneNumberVerification":
            MessageLookupByLibrary.simpleMessage("Overenie telefónneho čísla"),
        "pickADate":
            MessageLookupByLibrary.simpleMessage("Vyberte dátum a čas"),
        "placeMyOrder":
            MessageLookupByLibrary.simpleMessage("Zadať objednávku"),
        "playAll": MessageLookupByLibrary.simpleMessage("Prehrať všetko"),
        "pleaseAddPrice":
            MessageLookupByLibrary.simpleMessage("Prosím zadajte cenu"),
        "pleaseAgreeTerms": MessageLookupByLibrary.simpleMessage(
            "Vyjadrite súhlas s našimi podmienkami"),
        "pleaseAllowAccessCameraGallery": MessageLookupByLibrary.simpleMessage(
            "Povoľte prístup k fotoaparátu a galérii"),
        "pleaseCheckInternet": MessageLookupByLibrary.simpleMessage(
            "Prosím skontrolujte internetové pripojenie!"),
        "pleaseChooseCategory":
            MessageLookupByLibrary.simpleMessage("Prosím vyberte kategóriu"),
        "pleaseEnterProductName":
            MessageLookupByLibrary.simpleMessage("Zadajte názov produktu"),
        "pleaseFillCode": MessageLookupByLibrary.simpleMessage("Vyplňte kód"),
        "pleaseInput":
            MessageLookupByLibrary.simpleMessage("Vyplňte prosím pole"),
        "pleaseInputFillAllFields":
            MessageLookupByLibrary.simpleMessage("Vyplňte prosím všetky polia"),
        "pleaseSelectADate":
            MessageLookupByLibrary.simpleMessage("Vyberte dátum rezervácie"),
        "pleaseSelectALocation":
            MessageLookupByLibrary.simpleMessage("Vyberte miesto"),
        "pleaseSelectAllAttributes": MessageLookupByLibrary.simpleMessage(
            "Vyberte si s možností pre každý atribút produktu"),
        "pleaseSelectAttr": MessageLookupByLibrary.simpleMessage(
            "Vyberte aspoň 1 možnosť pre každý aktívny atribút"),
        "pleaseSelectImages":
            MessageLookupByLibrary.simpleMessage("Vyberte obrázky"),
        "pleaseSelectRequiredOptions": MessageLookupByLibrary.simpleMessage(
            "Vyberte požadované možnosti!"),
        "pleaseSignInBeforeUploading": MessageLookupByLibrary.simpleMessage(
            "Pred odovzdaním akýchkoľvek súborov sa prihláste do svojho účtu."),
        "pleasefillUpAllCellsProperly": MessageLookupByLibrary.simpleMessage(
            "*Prosím, správne vyplňte všetky bunky"),
        "point": MessageLookupByLibrary.simpleMessage("Body"),
        "pointMsgConfigNotFound": MessageLookupByLibrary.simpleMessage(
            "Na serveri nebola nájdená žiadna konfigurácia pre zľavové body"),
        "pointMsgEnter": MessageLookupByLibrary.simpleMessage(
            "Zadajte počet zľavových bodov"),
        "pointMsgMaximumDiscountPoint": MessageLookupByLibrary.simpleMessage(
            "Maximálny počet zľavových bodov"),
        "pointMsgNotEnough": MessageLookupByLibrary.simpleMessage(
            "Nemáte dostatok zľavových bodov. Váš celkový počet bodov je"),
        "pointMsgOverMaximumDiscountPoint":
            MessageLookupByLibrary.simpleMessage(
                "Dosiahli ste maximálny počet zľavových bodov"),
        "pointMsgOverTotalBill": MessageLookupByLibrary.simpleMessage(
            "Celková hodnota diskontu je vyššia ako celková hodnota účtu"),
        "pointMsgRemove":
            MessageLookupByLibrary.simpleMessage("Zľavové body sú odstránené"),
        "pointMsgSuccess": MessageLookupByLibrary.simpleMessage(
            "Zľava za body bola úspešne uplatnená"),
        "pointRewardMessage": MessageLookupByLibrary.simpleMessage(
            "Existuje pravidlo zliav pre uplatnenie vašich bodov do košíka"),
        "polish": MessageLookupByLibrary.simpleMessage("poľský"),
        "popular": MessageLookupByLibrary.simpleMessage("Populárne"),
        "popularity": MessageLookupByLibrary.simpleMessage("Popularita"),
        "posAddressToolTip": MessageLookupByLibrary.simpleMessage(
            "Táto adresa sa uloží do vášho lokálneho zariadenia. NIE JE to adresa užívateľa."),
        "postContent": MessageLookupByLibrary.simpleMessage("Obsah"),
        "postFail": MessageLookupByLibrary.simpleMessage(
            "Váš príspevok sa nepodarilo vytvoriť"),
        "postImageFeature":
            MessageLookupByLibrary.simpleMessage("Funkcia obrázka"),
        "postManagement": MessageLookupByLibrary.simpleMessage("Správa pošty"),
        "postProduct": MessageLookupByLibrary.simpleMessage("Odoslať produkt"),
        "postSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Váš príspevok bol úspešne vytvorený"),
        "postTitle": MessageLookupByLibrary.simpleMessage("Nadpis"),
        "prepaid": MessageLookupByLibrary.simpleMessage("Predplatené"),
        "prev": MessageLookupByLibrary.simpleMessage("predch"),
        "priceHighToLow": MessageLookupByLibrary.simpleMessage(
            "Cena: od najvyššej po najnižšiu"),
        "priceLowToHigh":
            MessageLookupByLibrary.simpleMessage("Cena: nízka až vysoká"),
        "prices": MessageLookupByLibrary.simpleMessage("Ceny"),
        "printReceipt":
            MessageLookupByLibrary.simpleMessage("Vytlačiť potvrdenie"),
        "printer": MessageLookupByLibrary.simpleMessage("Tlačiareň"),
        "printerNotFound":
            MessageLookupByLibrary.simpleMessage("Tlačiareň sa nenašla"),
        "printerSelection":
            MessageLookupByLibrary.simpleMessage("Výber tlačiarne"),
        "printing": MessageLookupByLibrary.simpleMessage("Tlačí sa..."),
        "privacyAndTerm": MessageLookupByLibrary.simpleMessage(
            "Osob. údaje a obch. podmienky"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage(
            "Zásady ochrany osobných údajov"),
        "privacyTerms": MessageLookupByLibrary.simpleMessage(
            "Ochrana osobných údajov a podmienky"),
        "private": MessageLookupByLibrary.simpleMessage("Súkromné"),
        "product": MessageLookupByLibrary.simpleMessage("Produkt"),
        "productAdded": MessageLookupByLibrary.simpleMessage("Produkt pridaný"),
        "productCreateReview": MessageLookupByLibrary.simpleMessage(
            "Váš produkt sa zobrazí po kontrole."),
        "productName": MessageLookupByLibrary.simpleMessage("Názov produktu"),
        "productNeedAtLeastOneVariation": MessageLookupByLibrary.simpleMessage(
            "Premenná typu produktu potrebuje aspoň jeden variant"),
        "productNeedNameAndPrice": MessageLookupByLibrary.simpleMessage(
            "Typ produktu jednoduchý potrebuje názov a bežnú cenu"),
        "productOutOfStock":
            MessageLookupByLibrary.simpleMessage("Produkt je vypredaný"),
        "productRating":
            MessageLookupByLibrary.simpleMessage("Vaše hodnotenie"),
        "productReview":
            MessageLookupByLibrary.simpleMessage("Recenzia produktu"),
        "productType": MessageLookupByLibrary.simpleMessage("Typ produktu"),
        "products": MessageLookupByLibrary.simpleMessage("Produkty"),
        "publish": MessageLookupByLibrary.simpleMessage("Publikovať"),
        "pullToLoadMore":
            MessageLookupByLibrary.simpleMessage("Potiahnutím načítajte viac"),
        "qty": MessageLookupByLibrary.simpleMessage("Množstvo"),
        "qtyTotal": m24,
        "quantityProductExceedInStock": MessageLookupByLibrary.simpleMessage(
            "Aktuálne množstvo je väčšie ako množstvo na sklade"),
        "rate": MessageLookupByLibrary.simpleMessage("Hodnotenie"),
        "rateTheApp":
            MessageLookupByLibrary.simpleMessage("Ohodnoťte aplikáciu"),
        "rateThisApp":
            MessageLookupByLibrary.simpleMessage("Ohodnoťte túto aplikáciu"),
        "rateThisAppDescription": MessageLookupByLibrary.simpleMessage(
            "Ak sa vám táto aplikácia páči, venujte trochu času jej hodnoteniu!\nNaozaj nám to pomáha a nemalo by vám to zabrať viac ako jednu minútu."),
        "rating": MessageLookupByLibrary.simpleMessage("Hodnotenie"),
        "ratingFirst": MessageLookupByLibrary.simpleMessage(
            "Pred odoslaním komentára ohodnoťte"),
        "reOrder": MessageLookupByLibrary.simpleMessage("Znova objednať"),
        "readReviews": MessageLookupByLibrary.simpleMessage("Recenzie"),
        "receivedMoney":
            MessageLookupByLibrary.simpleMessage("Prijaté peniaze"),
        "receiver": MessageLookupByLibrary.simpleMessage("prijímač"),
        "recentSearches":
            MessageLookupByLibrary.simpleMessage("História hľadania"),
        "recentView":
            MessageLookupByLibrary.simpleMessage("Vaše posledné zobrazenia"),
        "recentlyViewed":
            MessageLookupByLibrary.simpleMessage("Naposledy zobrazené"),
        "recents": MessageLookupByLibrary.simpleMessage("Nedávne"),
        "recommended": MessageLookupByLibrary.simpleMessage("Odporúčané"),
        "recurringTotals":
            MessageLookupByLibrary.simpleMessage("Opakujúce sa súčty"),
        "refresh": MessageLookupByLibrary.simpleMessage("Obnoviť"),
        "refundOrderFailed": MessageLookupByLibrary.simpleMessage(
            "Žiadosť o vrátenie peňazí za objednávku nebola úspešná"),
        "refundOrderSuccess": MessageLookupByLibrary.simpleMessage(
            "Požiadavka na vrátenie peňazí za objednávku bola úspešná!"),
        "refundRequest":
            MessageLookupByLibrary.simpleMessage("Návrh na vrátenie"),
        "refundRequested":
            MessageLookupByLibrary.simpleMessage("Vyžaduje sa vrátenie peňazí"),
        "refunds": MessageLookupByLibrary.simpleMessage("Vrátenie peňazí"),
        "regenerateResponse":
            MessageLookupByLibrary.simpleMessage("Regenerovať odozvu"),
        "registerAs":
            MessageLookupByLibrary.simpleMessage("Zaregistrujte sa ako"),
        "registerAsVendor": MessageLookupByLibrary.simpleMessage(
            "Zaregistrujte sa ako používateľ predajcu"),
        "registerFailed":
            MessageLookupByLibrary.simpleMessage("Registrácia zlyhala"),
        "registerSuccess":
            MessageLookupByLibrary.simpleMessage("Registrácia bola úspešná"),
        "regularPrice": MessageLookupByLibrary.simpleMessage("Predajná cena"),
        "relatedLayoutTitle": MessageLookupByLibrary.simpleMessage(
            "Veci, ktoré by sa Vám mohli páčiť"),
        "releaseToLoadMore": MessageLookupByLibrary.simpleMessage(
            "Uvoľnite, ak chcete načítať viac"),
        "remove": MessageLookupByLibrary.simpleMessage("Odstrániť"),
        "removeFromWishList":
            MessageLookupByLibrary.simpleMessage("Odstrániť zo zoznamu želaní"),
        "requestBooking":
            MessageLookupByLibrary.simpleMessage("Požiadajte o rezerváciu"),
        "requestTooMany": MessageLookupByLibrary.simpleMessage(
            "Vyžiadali ste príliš veľa kódov v krátkom čase. Skúste neskôr prosím."),
        "resend": MessageLookupByLibrary.simpleMessage("ZNOVU ODOSLAŤ"),
        "reset": MessageLookupByLibrary.simpleMessage("Resetovať"),
        "resetPassword": MessageLookupByLibrary.simpleMessage("Obnoviť heslo"),
        "resetYourPassword":
            MessageLookupByLibrary.simpleMessage("Obnoviť Vaše heslo"),
        "results": MessageLookupByLibrary.simpleMessage("Výsledky"),
        "retry": MessageLookupByLibrary.simpleMessage("Skúsiť znova"),
        "review": MessageLookupByLibrary.simpleMessage("Náhľad"),
        "reviewApproval":
            MessageLookupByLibrary.simpleMessage("Schválenie recenzie"),
        "reviewPendingApproval": MessageLookupByLibrary.simpleMessage(
            "Vaša recenzia bola odoslaná a čaká na schválenie!"),
        "reviewSent": MessageLookupByLibrary.simpleMessage(
            "Vaša recenzia bola odoslaná!"),
        "reviews": MessageLookupByLibrary.simpleMessage("Recenzie"),
        "romanian": MessageLookupByLibrary.simpleMessage("rumunský"),
        "russian": MessageLookupByLibrary.simpleMessage("ruský"),
        "sale": m25,
        "salePrice": MessageLookupByLibrary.simpleMessage("Zľavnená cena"),
        "save": MessageLookupByLibrary.simpleMessage("Uložiť"),
        "saveAddress": MessageLookupByLibrary.simpleMessage("Uložiť adresu"),
        "saveAddressSuccess":
            MessageLookupByLibrary.simpleMessage("Adresa nájdená"),
        "saveForLater":
            MessageLookupByLibrary.simpleMessage("Uložiť na neskôr"),
        "saveToWishList":
            MessageLookupByLibrary.simpleMessage("Uložiť do zoznamu želaní"),
        "scannerCannotScan": MessageLookupByLibrary.simpleMessage(
            "Túto položku nie je možné naskenovať"),
        "scannerLoginFirst": MessageLookupByLibrary.simpleMessage(
            "Pre skenovanie objednávky sa musíte najprv prihlásiť"),
        "scannerOrderAvailable": MessageLookupByLibrary.simpleMessage(
            "Táto objednávka nie je dostupná pre váš účet"),
        "search": MessageLookupByLibrary.simpleMessage("Vyhľadávanie"),
        "searchByName":
            MessageLookupByLibrary.simpleMessage("Hľadať podľa mena..."),
        "searchForItems":
            MessageLookupByLibrary.simpleMessage("Hľadať podľa položky"),
        "searchInput": MessageLookupByLibrary.simpleMessage(
            "Zadajte text do vyhľadávacieho poľa"),
        "searchOrderId": MessageLookupByLibrary.simpleMessage(
            "Hľadať pomocou čísla objednávky..."),
        "searchPlace": MessageLookupByLibrary.simpleMessage("Hľadať miesto"),
        "searchingAddress":
            MessageLookupByLibrary.simpleMessage("Vyhľadať adresu"),
        "secondsAgo": m26,
        "seeAll": MessageLookupByLibrary.simpleMessage("Zobraziť všetko"),
        "seeNewAppConfig": MessageLookupByLibrary.simpleMessage(
            "Pokračujte v zobrazovaní nového obsahu vo svojej aplikácii."),
        "seeOrder":
            MessageLookupByLibrary.simpleMessage("Pozrite si objednávku"),
        "seeReviews":
            MessageLookupByLibrary.simpleMessage("Pozrite si recenzie"),
        "select": MessageLookupByLibrary.simpleMessage("vybrať"),
        "selectAddress": MessageLookupByLibrary.simpleMessage("Vybrať adresu"),
        "selectAll": MessageLookupByLibrary.simpleMessage("Vybrať všetko"),
        "selectDates": MessageLookupByLibrary.simpleMessage("Vyberte dátumy"),
        "selectFileCancelled":
            MessageLookupByLibrary.simpleMessage("Výber súboru bol zrušený!"),
        "selectImage": MessageLookupByLibrary.simpleMessage("Vyberte Obrázok"),
        "selectNone": MessageLookupByLibrary.simpleMessage("Nič nevybraté"),
        "selectPrinter":
            MessageLookupByLibrary.simpleMessage("Vyberte položku Tlačiareň"),
        "selectRole": MessageLookupByLibrary.simpleMessage("Vyberte rolu"),
        "selectTheColor": MessageLookupByLibrary.simpleMessage("Vyberte farbu"),
        "selectThePoint": MessageLookupByLibrary.simpleMessage("Vyberte bod"),
        "selectTheQuantity": MessageLookupByLibrary.simpleMessage("Množstvo"),
        "selectTheSize": MessageLookupByLibrary.simpleMessage("Veľkosť"),
        "send": MessageLookupByLibrary.simpleMessage("Odoslať"),
        "sendBack": MessageLookupByLibrary.simpleMessage("Poslať späť"),
        "sendSMSCode": MessageLookupByLibrary.simpleMessage("Získať kód"),
        "sendSMStoVendor": MessageLookupByLibrary.simpleMessage(
            "Pošlite SMS majiteľovi obchodu"),
        "serbian": MessageLookupByLibrary.simpleMessage("srbský"),
        "sessionExpired":
            MessageLookupByLibrary.simpleMessage("Platnosť relácie vypršala"),
        "setAnAddressInSettingPage": MessageLookupByLibrary.simpleMessage(
            "Prosím, nastavte adresu na stránke nastavení"),
        "settings": MessageLookupByLibrary.simpleMessage("Nastavenie"),
        "share": MessageLookupByLibrary.simpleMessage("Zdieľať"),
        "shipped": MessageLookupByLibrary.simpleMessage("Odoslané"),
        "shipping": MessageLookupByLibrary.simpleMessage("Doprava"),
        "shippingAddress":
            MessageLookupByLibrary.simpleMessage("Dodacia adresa"),
        "shippingMethod":
            MessageLookupByLibrary.simpleMessage("Spôsob dopravy"),
        "shop": MessageLookupByLibrary.simpleMessage("Predajňa"),
        "shopEmail": MessageLookupByLibrary.simpleMessage("E-mail obchodu"),
        "shopName": MessageLookupByLibrary.simpleMessage("Názov obchodu"),
        "shopOrders":
            MessageLookupByLibrary.simpleMessage("Objednávky v obchode"),
        "shopPhone": MessageLookupByLibrary.simpleMessage("Telefón obchodu"),
        "shopSlug": MessageLookupByLibrary.simpleMessage("Skratka pre obchod"),
        "shoppingCartItems": m27,
        "shortDescription":
            MessageLookupByLibrary.simpleMessage("Stručný opis"),
        "showAllMyOrdered":
            MessageLookupByLibrary.simpleMessage("Všetky objednávky"),
        "showDetails":
            MessageLookupByLibrary.simpleMessage("Zobraziť podrobnosti"),
        "showGallery": MessageLookupByLibrary.simpleMessage("Zobraziť galériu"),
        "showLess": MessageLookupByLibrary.simpleMessage("Zobraziť menej"),
        "showMore": MessageLookupByLibrary.simpleMessage("Zobraziť viac"),
        "signIn": MessageLookupByLibrary.simpleMessage("Prihlásiť sa"),
        "signInWithEmail":
            MessageLookupByLibrary.simpleMessage("Prihlásiť sa e-mailom"),
        "signUp": MessageLookupByLibrary.simpleMessage("Registrovať sa"),
        "signup": MessageLookupByLibrary.simpleMessage("Registrovať sa"),
        "simple": MessageLookupByLibrary.simpleMessage("Jednoduchý"),
        "size": MessageLookupByLibrary.simpleMessage("Veľkosť"),
        "skip": MessageLookupByLibrary.simpleMessage("Preskočiť"),
        "sku": MessageLookupByLibrary.simpleMessage("SKU"),
        "slovak": MessageLookupByLibrary.simpleMessage("slovenský"),
        "smsCodeExpired": MessageLookupByLibrary.simpleMessage(
            "Platnosť SMS kódu vypršala. Znova odošlite overovací kód a skúste to znova."),
        "sold": m28,
        "soldBy": MessageLookupByLibrary.simpleMessage("Predáva"),
        "somethingWrong": MessageLookupByLibrary.simpleMessage(
            "Niečo sa pokazilo. Skúste neskôr prosím."),
        "sortBy": MessageLookupByLibrary.simpleMessage("Triediť podľa"),
        "sortCode": MessageLookupByLibrary.simpleMessage("Triediaci kód"),
        "spanish": MessageLookupByLibrary.simpleMessage("španielsky"),
        "speechNotAvailable":
            MessageLookupByLibrary.simpleMessage("Reč nie je k dispozícii"),
        "startExploring":
            MessageLookupByLibrary.simpleMessage("Začnite prehľadávať"),
        "startShopping":
            MessageLookupByLibrary.simpleMessage("Začnite nakupovať"),
        "state": MessageLookupByLibrary.simpleMessage("Stav"),
        "stateIsRequired":
            MessageLookupByLibrary.simpleMessage("Pole štát je povinné"),
        "stateProvince":
            MessageLookupByLibrary.simpleMessage("Štát / provincia"),
        "status": MessageLookupByLibrary.simpleMessage("Status"),
        "stock": MessageLookupByLibrary.simpleMessage("Sklad"),
        "stockQuantity": MessageLookupByLibrary.simpleMessage("Skladom"),
        "stop": MessageLookupByLibrary.simpleMessage("Stop"),
        "store": MessageLookupByLibrary.simpleMessage("sklad"),
        "storeAddress": MessageLookupByLibrary.simpleMessage("Adresa predajne"),
        "storeBanner": MessageLookupByLibrary.simpleMessage("Banner"),
        "storeBrand": MessageLookupByLibrary.simpleMessage("Obchodná značka"),
        "storeClosed":
            MessageLookupByLibrary.simpleMessage("Predajňa je zatvorená"),
        "storeEmail": MessageLookupByLibrary.simpleMessage("E-mail obchodu"),
        "storeInformation":
            MessageLookupByLibrary.simpleMessage("Uložiť informácie"),
        "storeListBanner":
            MessageLookupByLibrary.simpleMessage("Bannery obchodu"),
        "storeLocation":
            MessageLookupByLibrary.simpleMessage("Umiestnenie predajne"),
        "storeLogo": MessageLookupByLibrary.simpleMessage("Logo obchodu"),
        "storeMobileBanner": MessageLookupByLibrary.simpleMessage(
            "Banner pre mobilné zariadenia"),
        "storeSettings":
            MessageLookupByLibrary.simpleMessage("Nastavenia obchodu"),
        "storeSliderBanner":
            MessageLookupByLibrary.simpleMessage("Pohyblivý banner"),
        "storeStaticBanner":
            MessageLookupByLibrary.simpleMessage("Statický banner"),
        "storeVacation": MessageLookupByLibrary.simpleMessage("Dovolenka"),
        "stores": MessageLookupByLibrary.simpleMessage("Obchody"),
        "street": MessageLookupByLibrary.simpleMessage("Ulica"),
        "street2": MessageLookupByLibrary.simpleMessage("Doplnková informácia"),
        "streetIsRequired":
            MessageLookupByLibrary.simpleMessage("Názov ulice je povinný"),
        "streetName": MessageLookupByLibrary.simpleMessage("Názov ulice"),
        "streetNameApartment": MessageLookupByLibrary.simpleMessage("Byt"),
        "streetNameBlock": MessageLookupByLibrary.simpleMessage("Blok"),
        "submit": MessageLookupByLibrary.simpleMessage("Odoslať"),
        "submitYourPost":
            MessageLookupByLibrary.simpleMessage("Odoslať príspevok"),
        "subtotal": MessageLookupByLibrary.simpleMessage("Medzisúčet"),
        "support": MessageLookupByLibrary.simpleMessage("podpora"),
        "swahili": MessageLookupByLibrary.simpleMessage("swahilčina"),
        "swedish": MessageLookupByLibrary.simpleMessage("švédsky"),
        "tagNotExist":
            MessageLookupByLibrary.simpleMessage("Táto značka neexistuje"),
        "tags": MessageLookupByLibrary.simpleMessage("Tagy"),
        "takePicture": MessageLookupByLibrary.simpleMessage("Odfotiť"),
        "tamil": MessageLookupByLibrary.simpleMessage("tamil"),
        "tapSelectLocation":
            MessageLookupByLibrary.simpleMessage("Klepnutím vyberte miesto"),
        "tapTheMicToTalk": MessageLookupByLibrary.simpleMessage(
            "Hovorte klepnutím na mikrofón"),
        "tax": MessageLookupByLibrary.simpleMessage("Daň"),
        "thailand": MessageLookupByLibrary.simpleMessage("thai"),
        "theFieldIsRequired": m29,
        "thisDateIsNotAvailable":
            MessageLookupByLibrary.simpleMessage("Tento dátum nie je dostupný"),
        "thisFeatureDoesNotSupportTheCurrentLanguage":
            MessageLookupByLibrary.simpleMessage(
                "Táto funkcia nepodporuje aktuálny jazyk"),
        "thisPlatformNotSupportWebview": MessageLookupByLibrary.simpleMessage(
            "Táto platforma nepodporuje webview"),
        "thisProductNotSupport": MessageLookupByLibrary.simpleMessage(
            "Tento produkt nie je podporovaný"),
        "tickets": MessageLookupByLibrary.simpleMessage("Vstupenky"),
        "time": MessageLookupByLibrary.simpleMessage("čas"),
        "title": MessageLookupByLibrary.simpleMessage("Nadpis"),
        "titleAToZ": MessageLookupByLibrary.simpleMessage("Názov: A až Z"),
        "titleZToA": MessageLookupByLibrary.simpleMessage("Názov: Z po A"),
        "tooManyFaildedLogin": MessageLookupByLibrary.simpleMessage(
            "Príliš veľa neúspešných pokusov o prihlásenie. Skúste neskôr prosím."),
        "topUp": MessageLookupByLibrary.simpleMessage("Topujte"),
        "topUpProductNotFound": MessageLookupByLibrary.simpleMessage(
            "Produkt na doplnenie sa nenašiel"),
        "total": MessageLookupByLibrary.simpleMessage("Celkom"),
        "totalCartValue": MessageLookupByLibrary.simpleMessage(
            "Celková hodnota objednávky musí byť minimálne"),
        "totalProducts": m30,
        "totalTax": MessageLookupByLibrary.simpleMessage("DPH"),
        "trackingNumberIs":
            MessageLookupByLibrary.simpleMessage("Sledovacie číslo je"),
        "trackingPage":
            MessageLookupByLibrary.simpleMessage("Stránka sledovania"),
        "transactionCancelled":
            MessageLookupByLibrary.simpleMessage("Transakcia zrušená"),
        "transactionDetail":
            MessageLookupByLibrary.simpleMessage("Detail transakcie"),
        "transactionFailded":
            MessageLookupByLibrary.simpleMessage("transakcia zlyhala"),
        "transactionFee":
            MessageLookupByLibrary.simpleMessage("Poplatok za transakciu"),
        "transactionResult":
            MessageLookupByLibrary.simpleMessage("Výsledok transakcie"),
        "transfer": MessageLookupByLibrary.simpleMessage("Prevod"),
        "transferConfirm":
            MessageLookupByLibrary.simpleMessage("Potvrdenie prevodu"),
        "transferErrorMessage": MessageLookupByLibrary.simpleMessage(
            "Nemôžete preniesť na tohto používateľa"),
        "transferFailed": MessageLookupByLibrary.simpleMessage("Prenos zlyhal"),
        "transferSuccess":
            MessageLookupByLibrary.simpleMessage("Prenos úspešný"),
        "turkish": MessageLookupByLibrary.simpleMessage("turecký"),
        "turnOnBle": MessageLookupByLibrary.simpleMessage("Zapnite Bluetooth"),
        "typeAMessage":
            MessageLookupByLibrary.simpleMessage("Napíšte správu..."),
        "typeYourMessage":
            MessageLookupByLibrary.simpleMessage("Sem napíšte správu..."),
        "typing": MessageLookupByLibrary.simpleMessage("Píšem..."),
        "ukrainian": MessageLookupByLibrary.simpleMessage("ukrajinský"),
        "unavailable": MessageLookupByLibrary.simpleMessage("Nedostupné"),
        "undo": MessageLookupByLibrary.simpleMessage("Späť"),
        "unpaid": MessageLookupByLibrary.simpleMessage("Nezaplatená"),
        "update": MessageLookupByLibrary.simpleMessage("Aktualizovať"),
        "updateFailed":
            MessageLookupByLibrary.simpleMessage("Aktualizácia neuspešná!"),
        "updateInfo":
            MessageLookupByLibrary.simpleMessage("Aktualizovať informácie"),
        "updatePassword":
            MessageLookupByLibrary.simpleMessage("Aktualizujte heslo"),
        "updateStatus":
            MessageLookupByLibrary.simpleMessage("Aktualizovať stav"),
        "updateSuccess":
            MessageLookupByLibrary.simpleMessage("Aktualizácia bola úspešná!"),
        "updateUserInfor":
            MessageLookupByLibrary.simpleMessage("Aktualizovať profil"),
        "uploadFile": MessageLookupByLibrary.simpleMessage("Nahrať súbor"),
        "uploadProduct": MessageLookupByLibrary.simpleMessage("Nahrať produkt"),
        "uploading": MessageLookupByLibrary.simpleMessage("Nahrávanie"),
        "url": MessageLookupByLibrary.simpleMessage("URL"),
        "useMaximumPointDiscount": m31,
        "useNow": MessageLookupByLibrary.simpleMessage("Použiť teraz"),
        "useThisImage":
            MessageLookupByLibrary.simpleMessage("Použite tento obrázok"),
        "userExists": MessageLookupByLibrary.simpleMessage(
            "Toto používateľské meno/e-mail nie je k dispozícii."),
        "userNameInCorrect": MessageLookupByLibrary.simpleMessage(
            "Používateľské meno alebo heslo je nesprávne."),
        "username": MessageLookupByLibrary.simpleMessage("Používateľské meno"),
        "usernameAndPasswordRequired": MessageLookupByLibrary.simpleMessage(
            "Vyžaduje sa používateľské meno a heslo"),
        "vacationMessage":
            MessageLookupByLibrary.simpleMessage("Dovolenková správa"),
        "vacationType": MessageLookupByLibrary.simpleMessage("Typ dovolenky"),
        "validUntilDate": m32,
        "variable": MessageLookupByLibrary.simpleMessage("Variabilné"),
        "variation": MessageLookupByLibrary.simpleMessage("Variácie"),
        "vendor": MessageLookupByLibrary.simpleMessage("Predajca"),
        "vendorAdmin": MessageLookupByLibrary.simpleMessage("Správca predajcu"),
        "vendorInfo":
            MessageLookupByLibrary.simpleMessage("Informácie o predajcovi"),
        "verificationCode":
            MessageLookupByLibrary.simpleMessage("Overovací kód (6 číslic)"),
        "verifySMSCode": MessageLookupByLibrary.simpleMessage("Overiť"),
        "viaWallet": MessageLookupByLibrary.simpleMessage("Cez peňaženku"),
        "video": MessageLookupByLibrary.simpleMessage("Video"),
        "vietnamese": MessageLookupByLibrary.simpleMessage("vietnamský"),
        "viewOnGoogleMaps":
            MessageLookupByLibrary.simpleMessage("Zobraziť na Google Maps"),
        "viewRecentTransactions": MessageLookupByLibrary.simpleMessage(
            "Pozrite si posledné transakcie"),
        "visible": MessageLookupByLibrary.simpleMessage("Viditeľné"),
        "visitStore": MessageLookupByLibrary.simpleMessage("Navštívte Obchod"),
        "waitForLoad":
            MessageLookupByLibrary.simpleMessage("Čaká sa na načítanie"),
        "waitForPost":
            MessageLookupByLibrary.simpleMessage("Čaká sa na príspevok"),
        "waitingForConfirmation":
            MessageLookupByLibrary.simpleMessage("Čaká sa na potvrdenie"),
        "walletBalance":
            MessageLookupByLibrary.simpleMessage("Zostatok v peňaženke"),
        "walletName": MessageLookupByLibrary.simpleMessage("Názov peňaženky"),
        "warning": m33,
        "warningCurrencyMessageForWallet": m34,
        "weFoundBlogs":
            MessageLookupByLibrary.simpleMessage("Našli sme tieto blog(y)"),
        "weFoundProducts": m35,
        "weNeedCameraAccessTo": MessageLookupByLibrary.simpleMessage(
            "Na skenovanie QR kódu alebo čiarového kódu potrebujeme prístup k fotoaparátu."),
        "weSentAnOTPTo": MessageLookupByLibrary.simpleMessage(
            "Overovací kód bol odoslaný na adresu"),
        "weWillSendYouNotification": MessageLookupByLibrary.simpleMessage(
            "Pošleme vám upozornenia, keď budú dostupné nové produkty alebo ponuky. Toto nastavenie môžete kedykoľvek zmeniť v nastaveniach."),
        "webView": MessageLookupByLibrary.simpleMessage("Web zobrazenie"),
        "week": m36,
        "welcome": MessageLookupByLibrary.simpleMessage("Vítajte"),
        "welcomeUser": m37,
        "whichLanguageDoYouPrefer":
            MessageLookupByLibrary.simpleMessage("Ktorý jazyk preferujete?"),
        "wholesaleRegisterMsg": MessageLookupByLibrary.simpleMessage(
            "Obráťte sa na správcu, aby schválil vašu registráciu."),
        "womanCollections":
            MessageLookupByLibrary.simpleMessage("Kolekcie pre ženy"),
        "writeComment":
            MessageLookupByLibrary.simpleMessage("Napíšte komentár"),
        "writeYourNote":
            MessageLookupByLibrary.simpleMessage("Napíšte poznámku"),
        "yearsAgo": m38,
        "yes": MessageLookupByLibrary.simpleMessage("Áno"),
        "youCanOnlyOrderSingleStore": MessageLookupByLibrary.simpleMessage(
            "Môžete nakupovať iba v jednom obchode."),
        "youCanOnlyPurchase":
            MessageLookupByLibrary.simpleMessage("Môžete len kupovať"),
        "youHaveAssignedToOrder": m39,
        "youHaveBeenSaveAddressYourLocal": MessageLookupByLibrary.simpleMessage(
            "Bola uložená Vaša lokálna adresa"),
        "youHavePoints": MessageLookupByLibrary.simpleMessage("Máte \$bodov"),
        "youMightAlsoLike":
            MessageLookupByLibrary.simpleMessage("Mohlo by sa vám páčiť"),
        "youNeedToLoginCheckout": MessageLookupByLibrary.simpleMessage(
            "K pokladni sa musíte prihlásiť"),
        "youNotBeAsked":
            MessageLookupByLibrary.simpleMessage("Nabudúce sa ma nepýtať"),
        "yourAccountIsUnderReview": MessageLookupByLibrary.simpleMessage(
            "Prebieha kontrola vášho účtu. Ak potrebujete pomoc, kontaktujte správcu."),
        "yourAddressExistYourLocal":
            MessageLookupByLibrary.simpleMessage("Vaša adresa bola nájdená"),
        "yourAddressHasBeenSaved": MessageLookupByLibrary.simpleMessage(
            "Adresa bola uložená do vášho lokálneho úložiska"),
        "yourApplicationIsUnderReview": MessageLookupByLibrary.simpleMessage(
            "Prebieha kontrola vašej žiadosti."),
        "yourBagIsEmpty":
            MessageLookupByLibrary.simpleMessage("Vaša taška je prázdna"),
        "yourBookingDetail": MessageLookupByLibrary.simpleMessage(
            "Podrobnosti o vašej rezervácii"),
        "yourEarningsThisMonth": MessageLookupByLibrary.simpleMessage(
            "Vaše zárobky za tento mesiac"),
        "yourNote": MessageLookupByLibrary.simpleMessage("Vaša poznámka"),
        "yourOrderHasBeenAdded": MessageLookupByLibrary.simpleMessage(
            "Vaša objednávka bola pridaná"),
        "yourOrders": MessageLookupByLibrary.simpleMessage("Vaše objednávky"),
        "yourProductIsUnderReview": MessageLookupByLibrary.simpleMessage(
            "Prebieha kontrola vášho produktu"),
        "yourUsernameEmail": MessageLookupByLibrary.simpleMessage(
            "Vaše používateľské meno alebo e-mail"),
        "zipCode": MessageLookupByLibrary.simpleMessage("PSČ"),
        "zipCodeIsRequired":
            MessageLookupByLibrary.simpleMessage("Pole PSČ je povinné")
      };
}
