import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PricesModel {
  PricesModel({
    this.exchangeRates,
  });

  List<ExchangeRate> exchangeRates;

  factory PricesModel.fromJson(Map<String, dynamic> json) => PricesModel(
        exchangeRates: List<ExchangeRate>.from(
            json["exchange_rates"].map((x) => ExchangeRate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "exchange_rates":
            List<dynamic>.from(exchangeRates.map((x) => x.toJson())),
      };
}

@JsonSerializable()
class ExchangeRate {
  ExchangeRate({
    this.nameRatesAr,
    this.icon,
    this.id,
    this.buySn,
    this.buyAdn,
    this.saleSn,
    this.saleAdn,
    this.statusExchangeSn,
    this.statusExchangeAdn,
    this.createdAt,
  });

  String nameRatesAr;
  String icon;
  String id;
  String buySn;
  String buyAdn;
  String saleSn;
  String saleAdn;
  String statusExchangeSn;
  String statusExchangeAdn;
  DateTime createdAt;

  factory ExchangeRate.fromJson(Map<String, dynamic> json) => ExchangeRate(
        nameRatesAr: json["name_rates_ar"],
        icon: json["icon"],
        id: json["id"],
        buySn: json["buy_sn"],
        buyAdn: json["buy_adn"],
        saleSn: json["sale_sn"],
        saleAdn: json["sale_adn"],
        statusExchangeSn: json["status_exchange_sn"],
        statusExchangeAdn: json["status_exchange_adn"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "name_rates_ar": nameRatesAr,
        "icon": icon,
        "id": id,
        "buy_sn": buySn,
        "buy_adn": buyAdn,
        "sale_sn": saleSn,
        "sale_adn": saleAdn,
        "status_exchange_sn": statusExchangeSn,
        "status_exchange_adn": statusExchangeAdn,
        "created_at": createdAt.toIso8601String(),
      };
}
