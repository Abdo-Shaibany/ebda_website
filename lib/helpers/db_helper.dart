import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:website/models/categories_model.dart';
import 'package:website/models/jobs_model.dart';
import 'package:website/models/journals_model.dart';
import 'package:website/models/posts_model.dart';
import 'package:website/models/prices_model.dart';

class DatabaseSchema {
  // db
  static final databaseName = "ebda.db";
  static final databaseVersion = 1;

  // tables
  static final String pricesTable = 'prices';

  static final String nameRatesAr = 'name_rates_ar';
  static final String icon = 'icon';
  static final String id = 'id';
  static final String buySn = 'buy_sn';
  static final String buyAdn = 'buy_adn';
  static final String saleSn = 'sale_sn';
  static final String saleAdn = 'sale_adn';
  static final String statusExchangeSn = 'status_exchange_sn';
  static final String statusExchangeAdn = 'status_exchange_adn';
  static final String createdAt = 'created_at';

  // tables
  static final String blogTable = 'blog';

  static final String postId = 'id';
  static final String postDateAr = 'post_date_ar';
  static final String postDateEn = 'post_date_en';
  static final String postTitleAr = 'post_title_ar';
  static final String postTitleEn = 'post_title_en';
  static final String shortPostDetailsAr = 'short_post_details_ar';
  static final String shortPostDetailsEn = 'short_post_details_en';
  static final String inNews = 'in_news';
  static final String featuredImageAr = 'featured_image_ar';
  static final String featuredImageEn = 'featured_image_en';
  static final String publicationStatusAr = 'publication_status_ar';
  static final String publicationStatusEn = 'publication_status_en';
  static final String viewCountAr = 'view_count_ar';
  static final String viewCountEn = 'view_count_en';
  static final String postCreatedAt = 'created_at';
  static final String updatedAt = 'updated_at';

  // tables
  static final String jobsTable = 'jobs';

  static final String jobId = 'id';
  static final String jobTitle = 'job_title';
  static final String jobCreatedAt = 'created_at';
  static final String jobCity = 'job_city';
  static final String jobShortDesc = 'job_short_desc';
  static final String jobDeadlineDate = 'job_deadline_date';
  static final String nameCompany = 'name_company';

  // tables
  static final String journalsTable = 'journals';

  static final String journalId = 'id';
  static final String lang = 'lang';
  static final String pageName = 'page_name';
  static final String pageFeaturedImage = 'page_featured_image';
  static final String publicationStatus = 'publication_status';
  static final String journalCreatedAt = 'created_at';
  static final String journalUpdatedAt = 'updated_at';
  static final String verNumber = 'ver_number';
  static final String viewCount = 'view_count';
  static final String downloadCount = 'download_count';
  static final String verDate = 'ver_date';
  static final String pdfFile = 'pdf_file';
  static final String fullImageUrl = 'full_image_url';
  static final String fullPdfUrl = 'full_pdf_url';

  // tables
  static final String categoriesTable = 'category';

