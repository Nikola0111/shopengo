import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopengo/feature/category/presentation/add_category_sheet.dart';
import 'package:shopengo/feature/shopping/domain/cubit/shopping_bloc.dart';
import 'package:shopengo/feature/shopping/domain/cubit/shopping_event.dart';

/// Opens the new category sheet and returns the created category's id, or null if the sheet was dismissed.
Future<int?> createCategory(BuildContext context) async {
  final bloc = context.read<ShoppingBloc>();
  final category = await AddCategorySheet.show(context);
  if (category == null) {
    return null;
  }

  final existingIds = bloc.state.categories.map((e) => e.id).toSet();
  bloc.add(ShoppingCreateCategoryEvent(title: category.title, color: category.color));
  final state = await bloc.stream.firstWhere((state) => state.categories.any((e) => !existingIds.contains(e.id)));
  return state.categories.firstWhere((e) => !existingIds.contains(e.id)).id;
}
