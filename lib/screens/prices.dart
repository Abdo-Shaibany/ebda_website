import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/bloc/bloc_bloc.dart';
import 'package:website/components/setion_topper.dart';
import 'package:website/helpers/data.dart';
import 'package:website/helpers/pages_ids.dart';
import 'package:website/models/prices_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

class PricesScreen extends StatefulWidget {
  const PricesScreen({Key key}) : super(key: key);

  @override
  _PricesScreenState createState() => _PricesScreenState();
}

class _PricesScreenState extends State<PricesScreen> {
  PageId _pageId;
  // int _currentIndex;
  DataCenter _data;
  PricesModel _prices;
  BlocBloc _bloc;
  List<String> _places;
  int _currentPlace;

  @override
  void initState() {
    super.initState();
    _pageId = PageId.Prices;
    _data = DataCenter.instance;
    _bloc = BlocBloc();
    _places = ['SANA\'A'.tr(), 'ADEN'.tr()];
    _currentPlace = 0;
    _prices = PricesModel(exchangeRates: []);
    _handleRequestData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SetionTopper(title: "PRICES".tr()),
        Expanded(
            child: BlocListener(
          bloc: _bloc,
          listener: (context, state) {
            if (state is Ok && state.pageId == _pageId)
              setState(() {
                _prices = _data.prices;
              });
          },
          child: BlocBuilder(
              bloc: _bloc,
              builder: (context, state) {
                if (state is Loading && state.pageId == _pageId)
                  return _loading();
                if (state is Error && state.pageId == _pageId) return _error();
                if (state is Ok &&
                    state.pageId == _pageId &&
                    _prices.exchangeRates.length > 0)
                  return ListView(
                    children: [
                      Padding(padding: EdgeInsets.all(16.0)),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: _places
                              .asMap()
                              .entries
                              .map(
                                (e) => GestureDetector(
                                  onTap: () => setState(() {
                                    _currentPlace = e.key;
                                  }),
                                  child: Text(
                                    e.value,
                                    style: TextStyle(
                                      fontFamily: 'din_next',
                                      fontSize: 22,
                                      color: e.value == _places[_currentPlace]
                                          ? Color(0xff20657d)
                                          : Colors.grey,
                                      fontWeight: FontWeight.w700,
                                      decoration:
                                          e.value == _places[_currentPlace]
                                              ? TextDecoration.underline
                                              : TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              )
                              .toList()),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _pricesWidget(
                            _places[_currentPlace].tr(), _currentPlace),
                      ),
                      GestureDetector(
                        onTap: _handleRequestData,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'refresh'.tr(),
                              style: TextStyle(
                                fontFamily: 'din_next',
                                fontSize: 22,
                                color: Color(0xff20657d),
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                return _noData();
              }),
        )),
      ],
    );
  }

  Widget _noData() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'لا يوجد بيانات لعرضها',
            style: TextStyle(
              fontFamily: 'din_next',
              fontSize: 25,
              color: const Color(0xff20657d),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
          Padding(padding: EdgeInsets.all(12.0)),
          GestureDetector(
            onTap: _handleRequestData,
            child: Text(
              'اضغط هنا للتحديث',
              style: TextStyle(
                fontFamily: 'din_next',
                fontSize: 15,
                color: const Color(0xff20657d),
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _error() {
    return Align(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            color: Colors.redAccent,
          ),
          height: 50,
          child: Row(children: [
            Padding(padding: EdgeInsets.only(right: 4.0, left: 4.0)),
            Text(
              "Internet is slow or unavaiable".tr(),
              style: TextStyle(
                fontFamily: 'din_next',
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: _handleRequestData,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: Text(
                  "press to refresh".tr(),
                  style: TextStyle(
                    fontFamily: 'din_next',
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 4.0, left: 4.0)),
          ]),
        ),
      ),
      alignment: Alignment.bottomCenter,
    );
  }

  Widget _pricesWidget(title, city) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(4.0)),
        Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(4.0)),
                _titleRow(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _prices.exchangeRates
                        .map((e) => _currencyRow(e))
                        .toList(),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Widget _currencyRow(ExchangeRate price) {
    Color color = Color(0xff20657d);
    int status = _currentPlace == 0
        ? int.parse(price.statusExchangeSn)
        : int.parse(price.statusExchangeAdn);

    String buy = _currentPlace == 0 ? price.buySn : price.buyAdn;

    String sale = _currentPlace == 0 ? price.saleSn : price.saleAdn;

    String assestPath = 'arrow_up';
    if (status == 0) assestPath = 'dash';
    if (status == -1) assestPath = 'arrow_down';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: const Color(0xffffffff),
        border: Border.all(width: 1.0, color: const Color(0xff20657d)),
      ),
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl:
                      "https://www.ri-bu.com/upload/icon_rate/${price.icon}",
                  height: 15,
                  width: 25,
                ),
                _text(price.nameRatesAr, color),
              ],
            ),
          ),
          Expanded(
              child: _text(
            buy,
            color,
          )),
          Expanded(
              child: _text(
            sale,
            color,
          )),
          Expanded(
              child: Center(
            child: SvgPicture.asset("assets/icons/$assestPath.svg"),
          )),
        ],
      ),
    );
  }

  Widget _titleRow() {
    Color color = const Color(0xffe0ae4b);
    return Row(
      children: [
        Expanded(
          child: _text('Currency'.tr(), color),
          flex: 2,
        ),
        Expanded(child: _text('buy'.tr(), color)),
        Expanded(child: _text('sell'.tr(), color)),
        Expanded(child: _text('status'.tr(), color)),
      ],
    );
  }

  Widget _text(value, color) {
    return Text(
      value,
      style: TextStyle(
        fontFamily: 'din_next',
        fontSize: 15,
        color: color,
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.center,
    );
  }

  _handleRequestData() {
    _bloc.add(GetPrices());
  }
}