  static final String categoryId = 'id';
  static final String adminId = 'admin_id';
  static final String parentId = 'parent_id';
  static final String categoryNameAr = 'category_name_ar';
  static final String categoryNameEn = 'category_name_en';
  static final String categorySlugAr = 'category_slug_ar';
  static final String categorySlugEn = 'category_slug_en';
  static final String sorting = 'sorting';
  static final String metaTitleAr = 'meta_title_ar';
  static final String metaTitleEn = 'meta_title_en';
  static final String metaKeywordsAr = 'meta_keywords_ar';
  static final String metaKeywordsEn = 'meta_keywords_en';
  static final String metaDescriptionAr = 'meta_description_ar';
  static final String metaDescriptionEn = 'meta_description_en';
  static final String categoryPublicationStatusAr = 'publication_status_ar';
  static final String categoryPublicationStatusEn = 'publication_status_en';
  static final String categoryCreatedAt = 'created_at';
  static final String categoryUpdatedAt = 'updated_at';
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DatabaseSchema.databaseName);
    return await openDatabase(path,
        version: DatabaseSchema.databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // create tasks
    await db.execute('''
          CREATE TABLE ${DatabaseSchema.pricesTable} (
            ${DatabaseSchema.id} TEXT PRIMARY KEY,
            ${DatabaseSchema.icon} TEXT,
            ${DatabaseSchema.nameRatesAr} TEXT,
            ${DatabaseSchema.buySn} TEXT,
            ${DatabaseSchema.buyAdn} TEXT,
            ${DatabaseSchema.saleSn} TEXT,
            ${DatabaseSchema.saleAdn} TEXT,
            ${DatabaseSchema.statusExchangeSn} TEXT,
            ${DatabaseSchema.statusExchangeAdn} TEXT,
            ${DatabaseSchema.createdAt} TEXT
          )
          ''');

    await db.execute('''
          CREATE TABLE ${DatabaseSchema.blogTable} (
            ${DatabaseSchema.postId} TEXT PRIMARY KEY,
            ${DatabaseSchema.postDateAr} TEXT,
            ${DatabaseSchema.postDateEn} TEXT,
            ${DatabaseSchema.postTitleAr} TEXT,
            ${DatabaseSchema.postTitleEn} TEXT,
            ${DatabaseSchema.shortPostDetailsAr} TEXT,
            ${DatabaseSchema.shortPostDetailsEn} TEXT,
            ${DatabaseSchema.inNews} TEXT,
            ${DatabaseSchema.featuredImageAr} TEXT,
            ${DatabaseSchema.featuredImageEn} TEXT,
            ${DatabaseSchema.publicationStatusAr} TEXT,
            ${DatabaseSchema.publicationStatusEn} TEXT,
            ${DatabaseSchema.viewCountAr} TEXT,
            ${DatabaseSchema.viewCountEn} TEXT,
            ${DatabaseSchema.postCreatedAt} TEXT,
            ${DatabaseSchema.updatedAt} TEXT
          )
          ''');

    await db.execute('''
          CREATE TABLE ${DatabaseSchema.jobsTable} (
            ${DatabaseSchema.jobId} TEXT PRIMARY KEY,
            ${DatabaseSchema.jobTitle} TEXT,
            ${DatabaseSchema.jobCreatedAt} TEXT,
            ${DatabaseSchema.jobCity} TEXT,
            ${DatabaseSchema.jobShortDesc} TEXT,
            ${DatabaseSchema.jobDeadlineDate} TEXT,
            ${DatabaseSchema.nameCompany} TEXT
          )
          ''');

    await db.execute('''
          CREATE TABLE ${DatabaseSchema.journalsTable} (
            ${DatabaseSchema.journalId} TEXT PRIMARY KEY,
            ${DatabaseSchema.lang} TEXT,
            ${DatabaseSchema.pageName} TEXT,
            ${DatabaseSchema.pageFeaturedImage} TEXT,
            ${DatabaseSchema.publicationStatus} TEXT,
            ${DatabaseSchema.journalCreatedAt} TEXT,
            ${DatabaseSchema.journalUpdatedAt} TEXT,
            ${DatabaseSchema.verNumber} TEXT,
            ${DatabaseSchema.viewCount} TEXT,
            ${DatabaseSchema.downloadCount} TEXT,
            ${DatabaseSchema.verDate} TEXT,
            ${DatabaseSchema.pdfFile} TEXT,
            ${DatabaseSchema.fullImageUrl} TEXT,
            ${DatabaseSchema.fullPdfUrl} TEXT 
          )
          ''');

    await db.execute('''
          CREATE TABLE ${DatabaseSchema.categoriesTable} (
            ${DatabaseSchema.categoryId} TEXT PRIMARY KEY,
            ${DatabaseSchema.adminId} TEXT,
            ${DatabaseSchema.parentId} TEXT,
            ${DatabaseSchema.categoryNameAr} TEXT,
            ${DatabaseSchema.categoryNameEn} TEXT,
            ${DatabaseSchema.categorySlugAr} TEXT,
            ${DatabaseSchema.categorySlugEn} TEXT,
            ${DatabaseSchema.sorting} TEXT,
            ${DatabaseSchema.metaTitleAr} TEXT,
            ${DatabaseSchema.metaTitleEn} TEXT,
            ${DatabaseSchema.metaKeywordsAr} TEXT,
            ${DatabaseSchema.metaKeywordsEn} TEXT,
            ${DatabaseSchema.metaDescriptionAr} TEXT,
            ${DatabaseSchema.metaDescriptionEn} TEXT,
            ${DatabaseSchema.categoryPublicationStatusAr} TEXT,
            ${DatabaseSchema.categoryPublicationStatusEn} TEXT,
            ${DatabaseSchema.categoryCreatedAt} TEXT,
            ${DatabaseSchema.categoryUpdatedAt} TEXT
          )
          ''');
  }

  Future<void> insertPrices(PricesModel prices) async {
    Database db = await instance.database;
    Batch batch = db.batch();
    prices.exchangeRates.forEach((element) {
      batch.insert(DatabaseSchema.pricesTable, element.toJson());
    });
    await batch.commit();
  }

  Future<PricesModel> readPrices() async {
    Database db = await instance.database;
    final respose = await db.query(DatabaseSchema.pricesTable);

    List<ExchangeRate> result = [];
    respose.forEach((element) {
      result.add(ExchangeRate.fromJson(element));
    });

    return PricesModel(exchangeRates: result);
  }

  Future<int> deletePrices() async {
    Database db = await instance.database;
    final result = await db.delete(DatabaseSchema.pricesTable);
    return result;
  }

  Future<void> insertBlogPosts(MainPosts posts) async {
    Database db = await instance.database;
    Batch batch = db.batch();
    posts.posts.data.forEach((element) async {
      batch.insert(DatabaseSchema.blogTable, element.toJson());
    });
    await batch.commit();
  }

  Future<List<Post>> readBlogPosts(offset) async {
    Database db = await instance.database;
    final respose = await db.query(
      DatabaseSchema.blogTable,
      limit: 10,
      offset: offset,
    );

    List<Post> result = [];
    respose.forEach((element) {
      result.add(Post.fromJson(element));
    });

    return result;
  }

  Future<int> total(table) async {
    Database db = await instance.database;
    int count =
        Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));

    return count;
  }

  Future<int> deleteBlogPosts() async {
    Database db = await instance.database;
    final result = await db.delete(DatabaseSchema.blogTable);
    return result;
  }

  Future<void> insertJobs(MainJobs jobs) async {
    Database db = await instance.database;
    Batch batch = db.batch();
    jobs.data.data.forEach((element) {
      batch.insert(DatabaseSchema.jobsTable, element.toJson());
    });
    await batch.commit();
  }

  Future<List<Job>> readJobs(offset) async {
    Database db = await instance.database;
    final respose = await db.query(
      DatabaseSchema.jobsTable,
      limit: 10,
      offset: offset,
    );

    List<Job> result = [];
    respose.forEach((element) {
      result.add(Job.fromJson(element));
    });

    return result;
  }

  Future<int> deleteJobs() async {
    Database db = await instance.database;
    final result = await db.delete(DatabaseSchema.jobsTable);
    return result;
  }

  Future<void> insertJournals(MainJournals journals) async {
    Database db = await instance.database;
    Batch batch = db.batch();
    journals.data.data.forEach((element) {
      batch.insert(DatabaseSchema.journalsTable, element.toJson());
    });
    await batch.commit();
  }

  Future<List<Journal>> readJournals(offset) async {
    Database db = await instance.database;
    final respose = await db.query(
      DatabaseSchema.journalsTable,
      limit: 10,
      offset: offset,
    );

    List<Journal> result = [];
    respose.forEach((element) {
      result.add(Journal.fromJson(element));
    });

    return result;
  }

  Future<int> deleteJournals() async {
    Database db = await instance.database;
    final result = await db.delete(DatabaseSchema.journalsTable);
    return result;
  }

  Future<void> insertCategories(Categories categories) async {
    Database db = await instance.database;
    Batch batch = db.batch();
    categories.categories.forEach((element) {
      batch.insert(DatabaseSchema.categoriesTable, element.toJson());
    });
    await batch.commit();
  }

  Future<List<Category>> readCategories() async {
    Database db = await instance.database;
    final respose = await db.query(
      DatabaseSchema.categoriesTable,
    );

    List<Category> result = [];
    respose.forEach((element) {
      result.add(Category.fromJson(element));
    });

    return result;
  }

  Future<int> deleteCategories() async {
    Database db = await instance.database;
    final result = await db.delete(DatabaseSchema.categoriesTable);
    return result;
  }
}
