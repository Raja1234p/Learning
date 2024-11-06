part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}
class AuthenticateEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];  // No additional properties for AuthenticateEvent
}