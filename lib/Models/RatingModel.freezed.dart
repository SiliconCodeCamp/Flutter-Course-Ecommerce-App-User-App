// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'RatingModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ratingModel _$ratingModelFromJson(Map<String, dynamic> json) {
  return _ratingModel.fromJson(json);
}

/// @nodoc
mixin _$ratingModel {
  user get appuser => throw _privateConstructorUsedError;
  set appuser(user value) => throw _privateConstructorUsedError;
  num get rating => throw _privateConstructorUsedError;
  set rating(num value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ratingModelCopyWith<ratingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ratingModelCopyWith<$Res> {
  factory $ratingModelCopyWith(
          ratingModel value, $Res Function(ratingModel) then) =
      _$ratingModelCopyWithImpl<$Res, ratingModel>;
  @useResult
  $Res call({user appuser, num rating});

  $userCopyWith<$Res> get appuser;
}

/// @nodoc
class _$ratingModelCopyWithImpl<$Res, $Val extends ratingModel>
    implements $ratingModelCopyWith<$Res> {
  _$ratingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appuser = null,
    Object? rating = null,
  }) {
    return _then(_value.copyWith(
      appuser: null == appuser
          ? _value.appuser
          : appuser // ignore: cast_nullable_to_non_nullable
              as user,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as num,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $userCopyWith<$Res> get appuser {
    return $userCopyWith<$Res>(_value.appuser, (value) {
      return _then(_value.copyWith(appuser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ratingModelImplCopyWith<$Res>
    implements $ratingModelCopyWith<$Res> {
  factory _$$ratingModelImplCopyWith(
          _$ratingModelImpl value, $Res Function(_$ratingModelImpl) then) =
      __$$ratingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({user appuser, num rating});

  @override
  $userCopyWith<$Res> get appuser;
}

/// @nodoc
class __$$ratingModelImplCopyWithImpl<$Res>
    extends _$ratingModelCopyWithImpl<$Res, _$ratingModelImpl>
    implements _$$ratingModelImplCopyWith<$Res> {
  __$$ratingModelImplCopyWithImpl(
      _$ratingModelImpl _value, $Res Function(_$ratingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appuser = null,
    Object? rating = null,
  }) {
    return _then(_$ratingModelImpl(
      appuser: null == appuser
          ? _value.appuser
          : appuser // ignore: cast_nullable_to_non_nullable
              as user,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ratingModelImpl implements _ratingModel {
  _$ratingModelImpl({required this.appuser, required this.rating});

  factory _$ratingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ratingModelImplFromJson(json);

  @override
  user appuser;
  @override
  num rating;

  @override
  String toString() {
    return 'ratingModel(appuser: $appuser, rating: $rating)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ratingModelImplCopyWith<_$ratingModelImpl> get copyWith =>
      __$$ratingModelImplCopyWithImpl<_$ratingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ratingModelImplToJson(
      this,
    );
  }
}

abstract class _ratingModel implements ratingModel {
  factory _ratingModel({required user appuser, required num rating}) =
      _$ratingModelImpl;

  factory _ratingModel.fromJson(Map<String, dynamic> json) =
      _$ratingModelImpl.fromJson;

  @override
  user get appuser;
  set appuser(user value);
  @override
  num get rating;
  set rating(num value);
  @override
  @JsonKey(ignore: true)
  _$$ratingModelImplCopyWith<_$ratingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
