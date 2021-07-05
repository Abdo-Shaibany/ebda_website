import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:website/helpers/behaviors.dart';
import 'package:website/helpers/data.dart';
import 'package:website/helpers/network_builder.dart';
import 'package:website/helpers/pages_ids.dart';
import 'package:website/models/categories_model.dart';
import 'package:website/models/da_job_model.dart';
import 'package:website/models/jobs_model.dart';
import 'package:website/models/journals_model.dart';
import 'package:website/models/posts_model.dart';
import 'package:website/models/prices_model.dart';

part 'bloc_event.dart';
part 'bloc_state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  BlocBloc() : super(BlocInitial());

  static final client = NetworkBuilder(
    Dio(
      BaseOptions(
        contentType: "application/json",
        headers: {"accept": "application/json"},
        followRedirects: false,
      ),
    ),
  );

  @override
  Stream<BlocState> mapEventToState(
    BlocEvent event,
  ) async* {
    if (event is GetNextItems) {
      yield Loading(pageId: event.pageId);
      try {
        if (event.pageId == PageId.Blog) {
          try {
            int pageNo = DataCenter.instance.currentBlogFilter == 1
                ? DataCenter.instance.posts.posts.lastPage - event.pageNo + 1
                : event.pageNo;
            MainPosts posts = await Behaviors.getPosts(pageNo);
            DataCenter.instance.posts = posts;
            if (DataCenter.instance.categories == null) {
              Categories categories = await Behaviors.getCategories();
              DataCenter.instance.categories = categories;
            }

            yield Ok(pageId: event.pageId);
          } catch (err) {
            yield Error(pageId: event.pageId);
          }
        } else if (event.pageId == PageId.Comments) {
          await Future.delayed(Duration(seconds: 1));
          // if offset 0 check internet then update data
          // if not 0 then check hive then internet
        } else if (event.pageId == PageId.Jobs) {
          yield Loading(pageId: event.pageId);
          try {
            MainJobs jobs = await Behaviors.getJobs(event.pageNo);
            DataCenter.instance.jobs = jobs;

            yield Ok(pageId: event.pageId);
          } catch (err) {
            yield Error(pageId: event.pageId);
          }
        } else if (event.pageId == PageId.Journals) {
          yield Loading(pageId: event.pageId);
          try {
            MainJournals journals = await Behaviors.getJournals(event.pageNo);
            DataCenter.instance.journals = journals;

            yield Ok(pageId: event.pageId);
          } catch (err) {
            yield Error(pageId: event.pageId);
          }
        } else if (event.pageId == PageId.Categories) {
          await Future.delayed(Duration(seconds: 1));
        } else if (event.pageId == PageId.MyArticals) {
          await Future.delayed(Duration(seconds: 1));
        } else if (event.pageId == PageId.Search) {
          await Future.delayed(Duration(seconds: 1));
        }
        yield Ok(pageId: event.pageId);
      } catch (ex) {
        yield Error(pageId: event.pageId);
      }
    } else if (event is GetArticalContent) {
      yield Loading(pageId: event.pageId);
      try {
        // CHECK CACH if not then go to internet
        // GET IT FROM INTERNET
        await Future.delayed(Duration(seconds: 4));
      } catch (err) {
        yield Error(pageId: event.pageId);
        return;
      }
      yield Ok(pageId: event.pageId);
    } else if (event is AddComment) {
      yield Loading(pageId: PageId.AddComment);
      try {
        await Future.delayed(Duration(seconds: 1));
        yield Ok(pageId: PageId.AddComment);
      } on Exception catch (e) {
        yield Error(pageId: PageId.AddComment);
      }
    } else if (event is GetPrices) {
      yield Loading(pageId: PageId.Prices);
      try {
        PricesModel output = await Behaviors.getPrices();
        DataCenter.instance.prices = output;
        yield Ok(pageId: PageId.Prices);
      } catch (err) {
        yield Error(pageId: PageId.Prices);
      }
    } else if (event is Query) {
      yield Loading(pageId: PageId.Search);
      try {
        await Future.delayed(Duration(seconds: 2));
        yield Ok(pageId: PageId.Search);
      } catch (err) {
        yield Error(pageId: PageId.Search);
      }
    } else if (event is LogIn) {
      yield Loading(pageId: PageId.SignIn);
      try {
        await Future.delayed(Duration(seconds: 2));

        yield Ok(pageId: PageId.SignIn);
      } catch (err) {
        yield Error(pageId: PageId.SignIn);
      }
    } else if (event is GetCategories && event.pageId == PageId.CreatePost) {
      yield Loading(pageId: PageId.CreatePost);
      try {
        await Future.delayed(Duration(seconds: 2));
        yield Ok(pageId: PageId.CreatePost);
      } catch (err) {
        yield Error(pageId: PageId.CreatePost);
      }
    } else if (event is GetEditPostContent) {
      yield Loading(pageId: PageId.CreatePost);
      try {
        await Future.delayed(Duration(seconds: 2));
        yield Ok(pageId: PageId.CreatePost);
      } catch (err) {
        yield Error(pageId: PageId.CreatePost);
      }
    } else if (event is GetEditPostContent) {
      yield Loading(pageId: PageId.CreatePost);
      try {
        await Future.delayed(Duration(seconds: 2));
        yield Ok(pageId: PageId.CreatePost);
      } catch (err) {
        yield Error(pageId: PageId.CreatePost);
      }
    }
  }
}
