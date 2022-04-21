import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/models/article_model.dart';
import 'package:scanner_app/models/models.dart';
import 'package:scanner_app/providers/providers.dart';
import 'package:scanner_app/services/services.dart';
import 'package:scanner_app/shared/shared.dart';
import 'package:scanner_app/ui/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'main_page.dart';
part 'dahsboard_page.dart';
part 'document_detail_page.dart';
part 'document_page.dart';
part 'documents_page.dart';
part 'sign_in_page.dart';
part 'sign_up_page.dart';
part 'start_page.dart';
part 'article_detail_page.dart';
