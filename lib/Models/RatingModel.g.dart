// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RatingModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ratingModelImpl _$$ratingModelImplFromJson(Map<String, dynamic> json) =>
    _$ratingModelImpl(
      appuser: user.fromJson(json['appuser'] as Map<String, dynamic>),
      rating: json['rating'] as num,
    );

Map<String, dynamic> _$$ratingModelImplToJson(_$ratingModelImpl instance) =>
    <String, dynamic>{
      'appuser': instance.appuser.toJson(),
      'rating': instance.rating,
    };
