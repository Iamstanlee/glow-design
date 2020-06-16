class Book {
  String title, schClass, author, category, id, url;
  double rating;
  int price;
  int pageCount;
  Book(
      {this.title,
      this.author,
      this.id,
      this.url,
      this.rating,
      this.pageCount});

  Book.fromMap(Map map) {
    this.title = map['title'];
    this.author = map['author'];
    this.price = map['price'];
    this.schClass = map['class'];
    this.category = map['category'];
    this.id = map['_id'];
    this.url = map['bookUrl'];
  }
  static Map<String, dynamic> toMap(Book book) {
    return {
      'title': book.title,
      '_id': book.id,
      'author': book.author,
      'category': book.category,
      'price': book.price,
      'class': book.schClass
    };
  }
}
