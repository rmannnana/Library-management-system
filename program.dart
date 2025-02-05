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

  //La façon dont les livres  vont être présentés si on les liste
  @override
  String toString() {
    return 'ID: $id, Titre: $name, Auteur: $author';
  }

  //Setter pour retirer/ajouter un exemplaire en cas d'emprunt/remise
  set setQty(int n) {
    if (quantity + n >= 0) {
      quantity += n;
    } else {
      print("Stock épuisé.");
    }
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
  static Book? getbookById(int id) {
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
  }

  //La façon dont les clients vont être présentés si on les liste
  @override
  String toString() {
    return 'ID: $id, Nom: $name, Téléphone: $phone';
  }

  //Setter pour incrémenter/décrémenter le compteur d'emprunts
  set setbCt(int n) {
    if (borrowCount + n >= 0 && borrowCount + n <= 3) {
      borrowCount += n;
    } else {
      print("Le client ne peut pas emprunter plus de trois livres.");
    }
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
  static Client? getClientById(int id) {
    for (Client client in clientsList) {
      if (client.id == id) {
        return client; // Renvois le client
      }
    }
    return null; // Renvoie null en si le client n'est pas trouvé
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
  static void displayBorrows() {
    if (borrowsList.isEmpty) {
      print("Aucun livre n'a encore été emprunté.");
    } else {
      print("Liste des livres enregistrés :");
      for (var borrow in borrowsList) {
        print(borrow.show);
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
    if (phone != null) {
      Client(cCounter, name, 0, phone);
      print("Le client a bien été enregistré.");
    }
  }
  cCounter++;
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
        if (qty != null) {
          Book(bookCounter, name, author, category, true, qty);
          print("Le livre a bien été enregistré.");
        }
      }
    }
  }
  bookCounter++;
}

//Fonction pour l'emprunt d'un livre
void recordBorrow() {
  print("Donner l'identifiant du client");
  String? idClient = stdin.readLineSync();
  int? clientId = int.tryParse(idClient ?? "0");

  if (clientId != null) {
    print("Donner l'identifiant du livre");
    String? idBook = stdin.readLineSync();
    int? bookId = int.tryParse(idBook ?? "0");
    if (bookId != null) {
      Client? client = Client.getClientById(clientId);
      Book? book = Book.getbookById(bookId);
      if (client != null && book != null) {
        book.setQty = -1;
        client.setbCt = 1;
        Borrows(bCounter, book, client, DateTime.now());
        bCounter++;
        print("Emprunt de livre enregistré.");
      }
    } else {
      print("Il y'a erreur dans votre saisie. Veillez recommencer.");
    }
  } else {
    print("Il y'a erreur dans votre saisie. Veillez recommencer.");
  }
}

//Fonction pour la remise d'un livre
void recordReturn() {
  print("Donner l'identifiant du client");
  String? idClient = stdin.readLineSync();
  int? clientId = int.tryParse(idClient ?? "0");

  if (clientId != null) {
    print("Donner l'identifiant du livre");
    String? idBook = stdin.readLineSync();
    int? bookId = int.tryParse(idBook ?? "0");
    if (bookId != null) {
      Client? client = Client.getClientById(clientId);
      Book? book = Book.getbookById(bookId);
      if (client != null && book != null) {
        book.setQty = 1;
        client.setbCt = -1;
        Returns(bCounter, book, client, DateTime.now());
        print("Remise de livre enregistrée.");
      }
    } else {
      print("Il y'a erreur dans votre saisie. Veillez recommencer.");
    }
  } else {
    print("Il y'a erreur dans votre saisie. Veillez recommencer.");
  }
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

    switch (action) {
      case 1:
        Book.displayBooks();
        break;
      case 2:
        Client.displayClients();
        break;
      case 3:
        Borrows.displayBorrows();
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

  print("Programme terminé. À bientôt !");
}
