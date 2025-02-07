import 'dart:io';

class Book {
  //Classe des livres
  int id;
  String name;
  String author;
  String category;
  bool available;
  int quantity;

  //Liste statique pour pouvoir afficher les instances de livres
  static List<Book> booksList = [];

  Book(this.id, this.name, this.author, this.category, this.available,
      this.quantity) {
    booksList.add(this);
    bookCounter++;
  }

  //La façon dont les livres  vont être présentés si on les liste
  @override
  String toString() {
    return 'ID: $id, Titre: $name, Auteur: $author';
  }

  //Setter pour retirer/ajouter un exemplaire en cas d'emprunt/remise
  set setQty(int n) {
    quantity += n;
  }

  // Méthode statique pour afficher les livres
  static void displayBooks() {
    if (booksList.isEmpty) {
      print("Aucun livre n'est encore enregistré.");
    } else {
      print("Liste des livres enregistrés :");
      for (var livre in booksList) {
        print(livre);
      }
    }
  }

  // Méthode pour afficher récupérer un livre avec son identifiant
  static Book? getbookById(int? id) {
    for (Book book in booksList) {
      if (book.id == id) {
        return book; // Renvois le livre
      }
    }
    return null; // Renvoie null en si le livre n'est pas trouvé
  }
}

class Client {
  //Classe des clients
  int id;
  String name;
  int borrowCount;
  int phone;

  //Liste statique pour pouvoir afficher les clients
  static List<Client> clientsList = [];

  Client(this.id, this.name, this.borrowCount, this.phone) {
    clientsList.add(this);
    cCounter++;
  }

  //La façon dont les clients vont être présentés si on les liste
  @override
  String toString() {
    return 'ID: $id, Nom: $name, Téléphone: $phone';
  }

  //Setter pour incrémenter/décrémenter le compteur d'emprunts
  set setbCt(int n) {
    borrowCount += n;
  }

  // Méthode statique pour afficher les clients
  static void displayClients() {
    if (clientsList.isEmpty) {
      print("Aucun client n'est encore enregistré.");
    } else {
      print("Liste des clients enregistrés :");
      for (var client in clientsList) {
        print(client);
      }
    }
  }

  // Méthode pour afficher récupérer un client avec son identifiant
  static Client? getClientById(int? id) {
    for (Client client in clientsList) {
      if (client.id == id) {
        return client; // Renvois le client
      }
    }
    return null; // Renvoie null en si le client n'est pas trouvé
  }
}

class Borrow {
  //Classe des emprunts de livres
  int id;
  Book book;
  Client client;
  DateTime date;

  //Liste statique pour pouvoir afficher les instances de emprunts
  static List<Borrow> borrowList = [];

  Borrow(this.id, this.book, this.client, this.date) {
    borrowList.add(this);
    bCounter++;
  }

  //Getter pour afficher les informations d'un emprunt.
  String get show {
    return "N°$id: Client N°: ${client.id} : ${client.name} \n     Livre N°: ${book.id} : ${book.name} \n     Date: $date \n \n------- \n";
  }

  //Retrait d'un emprunt
  void removeBorrow() {
    borrowList.remove(this);
  }

  // Méthode statique pour afficher les livres
  static void displayBorrow() {
    if (borrowList.isEmpty) {
      print("Aucun livre n'a encore été emprunté.");
    } else {
      print("Liste des emprunts :");
      for (var borrow in borrowList) {
        print(borrow.show);
      }
    }
  }

  static Borrow? getborrowById(int? id) {
    for (Borrow borrow in borrowList) {
      if (borrow.id == id) {
        return borrow; // Renvois l'emprunt
      }
    }
    return null; // Renvoie null en si l'emprunt n'est pas trouvé
  }
}

class Returns {
  //Classe des remises de livres
  int id;
  Borrow borrow;
  DateTime date;

  //Liste statique pour pouvoir afficher les instances de emprunts
  static List<Returns> returnsList = [];

  Returns(this.id, this.borrow, this.date) {
    returnsList.add(this);
  }

  //Getter pour afficher les informations d'un emprunt.
  String get show {
    return "N°$id: Date d'emprunt: ${borrow.date} \n Client N°: ${borrow.client.id} : ${borrow.client.name} \n     Livre N°: ${borrow.book.id} : ${borrow.book.name} \n     Date de remise: $date \n \n------- \n";
  }

  // Méthode statique pour afficher les livres
  static void displayReturns() {
    if (returnsList.isEmpty) {
      print("Aucun livre n'a encore été retourné.");
    } else {
      print("Liste des livres enregistrés :");
      for (var r in returnsList) {
        print(r.show);
      }
    }
  }
}

/*********** Variables générales du programme ***********/
//Le compteur pour l'indexation des emprunts
int bCounter = 0;

//Le compteur pour l'indexation des clients
int cCounter = 0;

//Le compteur pour l'indexation des livres
int bookCounter = 0;

/*********** Fonctions du programme ***********/
//Fonction pour ajouter un nouveau client
void addClient() {
  print("Donner le nom du client");
  String? name = stdin.readLineSync();
  if (name != null) {
    print("Entrez le numéro de téléphone du client.");
    String? tel = stdin.readLineSync();
    int? phone = int.tryParse(tel ?? "0");
    if (phone != null && phone.runtimeType == int) {
      Client(cCounter, name, 0, phone);
      print("Le client a bien été enregistré.");
    } else {
      print("Une erreur dans la saisie du numéro");
    }
  }
}

