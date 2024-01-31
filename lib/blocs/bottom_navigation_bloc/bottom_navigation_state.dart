import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BottomNavigationState extends Equatable {
  final ThemeData themeData;

  const BottomNavigationState({required this.themeData});

  @override
  List<Object> get props => [];
}

class BottomNavigationInitial extends BottomNavigationState {
  const BottomNavigationInitial({required super.themeData});

  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}

class ThemeRebuilt extends BottomNavigationState {
  const ThemeRebuilt({required super.themeData});

  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}
