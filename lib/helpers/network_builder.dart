import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:website/models/categories_model.dart';
import 'package:website/models/da_job_model.dart';
import 'package:website/models/jobs_model.dart';
import 'package:website/models/journals_model.dart';
import 'package:website/models/posts_model.dart';
import 'package:website/models/prices_model.dart';

part 'network_builder.g.dart';

class APIs {
  static const String prices = 'get_exchange_rates';
  static const String categories = 'categories';
  static const String posts = 'posts';
  static const String journals = 'get_jouranls_list';
  static const String jobs = 'jobs';
  static const String job = 'job';
}

@RestApi(baseUrl: 'http://www.ri-bu.com/api/')
abstract class NetworkBuilder {
  factory NetworkBuilder(Dio dio, {String baseUrl}) = _NetworkBuilder;

  @GET(APIs.prices)
  Future<PricesModel> getPrices();

  @GET(APIs.categories)
  Future<Categories> getCategories();

  @GET(APIs.posts)
  Future<MainPosts> getPosts(
    @Query("page") int page,
  );

  @GET(APIs.journals)
  Future<MainJournals> getJournal(
    @Query("page") int page,
  );

  @GET(APIs.jobs)
  Future<MainJobs> getJobs(
    @Query("page") int page,
  );

  @GET(APIs.job + "{id}")
  Future<MainJob> getJob(
    @Path("id") String id,
  );
}
