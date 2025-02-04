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
  }

  @override
  String toString() {
    return 'Titre: $name, Auteur: $author';
  }

  //Setter pour retirer/ajouter un exemplaire en cas d'emprunt/remise
  set setQty(n) =>
      (n > 0 || quantity > 0) ? quantity + n : print("Stock épuisé.");
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
}

class Client {
  //Classe des clients
  int id;
  String name;
  int borrowCount;
  int phone;
  Client(this.id, this.name, this.borrowCount, this.phone) {
    clientsList.add(this);
  }

  //Liste statique pour pouvoir afficher les clients
  static List<Client> clientsList = [];

  //Setter pour incrémenter/décrémenter le compteur d'emprunts
  set setbCt(n) => (borrowCount > 0 && borrowCount <= 3)
      ? borrowCount + n
      : print("Le client ne peut pas emprunter plus de trois livres.");
  // Méthode statique pour afficher les livres
  static void displayClients() {
    if (clientsList.isEmpty) {
      print("Aucun client n'est encore enregistré.");
    } else {
      print("Liste des livres enregistrés :");
      for (var livre in clientsList) {
        print(livre);
      }
    }
  }
}

class Borrows {
  //Classe des emprunts de livres
  int id;
  Book book;
  Client client;
  DateTime date;

  //Liste statique pour pouvoir afficher les instances de emprunts
  static List<Borrows> borrowsList = [];

  Borrows(this.id, this.book, this.client, this.date) {
    borrowsList.add(this);
  }

  //Getter pour afficher les informations d'un emprunt.
  String get show {
    return "Le client ${client.name} a emprunter le livre ${book.name} de ${book.author} à la date: $date";
  }

  // Méthode statique pour afficher les livres
  static void displayClients() {
    if (borrowsList.isEmpty) {
      print("Aucun livre n'a encore été emprunté.");
    } else {
      print("Liste des livres enregistrés :");
      for (var livre in borrowsList) {
        print(livre);
      }
    }
  }
}

class Returns {
  //Classe des remises de livres
  int id;
  Book book;
  Client client;
  DateTime date;

  //Liste statique pour pouvoir afficher les instances de emprunts
  static List<Returns> returnsList = [];

  Returns(this.id, this.book, this.client, this.date) {
    returnsList.add(this);
  }

  //Getter pour afficher les informations d'un emprunt.
  String get show {
    return "Le client ${client.name} a remis le livre ${book.name} de ${book.author} à la date: $date";
  }

  // Méthode statique pour afficher les livres
  static void displayClients() {
    if (returnsList.isEmpty) {
      print("Aucun livre n'a encore été retourné.");
    } else {
      print("Liste des livres enregistrés :");
      for (var livre in returnsList) {
        print(livre);
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
void addClient(String name, int phone) {
  Client(cCounter, name, 0, phone);
  cCounter++;
}

//Fonction pour ajouter un nouveau livre
void addBook(String name, String author, String category, int qty) {
  Book(bookCounter, name, author, category, true, qty);
  cCounter++;
}

//Fonction pour l'emprunt d'un livre
void recordBorrow(Client client, Book book) {
  book.setQty = -1;
  client.setbCt = 1;
  Borrows(bCounter, book, client, DateTime.now());
  bCounter++;
}

//Fonction pour la remise d'un livre
void recordReturn(Client client, Book book) {
  book.setQty = 1;
  client.setbCt = -1;
  Returns(bCounter, book, client, DateTime.now());
}

void main() {
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
        "7. Enregistrer un nouvel utilisateur \n"
        "8. Quitter");

    String? userInput = stdin.readLineSync();
    action = int.tryParse(userInput ?? "0");

    if (action == null || action < 1 || action > 8) {
      print("Entrée invalide. Veuillez entrer un numéro entre 1 et 8.");
    } else if (action == 1) {
      Book.displayBooks();
    } else if (action != 8) {
      print("Vous avez choisi l'action $action.\n");
    }
  } while (action != 8);

  print("Programme terminé. À bientôt !");
}
