library datasource;

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:esports_game_endpoint/core/core.dart';
import 'package:esports_game_endpoint/data/model/model.dart';
import 'package:esports_game_endpoint/domain/entity/entity.dart';
import 'package:esports_http_api/esports_http_api.dart';
import 'package:esports_game_endpoint/data/model/model.dart';
import 'package:hive/hive.dart';

part 'url_path.dart';
part 'datasource_box_name.dart';

// remote
part 'remote/lineup_datasource.dart';
part 'remote/game_map_image_datasource.dart';

// local
part 'local/lineup_local_datasource.dart';