import 'package:equatable/equatable.dart';
class NationalIdInfoEntity extends Equatable {
  final String? nid;
  final String? nidImg;

  const NationalIdInfoEntity({
     this.nid,
     this.nidImg,
  });

  @override
  List<Object?> get props => [nid, nidImg];
}
