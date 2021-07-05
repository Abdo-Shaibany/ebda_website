import 'package:flutter/material.dart';
import 'package:website/screens/create_post.dart';
import 'package:website/screens/da_category.dart';
import 'package:website/screens/da_post.dart';
import 'package:website/screens/home.dart';
import 'package:website/screens/html_content_page.dart';
import 'package:website/screens/job_details.dart';
import 'package:website/screens/screens_builder.dart';
import 'package:website/screens/search.dart';
import 'package:website/screens/sign_in.dart';
import 'package:website/screens/splash.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic args = settings.arguments;
    switch (settings.name) {
      case '/':
        if (args != null)
          return MaterialPageRoute(
              builder: (context) => Home(
                    initPageIndex: args[0],
                  ));
        return MaterialPageRoute(builder: (context) => Home());

      case '/splash':
        return MaterialPageRoute(builder: (context) => Spalsh());
      case '/search':
        return MaterialPageRoute(builder: (context) => SearchSreen());
      case '/browser':
        return MaterialPageRoute(
            builder: (context) => ScreensBuilder.categories());
      case '/sign_in':
        return MaterialPageRoute(builder: (context) => SignIn());
      case '/my_articals':
        return MaterialPageRoute(
            builder: (context) => ScreensBuilder.myArticals(context));
      case '/create_post':
        return MaterialPageRoute(builder: (context) => CreatePost());
      case '/post':
        return MaterialPageRoute(
            builder: (context) => DaPost(
                  postId: args[0],
                ));
      case '/da_category':
        return MaterialPageRoute(
            builder: (context) => DaCategory(
                  category: args[0],
                ));
      case '/da_html_content':
        return MaterialPageRoute(
            builder: (context) => HtmlContentPage(
                  postId: args[0],
                ));
      case '/job_details':
        return MaterialPageRoute(
            builder: (context) => JobDetails(
                  id: args[0],
                ));
      default:
        return MaterialPageRoute(builder: (context) => Home());
    }
  }
}
