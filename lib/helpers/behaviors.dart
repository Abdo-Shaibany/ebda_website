import 'package:dio/dio.dart';
import 'package:website/helpers/db_helper.dart';
import 'package:website/helpers/network_builder.dart';
import 'package:website/models/categories_model.dart';
import 'package:website/models/jobs_model.dart';
import 'package:website/models/jobs_model.dart' as jobsClass;
import 'package:website/models/journals_model.dart';
import 'package:website/models/journals_model.dart' as journalsClass;
import 'package:website/models/posts_model.dart';
import 'package:website/models/prices_model.dart';
import 'package:connectivity/connectivity.dart';

class Behaviors {
  static final client = NetworkBuilder(
    Dio(
      BaseOptions(
        contentType: "application/json",
        headers: {"accept": "application/json"},
        followRedirects: false,
      ),
    ),
  );

  static Future<MainPosts> getPosts(page) async {
    bool isConnected = await checkInternt();
    if (isConnected) {
      try {
        MainPosts posts = await client.getPosts(page);
        DatabaseHelper.instance.insertBlogPosts(posts);
        return posts;
      } catch (e) {
        throw e;
      }
    } else {
      List<Post> posts =
          await DatabaseHelper.instance.readBlogPosts((page - 1) * 10);
      int total = await DatabaseHelper.instance.total(DatabaseSchema.blogTable);
      return MainPosts(
          posts: Posts(data: posts, total: total, lastPage: total ~/ 10));
    }
  }

  static Future<MainJobs> getJobs(page) async {
    bool isConnected = await checkInternt();
    if (isConnected) {
      try {
        MainJobs jobs = await client.getJobs(page);
        DatabaseHelper.instance.insertJobs(jobs);
        return jobs;
      } catch (e) {
        throw e;
      }
    } else {
      List<Job> jobs = await DatabaseHelper.instance.readJobs((page - 1) * 10);
      int total = await DatabaseHelper.instance.total(DatabaseSchema.jobsTable);
      return MainJobs(
        data: jobsClass.Data(
          currentPage: page,
          data: jobs,
          total: total,
          lastPage: total ~/ 10,
        ),
      );
    }
  }

  static Future<MainJournals> getJournals(page) async {
    bool isConnected = await checkInternt();
    if (isConnected) {
      try {
        MainJournals jobs = await client.getJournal(page);
        DatabaseHelper.instance.insertJournals(jobs);
        return jobs;
      } catch (e) {
        throw e;
      }
    } else {
      List<Journal> jobs =
          await DatabaseHelper.instance.readJournals((page - 1) * 10);
      int total =
          await DatabaseHelper.instance.total(DatabaseSchema.journalsTable);
      return MainJournals(
        data: journalsClass.Data(
          currentPage: page,
          data: jobs,
          total: total,
          lastPage: total ~/ 10,
        ),
      );
    }
  }

  static Future<Categories> getCategories() async {
    bool isConnected = await checkInternt();
    if (isConnected) {
      try {
        Categories categories = await client.getCategories();
        DatabaseHelper.instance.insertCategories(categories);
        return categories;
      } catch (e) {
        throw e;
      }
    } else {
      List<Category> jobs = await DatabaseHelper.instance.readCategories();
      return Categories(categories: jobs);
    }
  }

  static Future<PricesModel> getPrices() async {
    bool isConnected = await checkInternt();
    if (isConnected) {
      try {
        PricesModel prices = await client.getPrices();
        updatePrices(prices);
        return prices;
      } catch (e) {
        throw e;
      }
    } else {
      PricesModel prices = await DatabaseHelper.instance.readPrices();
      return prices;
    }
  }

  static Future<void> updatePrices(PricesModel model) async {
    await DatabaseHelper.instance.deletePrices();
    await DatabaseHelper.instance.insertPrices(model);
  }

  static Future<bool> checkInternt() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }

    return false;
  }
}
