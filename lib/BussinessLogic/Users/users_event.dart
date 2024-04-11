import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
}

class FetchUsers extends UserEvent {
  @override
  List<Object> get props => [];
}

class FetchUsersPage extends UserEvent {
  final int page;

  FetchUsersPage(this.page);

  @override
  List<Object> get props => [page];
}

class DeleteUser extends UserEvent {
  final int userId;

  DeleteUser(this.userId);

  @override
  List<Object> get props => [userId];
}
