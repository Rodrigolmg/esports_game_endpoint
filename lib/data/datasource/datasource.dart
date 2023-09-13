library datasource;

import 'package:esports_game_endpoint/data/model/model.dart';
import 'package:esports_game_endpoint/domain/entity/entity.dart';
import 'package:esports_http_api/esports_http_api.dart';
import 'package:esports_game_endpoint/data/model/model.dart';

part 'url_path.dart';
part 'datasource_box_name.dart';

// remote
part 'remote/lineup_datasource.dart';

// local
part 'local/lineup_local_datasource.dart';