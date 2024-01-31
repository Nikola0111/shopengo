import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List get props => [];
}

class BottomNavigationInitial extends BottomNavigationState {
  const BottomNavigationInitial();

  @override
  List get props => [];

  @override
  bool? get stringify => false;
}

class ThemeRebuilt extends BottomNavigationState {
  final ThemeData themeData;
  const ThemeRebuilt({required this.themeData});

  @override
  List get props => [themeData];

  @override
  bool? get stringify => false;
}
