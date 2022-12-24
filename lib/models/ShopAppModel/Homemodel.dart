class HomeModel {
bool ?status ;
HomeDataModel ?data ;


HomeModel.fromJson(Map<String,dynamic> json)
{
  status = json['status'] ;

  data   =HomeDataModel.fromjson(json['data']) ;
}
}



class HomeDataModel {
  List<BannerModel>banners = [];
  List<ProductModel>products = [];

  HomeDataModel.fromjson(Map<String, dynamic>json)
  {
    json['banners'].forEach((elements) {
      banners.add(BannerModel.fromJson(elements));
    }
    );
    json['products'].forEach((elements) {
      products.add(ProductModel.fromJson(elements));
    }
    );
  }
}
class BannerModel{

  int? id ;
  String? image ;
  BannerModel.fromJson(Map<String,dynamic> json)
  {
        id=json['id'] ;
        image=json['image'];
  }
}


class ProductModel{
  int? id ;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image ;
  String? name  ;
  bool? inFavourites ;
  bool? inCart ;
  String? description;
  ProductModel.fromJson(Map<String,dynamic> json)
  {
    id=json['id'] ;
    price=json['price'] ;
    oldPrice=json['old_price'] ;
    discount=json['discount'] ;
    image=json['image'] ;
    name=json['name'] ;
    inFavourites=json['in_favorites'] ;
    inCart=json['in_cart'] ;
    description=json['description'];

  }
}