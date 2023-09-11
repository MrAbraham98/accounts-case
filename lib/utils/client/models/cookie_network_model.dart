abstract class BaseNetworkModel<T> {
  const BaseNetworkModel();

  T fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}
