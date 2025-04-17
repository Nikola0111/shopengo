# shopengo

Your designated shopping  buddy

# Specification:
- as a user i want to have a listing of all shopping lists (each shopping list card has a number of items bought/total, color of the category and category name, name of the shopping list)
- as a user i want to see items from my shopping list
- as a user i want to be able to check/uncheck if item i bought
- as a user i want to be presented with finish shopping button where i can enter the total price of all items
- as a user i want to filter my shopping lists based on if they've been finished or not (sort, search)
- as a user i want to add a friend to my shopping list
- as a user i want to have a chronological history of my shoppings and spendings

# Technical

- flutter version: 3.29.3
- localization gen command: dart run easy_localization:generate --source-dir assets/localization && dart run easy_localization:generate -S assets/localization -f keys -o locale_keys.g.dart
- command for codegen: dart run build_runner build --delete-conflicting-outputs
