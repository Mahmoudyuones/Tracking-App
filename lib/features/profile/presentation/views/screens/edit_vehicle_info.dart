import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tracking_app/config/di/di.dart';

import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/request_state/request_state.dart';
import '../../../../../core/style/color/app_colors.dart';
import '../../../api/models/edit_profile/request/edit_vehicle_request.dart';
import '../../../domain/entity/driver_all_info_entity.dart';
import '../../view_model/edit_profile_view_model/edit_profile_bloc.dart';
import '../widgets/custom_btn.dart';
import '../widgets/custom_txt_field.dart';
import '../widgets/load_image.dart';

const List<Map<String, String>> vehicles = [
  {
    '_id': '676b63c99f3884b3405c149b',
    'type': 'Motor Cycle',
  },
  {
    '_id': '676b63ef9f3884b3405c14a5',
    'type': 'Compact',
  },
  {
    '_id': '676b63fc9f3884b3405c14ad',
    'type': 'Sedan',
  },
  {
    '_id': '676b640e9f3884b3405c14b5',
    'type': 'Semi',
  },
  {
    '_id': '676b641c9f3884b3405c14bd',
    'type': 'Sports',
  },
  {
    '_id': '676b64279f3884b3405c14c5',
    'type': 'SUV',
  },
  {
    '_id': '676b64349f3884b3405c14cd',
    'type': 'Truck',
  },
];
class EditVehicleInfo extends StatefulWidget {
  final DriverAllInfoEntity user;

  const EditVehicleInfo({required this.user, super.key});

  @override
  State<EditVehicleInfo> createState() => _EditVehicleInfoState();
}

class _EditVehicleInfoState extends State<EditVehicleInfo> {
  late String vehicleType;
  late TextEditingController vehicleNumber;
  File? vehicleLicense;

  Future<File> _saveTemporyFile(XFile pickedFiled) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
    final savedFile = await File(
      "${directory.path}/$fileName",
    ).writeAsBytes(await pickedFiled.readAsBytes());
    return savedFile;
  }

  Future<File?> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (pickedFile != null) {
      return await _saveTemporyFile(pickedFile);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    vehicleType = widget.user.vehicle?.vehicleType??'';
    vehicleNumber =
        TextEditingController(text: widget.user.vehicle?.vehicleNumber??'' );
  }

  @override
  void dispose() {
    vehicleNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => getIt<EditProfileBloc>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppTextString.editProfile),
              leading: IconButton(
                onPressed: () => Navigator.of(context).
                pop(true),
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 24,
                  color: AppColors.black,
                ),
              ),
              actions: [
                const Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Icon(
                      CupertinoIcons.bell,
                      color: AppColors.black,
                      size:32,
                    ),
                    CircleAvatar(
                      backgroundColor: AppColors.red,
                      radius: 10,
                      child: Text(
                        "3",
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: width*0.1),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DropdownButtonFormField(
                      validator: (value) =>
                      value == null ? AppTextString.vehicleTypeFieldError : null,
                      decoration: InputDecoration(
                        labelText: AppTextString.vehicleTypeLabel,
                      ),
                      items: vehicles.map((e) =>  DropdownMenuItem(
                        value: e['_id'],
                        child: Text(e['type']??''),
                      ),).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          vehicleType = value;
                          setState(() {});
                        }
                      },
                    ),
                    SizedBox(height: sh*0.01),
                    CustomTxtField(
                      hintTxt: AppTextString.vehicleNumberLabel,
                      lbl: AppTextString.vehicleNumberLabel,
                      controller: vehicleNumber,
                      validator: (value) =>
                      value == null ? AppTextString.vehicleNumberLabel : null,
                    ),
                    SizedBox(height: sh*0.01),
                    LoadImage(
                      file: vehicleLicense,
                      networkUrl: widget.user.vehicle?.vehicleLicense??'',
                      onTap: () async {
                        final file = await _pickImage();
                        if (file != null) {
                          setState(() {
                            vehicleLicense = file;
                          });
                        }
                      },
                      lbl: AppTextString.enterVehicleNumber,
                    ),
                    SizedBox(height: sh * 0.4),
                    BlocListener<EditProfileBloc, EditProfileState>(
                      listener: (context, state) {
                        if (state.editVehicleRequestState == RequestState.success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Updated the vehicle data'),
                            ),
                          );
                        }
                        if (state.editVehicleRequestState
                            ==RequestState.error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                        const   SnackBar(
                              content: Text("Something went Wrong"),
                            ),
                          );
                        }
                      },
                      child: CustomBtn(
                        bg: AppColors.midGray,
                        onPressed: () {
                          final request = EditVehicleRequest(
                            vehicleNumber: vehicleNumber.text,
                            vehicleType: vehicleType,
                            vehicleLicenseFile: vehicleLicense!
                          );
                          context.read<EditProfileBloc>().add(
                            EditVehicleBtnSubmitEvent(request),
                          );

                        },
                        txt: AppTextString.update,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
