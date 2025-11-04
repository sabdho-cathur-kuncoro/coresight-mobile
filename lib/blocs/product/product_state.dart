part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductFailed extends ProductState {
  final String e;
  const ProductFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class ProductLoaded extends ProductState {
  final List<ProductModel> data;
  const ProductLoaded(this.data);

  @override
  List<Object> get props => [data];
}
