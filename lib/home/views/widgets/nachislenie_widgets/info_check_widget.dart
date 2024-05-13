import 'package:flutter/material.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/home/models/api_models/check_info_model.dart';

class InfoCheckWidget extends StatefulWidget {
  final CheckInfoModel checkInfoModel;

  const InfoCheckWidget({Key key, this.checkInfoModel}) : super(key: key);

  @override
  State<InfoCheckWidget> createState() => _InfoCheckWidgetState();
}

class _InfoCheckWidgetState extends State<InfoCheckWidget> {
  int goodsCunt = 1;

  int getGoodsNum() {
    return goodsCunt++;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: widget.checkInfoModel.data == null
          ? const Center(
              child: CommonTextWidget(
                text: 'Чек отсутствует',
                size: 18,
                color: Colors.red,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CommonTextWidget(
                    text:
                        'Чек № ${widget.checkInfoModel.data.id.toString() ?? ''}',
                    size: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff49536D),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: StatusWidget(
                    status: widget.checkInfoModel.data.status,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: CommonTextWidget(
                    text: widget.checkInfoModel.data.createdAt
                        .toString()
                        .substring(0, 10),
                    size: 16,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xff8793B4),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (widget.checkInfoModel.data.status != 'success')
                  Center(
                    child: CommonTextWidget(
                      text: widget.checkInfoModel.data.comment.toString(),
                      size: 20,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff49536D),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                if (widget.checkInfoModel.data.description != null)
                  Center(
                    child: CommonTextWidget(
                      text: widget.checkInfoModel.data.description.toString(),
                      size: 18,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xff8793B4),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (widget.checkInfoModel.data.status != 'success')
                  const SizedBox(
                    height: 30,
                  ),
                if (widget.checkInfoModel.data.status == 'success' ||
                    (widget.checkInfoModel.data.status == 'rejected' &&
                        widget.checkInfoModel.data.goods.isNotEmpty))
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: CommonTextWidget(
                                  text: widget.checkInfoModel.data.marketName ??
                                      '',
                                  size: 14,
                                  color: const Color(0xff8793B4),
                                ),
                                width: MediaQuery.of(context).size.width * 0.6,
                              ),
                              CommonTextWidget(
                                text: widget.checkInfoModel.data.inn ?? '',
                                size: 14,
                                color: const Color(0xff8793B4),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CommonTextWidget(
                                text: 'Дата и время',
                                size: 14,
                                color: Color(0xff8793B4),
                              ),
                              Row(
                                children: [
                                  CommonTextWidget(
                                    text: widget.checkInfoModel.data.boughtAt
                                            .substring(0, 10) ??
                                        '',
                                    size: 14,
                                    color: const Color(0xff8793B4),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CommonTextWidget(
                                    text: widget.checkInfoModel.data.boughtAt
                                            .substring(11, 16) ??
                                        '',
                                    size: 14,
                                    color: const Color(0xff8793B4),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CommonTextWidget(
                                text: 'Чек',
                                size: 14,
                                color: Color(0xff8793B4),
                              ),
                              CommonTextWidget(
                                text: widget.checkInfoModel.data.userCheckNum
                                        .toString() ??
                                    '',
                                size: 14,
                                color: const Color(0xff8793B4),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CommonTextWidget(
                                text: 'Смена',
                                size: 14,
                                color: Color(0xff8793B4),
                              ),
                              CommonTextWidget(
                                text: widget.checkInfoModel.data.shiftNumber
                                        .toString() ??
                                    '',
                                size: 14,
                                color: const Color(0xff8793B4),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const CommonTextWidget(
                                text: 'Кассир',
                                size: 14,
                                color: Color(0xff8793B4),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: CommonTextWidget(
                                  textAlign: TextAlign.end,
                                  text:
                                      widget.checkInfoModel.data.operator ?? '',
                                  size: 14,
                                  color: const Color(0xff8793B4),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 20),
                            child: Row(
                              children: List.generate(
                                150 ~/ 2,
                                (index) => Expanded(
                                  child: Container(
                                    color: index % 2 == 0
                                        ? Colors.transparent
                                        : Colors.grey,
                                    height: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (widget.checkInfoModel.data.goods.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CommonTextWidget(
                                  text: 'Приход',
                                  fontWeight: FontWeight.w700,
                                  size: 18,
                                  color: Color(0xff49536D),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                buildTable(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 20),
                                  child: Row(
                                    children: List.generate(
                                      150 ~/ 2,
                                      (index) => Expanded(
                                        child: Container(
                                          color: index % 2 == 0
                                              ? Colors.transparent
                                              : Colors.grey,
                                          height: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const CommonTextWidget(
                                          text: 'Итого',
                                          size: 14,
                                          color: Color(0xff8793B4),
                                          fontWeight: FontWeight.normal,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.10),
                                              child: CommonTextWidget(
                                                text: widget.checkInfoModel.data
                                                        .amountTotal ??
                                                    '',
                                                fontWeight: FontWeight.normal,
                                                size: 14,
                                                color: const Color(0xff49536D),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05),
                                              child: CommonTextWidget(
                                                text: widget.checkInfoModel.data
                                                            .cashBack ==
                                                        'null'
                                                    ? '-'
                                                    : widget.checkInfoModel.data
                                                        .cashBack,
                                                fontWeight: FontWeight.w700,
                                                size: 14,
                                                color: const Color(0xff49536D),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }

  Table buildTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(10),
        1: FlexColumnWidth(40),
        2: FlexColumnWidth(20),
        3: FlexColumnWidth(15),
        4: FlexColumnWidth(20),
        5: FlexColumnWidth(20),
        6: FlexColumnWidth(30),
      },
      children: [
        const TableRow(children: [
          CommonTextWidget(
            textAlign: TextAlign.center,
            text: '№',
            size: 14,
            color: Color(0xff8793B4),
            fontWeight: FontWeight.normal,
          ),
          CommonTextWidget(
            textAlign: TextAlign.center,
            text: 'Назван.',
            size: 14,
            color: Color(0xff8793B4),
            fontWeight: FontWeight.normal,
          ),
          CommonTextWidget(
            textAlign: TextAlign.center,
            text: 'Цена',
            size: 14,
            color: Color(0xff8793B4),
            fontWeight: FontWeight.normal,
          ),
          CommonTextWidget(
            textAlign: TextAlign.center,
            text: 'Кол.',
            size: 14,
            color: Color(0xff8793B4),
            fontWeight: FontWeight.normal,
          ),
          CommonTextWidget(
            textAlign: TextAlign.center,
            text: 'Сумма',
            size: 14,
            color: Color(0xff8793B4),
            fontWeight: FontWeight.normal,
          ),
          CommonTextWidget(
            textAlign: TextAlign.center,
            text: '%',
            size: 14,
            color: Color(0xff8793B4),
            fontWeight: FontWeight.normal,
          ),
          CommonTextWidget(
            textAlign: TextAlign.center,
            text: 'Результ.',
            size: 14,
            color: Color(0xff8793B4),
            fontWeight: FontWeight.normal,
          ),
        ]),
        ...widget.checkInfoModel.data.goods
            .map(
              (e) => TableRow(
                children: [
                  CommonTextWidget(
                    textAlign: TextAlign.center,
                    text: getGoodsNum().toString(),
                    size: 14,
                    color: const Color(0xff8793B4),
                    fontWeight: FontWeight.normal,
                  ),
                  CommonTextWidget(
                    text: e.name,
                    size: 14,
                    color: const Color(0xff8793B4),
                    fontWeight: FontWeight.normal,
                  ),
                  CommonTextWidget(
                    textAlign: TextAlign.center,
                    text: e.price.toString(),
                    size: 14,
                    color: const Color(0xff8793B4),
                    fontWeight: FontWeight.normal,
                  ),
                  CommonTextWidget(
                    textAlign: TextAlign.center,
                    text: e.quantity.toString(),
                    size: 14,
                    color: const Color(0xff8793B4),
                    fontWeight: FontWeight.normal,
                  ),
                  CommonTextWidget(
                    textAlign: TextAlign.center,
                    text: e.sum.toString(),
                    size: 14,
                    color: const Color(0xff8793B4),
                    fontWeight: FontWeight.normal,
                  ),
                  CommonTextWidget(
                    textAlign: TextAlign.center,
                    text: e.amount.toString() ?? '-',
                    size: 14,
                    color: const Color(0xff8793B4),
                    fontWeight: FontWeight.normal,
                  ),
                  CommonTextWidget(
                    textAlign: TextAlign.center,
                    text: e.calculateCashback.toString() == 'null'
                        ? '-'
                        : e.calculateCashback.toString(),
                    size: 14,
                    color: const Color(0xff8793B4),
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),
            )
            .toList()
      ],
    );
  }
}

class StatusWidget extends StatelessWidget {
  final String status;

  const StatusWidget({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: status == 'success' || status == 'accepted'
            ? const Color(0xff13971E)
            : status == 'verification'
                ? const Color(0xff292C31)
                : const Color(0xffB51919),
      ),
      width: 140,
      height: 40,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: status == 'success' || status == 'accepted'
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      )
                    : status == 'verification'
                        ? const Icon(
                            Icons.access_time_outlined,
                            color: Color(0xff8793B4),
                          )
                        : const Icon(
                            Icons.cancel,
                            color: Colors.white,
                          ),
              ),
              const SizedBox(
                width: 5,
              ),
              CommonTextWidget(
                text: status == 'success' || status == 'accepted'
                    ? 'Успешно'
                    : status == 'verification'
                        ? 'На проверке'
                        : 'Отказ',
                size: 14,
                color: status == 'verification'
                    ? const Color(0xff8793B4)
                    : Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