//Fonction pour ajouter un nouveau livre
void addBook() {
  print("Donner le nom du livre");
  String? name = stdin.readLineSync();
  if (name != null) {
    print("Donner le nom de l'auteur.");
    String? author = stdin.readLineSync();
    if (author != null) {
      print("Entrée le genre du livre.");
      String? category = stdin.readLineSync();
      if (category != null) {
        print("Entrez le nombre d'examplaires.");
        String? qtity = stdin.readLineSync();
        int? qty = int.tryParse(qtity ?? "0");
        if (qty != null && qty.runtimeType == int) {
          if (qty.runtimeType == int) {
            Book(bookCounter, name, author, category, true, qty);
            print("Le livre a bien été enregistré.");
          }
        } else {
          print("Veuillez entrer une valeur numérique.");
        }
      }
    }
  }
}

//Fonction pour l'emprunt d'un livre
void recordBorrow() {
  print("Donner l'identifiant du client");
  String? idClient = stdin.readLineSync();
  int? clientId = int.tryParse(idClient ?? "0");
  //Récupération du client (la fonction continuera si le client existe).
  Client? client = Client.getClientById(clientId);
  if (client != null) {
    if (client.borrowCount < 3) {
      print("Donner l'identifiant du livre");
      String? idBook = stdin.readLineSync();
      int? bookId = int.tryParse(idBook ?? "0");
      //Récupération du livre (la fonction continuera si le livre existe).
      Book? book = Book.getbookById(bookId);
      if (book != null) {
        if (book.quantity > 0) {
          book.setQty = -1;
          client.setbCt = 1;
          Borrow(bCounter, book, client, DateTime.now());
          print("Emprunt de livre enregistré.");
        } else {
          print("Le stock du livre est épuisé.");
        }
      } else {
        print("Identifiant incorrect.");
      }
    } else {
      print("Cet abonné a déjà 3 emprunts en cours de validité.");
    }
  } else {
    print("Identifiant incorrect.");
  }
}

//Fonction pour la remise d'un livre
void recordReturn() {
  print("Donner le numéro d'emprunt:");
  String? idBorrow = stdin.readLineSync();
  int? borrowId = int.tryParse(idBorrow ?? "0");
  if (borrowId != null) {
    //Récupération du livre (la fonction continuera si le livre existe).
    Borrow? borrow = Borrow.getborrowById(borrowId);
    if (borrow != null) {
      Returns(bCounter, borrow, DateTime.now());
      borrow.removeBorrow();
      borrow.client.setbCt = 1;
      borrow.book.setQty = 1;
    }
  } else {
    print("Le numéro d'emprunt est incorrect.");
  }
}

void main() {
  //Création d'objet Client et Book pour gagner du temps dans le test de la fonction d'enregistrement d'emprunt
  /****Book */
  Book(bookCounter, "Guide de l'informaticien", "B. Hermann NANA",
      "Informatique", true, 50);
  Book(bookCounter, "Les concepts de la programmation Orientée Objet",
      "Anne KABORE", "Informatique", true, 70);
  Book(bookCounter, "Le guide électronique", "Salimata OUEDRAOGO",
      "Electronique", true, 50);
  Book(bookCounter, "Les fondamentaux de la géomatique", "Ahmed SAWADOGO",
      "Géomatique", true, 26);
  Book(bookCounter, "La géopolitique pour les nuls", "Henri ZONGO",
      "Science-Po", true, 50);
  /****Client */
  Client(cCounter, "Gilbert Kabore", 0, 4578496);
  Client(cCounter, "Aline NANA", 0, 4578496);
  Client(cCounter, "Sabas ILBOUDO", 0, 4578496);
  Client(cCounter, "Julia TRAORE", 0, 4578496);
  Client(cCounter, "Grâce SAWADOGO", 0, 4578496);

  //Début du program
  int? action = 0;
  do {
    print(
        "Que souhaitez-vous faire ? (Entrez juste le numéro correspondant à votre action) \n"
        "1. Lister les livres \n"
        "2. Lister les Clients \n"
        "3. Lister les Emprunts \n"
        "4. Enregistrer un emprunt \n"
        "5. Enregistrer une remise de livre \n"
        "6. Ajouter un livre \n"
        "7. Enregistrer un nouvel abonné \n"
        "8. Quitter");

    String? userInput = stdin.readLineSync();
    action = int.tryParse(userInput ?? "0");

    switch (action) {
      case 1:
        Book.displayBooks();
        break;
      case 2:
        Client.displayClients();
        break;
      case 3:
        Borrow.displayBorrow();
        break;
      case 4:
        recordBorrow();
        break;
      case 5:
        recordReturn();
        break;
      case 6:
        addBook();
        break;
      case 7:
        addClient();
        break;
      case 8:
        print("Programme terminé. À bientôt !");
        break;
      default:
        print("Entrée invalide. Veuillez entrer un numéro entre 1 et 8.");
    }
  } while (action != 8);
}
