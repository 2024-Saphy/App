import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

Future<Map<String, String>> searchAdress(
    BuildContext context, Logger logger) async {
  Map<String, String> formData = {};

  KopoModel kopoModel = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RemediKopo(),
    ),
  );

  logger.i(
    '${kopoModel.zonecode} / ${kopoModel.address} / ${kopoModel.buildingName}',
  );

  final postcode = kopoModel.zonecode ?? '';
  formData['postcode'] = postcode;

  final address = kopoModel.address ?? '';
  formData['address'] = address;

  final buildingName = kopoModel.buildingName ?? '';
  formData['address_detail'] = buildingName;

  return formData;
}
