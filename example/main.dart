import 'dart:math';

import 'package:angel_route/angel_route.dart';

main() {
  final router = new Router();

  router.get('/users', () {});

  router.post('/users/:id/timeline', (String id) {});

  router.get('/square_root/:id([0-9]+)', (String n) {
    return {'result': pow(int.parse(n), 0.5)};
  });

  // You can also have parameters auto-parsed.
  //
  // Supports int, double, and num.
  router.get('/square_root/int:id([0-9]+)', (int n) {
    return {'result': pow(n, 0.5)};
  });

  router.group('/show/:id', (router) {
    router.get('/reviews', (id) {
      return someQuery(id).reviews;
    });

    // Optionally restrict params to a RegExp
    router.get('/reviews/:reviewId([A-Za-z0-9_]+)', (id, reviewId) {
      return someQuery(id).reviews.firstWhere((r) => r.id == reviewId);
    });
  });
}

SomeQuery someQuery(id) => new SomeQuery();

class SomeQuery {
  List<SomeQueryReview> get reviews => [
        SomeQueryReview('fake'),
        SomeQueryReview('data'),
      ];
}

class SomeQueryReview {
  final String id;

  SomeQueryReview(this.id);
}
