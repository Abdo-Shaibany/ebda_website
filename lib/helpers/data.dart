import 'package:website/bloc/bloc_bloc.dart';
import 'package:website/helpers/pages_ids.dart';
import 'package:website/models/categories_model.dart';
import 'package:website/models/jobs_model.dart';
import 'package:website/models/journals_model.dart';
import 'package:website/models/posts_model.dart';
import 'package:website/models/prices_model.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:hive/hive.dart';

class DataCenter {
  static final BlocBloc userAuthBloc = BlocBloc();
  DataCenter._privateConstructor();

  static final DataCenter instance = DataCenter._privateConstructor();
  String content = """
<div class="contact-info-box"><div class="text-center"><img class="img-responsive" style="width: 100%" src="https://ri-bu.com/upload/posts_image/1618652046.jpg"></div><br><div class="page_content"><p dir="rtl"><span style="font-family: terminal, monaco, monospace; font-size: 14pt;">قال الدكتور عبد الهادي الهمداني رئيس جامعة المستقبل: لا تقوم نهضة أي أمة إلا بتعليم أبنائها، فإذا أردنا بناء اقتصاد يجب أن تركز جهودنا على تعلم أولادنا، واعطائهم من وقتنا وتجاربنا، لأنه إذا تعلم الإنسان يصبح ناجح على المستوى الشخصي، ناجح مع زوجته، مع أولاده، مع أقرباءه، ثم ناجح في المجتمع.</span></p><p dir="rtl">&nbsp;</p><p dir="rtl"><span style="font-family: terminal, monaco, monospace; font-size: 14pt;">وأشار في مقابلة حصرية مع مجلة ريادة الأعمال –<span style="color: #ba372a;"> سيتم نشرها لاحقا-</span> إلى دور التعليم في نهضة اليابان بعد تعرضها للدمار وكيف استطاعت بفترة قصيرة أن تصل إلى مقدمة الدول المتطورة في العالم.</span></p><p dir="rtl"><span style="font-family: terminal, monaco, monospace; font-size: 14pt;">&nbsp;</span></p><p dir="rtl"><span style="font-family: terminal, monaco, monospace; font-size: 14pt;">وفي حديثه عن الاستثمار في اليمن قال: إن الاستغلال الأمثل للثروات في اليمن ممكن أن يصنع اقتصادها، فيرى أن اليمن بلد خير وفيه من التراث الحضاري والتنوع الثقافي ما لا يتواجد في العالم.</span></p><p dir="rtl">&nbsp;</p><p dir="rtl"><span style="font-family: terminal, monaco, monospace; font-size: 14pt;">ولفت الهمداني إلى أن الاستثمار في اليمن مقرون بالخبرات الشبابية والاستغلال الأمثل للثروات والعقول المبدعة، وبطبيعة الحال لابد من وجود رأس مال يقوم بتوفر احتياجات رواد الأعمال.</span></p><p dir="rtl">&nbsp;</p><p dir="rtl"><span style="font-family: terminal, monaco, monospace; font-size: 14pt;">وأضاف: إن مواجهه مرحلة ما بعد الحرب تقع على عاتق الجميع وليس على السياسيين والبرلمانيين فقط، وبتضافر جميع الناس ستكون اليمن بلد له شأن، مما سيؤثر ذلك على تعزيز روح الاستثمار في اليمن.</span></p><p dir="rtl">&nbsp;</p><p dir="rtl"><span style="font-family: terminal, monaco, monospace; font-size: 14pt;">&nbsp;وأكد الهمداني في ختام حديثة على ضرورة دعم الدولة لرواد الأعمال الجدد والذين قد يكون لهم دور فعال بجانب الدولة، ومن جانب أخر على رواد الأعمال أن يتضامنوا مع بعضهم البعض في تأسيس مشاريعهم.</span></p><p dir="rtl">&nbsp;</p><p dir="rtl">&nbsp;</p></div><div class="title-section"><h1><span>شارك المنشور</span></h1></div><!-- Go to www.addthis.com/dashboard to customize your tools --><div class="addthis_inline_share_toolbox_igq6" data-url="https://ri-bu.com/post/%D8%A7%D9%84%D9%87%D9%85%D8%AF%D8%A7%D9%86%D9%8A:-%D8%A7%D9%84%D8%AA%D8%B9%D9%84%D9%8A%D9%85-%D9%85%D9%81%D8%AA%D8%A7%D8%AD-%D9%86%D9%87%D8%B6%D8%A9-%D8%A7%D9%84%D8%A8%D9%84%D8%AF%D8%A7%D9%86" data-title="الهمداني: التعليم مفتاح نهضة البلدان" style="clear: both;"><div id="atstbx" class="at-resp-share-element at-style-responsive addthis-smartlayers addthis-animated at4-show at-mobile" aria-labelledby="at-3a116ce5-7c31-49f3-9004-f43a6b59fb0e" role="region"><span id="at-3a116ce5-7c31-49f3-9004-f43a6b59fb0e" class="at4-visually-hidden">AddThis Sharing Buttons</span><div class="at-share-btn-elements"><a role="button" tabindex="0" class="at-icon-wrapper at-share-btn at-svc-facebook" style="background-color: rgb(59, 89, 152); border-radius: 0px;"><span class="at4-visually-hidden">Share to Facebook</span><span class="at-icon-wrapper" style="line-height: 32px; height: 32px; width: 32px;"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 32 32" version="1.1" role="img" aria-labelledby="at-svg-facebook-1" class="at-icon at-icon-facebook" style="fill: rgb(255, 255, 255); width: 32px; height: 32px;"><title id="at-svg-facebook-1">Facebook</title><g><path d="M22 5.16c-.406-.054-1.806-.16-3.43-.16-3.4 0-5.733 1.825-5.733 5.17v2.882H9v3.913h3.837V27h4.604V16.965h3.823l.587-3.913h-4.41v-2.5c0-1.123.347-1.903 2.198-1.903H22V5.16z" fill-rule="evenodd"></path></g></svg></span><span class="at-label" style="font-size: 11.4px; line-height: 32px; height: 32px; color: rgb(255, 255, 255);">Facebook</span></a><a role="button" tabindex="0" class="at-icon-wrapper at-share-btn at-svc-whatsapp" style="background-color: rgb(77, 194, 71); border-radius: 0px;"><span class="at4-visually-hidden">Share to WhatsApp</span><span class="at-icon-wrapper" style="line-height: 32px; height: 32px; width: 32px;"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 32 32" version="1.1" role="img" aria-labelledby="at-svg-whatsapp-2" class="at-icon at-icon-whatsapp" style="fill: rgb(255, 255, 255); width: 32px; height: 32px;"><title id="at-svg-whatsapp-2">WhatsApp</title><g><path d="M19.11 17.205c-.372 0-1.088 1.39-1.518 1.39a.63.63 0 0 1-.315-.1c-.802-.402-1.504-.817-2.163-1.447-.545-.516-1.146-1.29-1.46-1.963a.426.426 0 0 1-.073-.215c0-.33.99-.945.99-1.49 0-.143-.73-2.09-.832-2.335-.143-.372-.214-.487-.6-.487-.187 0-.36-.043-.53-.043-.302 0-.53.115-.746.315-.688.645-1.032 1.318-1.06 2.264v.114c-.015.99.472 1.977 1.017 2.78 1.23 1.82 2.506 3.41 4.554 4.34.616.287 2.035.888 2.722.888.817 0 2.15-.515 2.478-1.318.13-.33.244-.73.244-1.088 0-.058 0-.144-.03-.215-.1-.172-2.434-1.39-2.678-1.39zm-2.908 7.593c-1.747 0-3.48-.53-4.942-1.49L7.793 24.41l1.132-3.337a8.955 8.955 0 0 1-1.72-5.272c0-4.955 4.04-8.995 8.997-8.995S25.2 10.845 25.2 15.8c0 4.958-4.04 8.998-8.998 8.998zm0-19.798c-5.96 0-10.8 4.842-10.8 10.8 0 1.964.53 3.898 1.546 5.574L5 27.176l5.974-1.92a10.807 10.807 0 0 0 16.03-9.455c0-5.958-4.842-10.8-10.802-10.8z" fill-rule="evenodd"></path></g></svg></span><span class="at-label" style="font-size: 11.4px; line-height: 32px; height: 32px; color: rgb(255, 255, 255);">WhatsApp</span></a><a role="button" tabindex="0" class="at-icon-wrapper at-share-btn at-svc-twitter" style="background-color: rgb(29, 161, 242); border-radius: 0px;"><span class="at4-visually-hidden">Share to Twitter</span><span class="at-icon-wrapper" style="line-height: 32px; height: 32px; width: 32px;"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 32 32" version="1.1" role="img" aria-labelledby="at-svg-twitter-3" class="at-icon at-icon-twitter" style="fill: rgb(255, 255, 255); width: 32px; height: 32px;"><title id="at-svg-twitter-3">Twitter</title><g><path d="M27.996 10.116c-.81.36-1.68.602-2.592.71a4.526 4.526 0 0 0 1.984-2.496 9.037 9.037 0 0 1-2.866 1.095 4.513 4.513 0 0 0-7.69 4.116 12.81 12.81 0 0 1-9.3-4.715 4.49 4.49 0 0 0-.612 2.27 4.51 4.51 0 0 0 2.008 3.755 4.495 4.495 0 0 1-2.044-.564v.057a4.515 4.515 0 0 0 3.62 4.425 4.52 4.52 0 0 1-2.04.077 4.517 4.517 0 0 0 4.217 3.134 9.055 9.055 0 0 1-5.604 1.93A9.18 9.18 0 0 1 6 23.85a12.773 12.773 0 0 0 6.918 2.027c8.3 0 12.84-6.876 12.84-12.84 0-.195-.005-.39-.014-.583a9.172 9.172 0 0 0 2.252-2.336" fill-rule="evenodd"></path></g></svg></span><span class="at-label" style="font-size: 11.4px; line-height: 32px; height: 32px; color: rgb(255, 255, 255);">Twitter</span></a><a role="button" tabindex="0" class="at-icon-wrapper at-share-btn at-svc-telegram" style="background-color: rgb(0, 136, 204); border-radius: 0px;"><span class="at4-visually-hidden">Share to Telegram</span><span class="at-icon-wrapper" style="line-height: 32px; height: 32px; width: 32px;"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 32 32" version="1.1" role="img" aria-labelledby="at-svg-telegram-4" class="at-icon at-icon-telegram" style="fill: rgb(255, 255, 255); width: 32px; height: 32px;"><title id="at-svg-telegram-4">Telegram</title><g><g fill-rule="evenodd"></g><path d="M15.02 20.814l9.31-12.48L9.554 17.24l1.92 6.42c.225.63.114.88.767.88l.344-5.22 2.436 1.494z" opacity=".6"></path><path d="M12.24 24.54c.504 0 .727-.234 1.008-.51l2.687-2.655-3.35-2.054-.344 5.22z" opacity=".3"></path><path d="M12.583 19.322l8.12 6.095c.926.52 1.595.25 1.826-.874l3.304-15.825c.338-1.378-.517-2.003-1.403-1.594L5.024 14.727c-1.325.54-1.317 1.29-.24 1.625l4.98 1.58 11.53-7.39c.543-.336 1.043-.156.633.214"></path></g></svg></span><span class="at-label" style="font-size: 11.4px; line-height: 32px; height: 32px; color: rgb(255, 255, 255);">Telegram</span></a><a role="button" tabindex="0" class="at-icon-wrapper at-share-btn at-svc-email" style="background-color: rgb(132, 132, 132); border-radius: 0px;"><span class="at4-visually-hidden">Share to ارسال ايميل</span><span class="at-icon-wrapper" style="line-height: 32px; height: 32px; width: 32px;"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 32 32" version="1.1" role="img" aria-labelledby="at-svg-email-5" class="at-icon at-icon-email" style="fill: rgb(255, 255, 255); width: 32px; height: 32px;"><title id="at-svg-email-5">Email</title><g><g fill-rule="evenodd"></g><path d="M27 22.757c0 1.24-.988 2.243-2.19 2.243H7.19C5.98 25 5 23.994 5 22.757V13.67c0-.556.39-.773.855-.496l8.78 5.238c.782.467 1.95.467 2.73 0l8.78-5.238c.472-.28.855-.063.855.495v9.087z"></path><path d="M27 9.243C27 8.006 26.02 7 24.81 7H7.19C5.988 7 5 8.004 5 9.243v.465c0 .554.385 1.232.857 1.514l9.61 5.733c.267.16.8.16 1.067 0l9.61-5.733c.473-.283.856-.96.856-1.514v-.465z"></path></g></svg></span><span class="at-label" style="font-size: 11.4px; line-height: 32px; height: 32px; color: rgb(255, 255, 255);">ارسال ايميل</span></a><a role="button" tabindex="0" class="at-icon-wrapper at-share-btn at-svc-compact" style="background-color: rgb(255, 101, 80); border-radius: 0px;"><span class="at4-visually-hidden">Share to المزيد</span><span class="at-icon-wrapper" style="line-height: 32px; height: 32px; width: 32px;"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 32 32" version="1.1" role="img" aria-labelledby="at-svg-addthis-6" class="at-icon at-icon-addthis" style="fill: rgb(255, 255, 255); width: 32px; height: 32px;"><title id="at-svg-addthis-6">AddThis</title><g><path d="M18 14V8h-4v6H8v4h6v6h4v-6h6v-4h-6z" fill-rule="evenodd"></path></g></svg></span><span class="at-label" style="font-size: 11.4px; line-height: 32px; height: 32px; color: rgb(255, 255, 255);">المزيد</span></a></div></div></div></div>
  """;

  List<String> blogFilters = ['newest'.tr(), 'oldest'.tr(), 'most read'.tr()];
  int currentBlogFilter = 0;

  Categories categories;
  int currentCategoryIndex = 0;

  MainPosts posts;
  PricesModel prices;
  MainJobs jobs;
  MainJournals journals;

  int getTotal(pageId) {
    switch (pageId) {
      case PageId.Jobs:
        return jobs.data.lastPage;
      case PageId.Journals:
        return journals.data.lastPage;
      default:
        return 0;
    }
  }

  // global
  List<dynamic> getNext(pageId) {
    switch (pageId) {
      case PageId.Jobs:
        return jobs.data.data;
      case PageId.Journals:
        return journals.data.data;
      case PageId.Categories:
        // TODO:
        return [];
      case PageId.MyArticals:
        // TODO:
        return [];
      default:
        return [];
    }
  }

  List<String> getPostLanguages(postId) {
    return ['ar', 'en'];
  }
}
