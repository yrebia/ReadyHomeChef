
class Recipe {
  final String recipeName;
  final String description;
  final String imageUrl; // Nouveau champ pour l'URL de l'image

  Recipe(this.recipeName, this.description, this.imageUrl);
}


// Créez une liste de résultats de recherche (exemple)
List<Recipe> searchResults = [
  Recipe('Pizza', 'Description de la recette 1', 'lib/img/burger.jpg'),
  Recipe('Burger', 'Description de la recette 2', 'lib/img/cat.jpg'),
  // Ajoutez d'autres recettes avec des URL d'images
];

