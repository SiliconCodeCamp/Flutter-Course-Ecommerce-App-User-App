import 'package:ecommerce_user_app/Models/User.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'RatingModel.freezed.dart';
part 'RatingModel.g.dart';

@unfreezed
class ratingModel with _$ratingModel{

  @JsonSerializable(explicitToJson:true)

  factory ratingModel({

    required user appuser ,
    required num rating,

}) = _ratingModel;

  factory ratingModel.fromJson(Map<String,dynamic> json )=>
      _$ratingModelFromJson(json);


}