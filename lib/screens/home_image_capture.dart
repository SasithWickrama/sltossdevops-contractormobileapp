import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../components/custom_button.dart';
import '../components/custom_cardview.dart';
import '../components/select_search.dart';
import '../providers/home_provider.dart';
import '../providers/location_provider.dart';
import '../utils/size_config.dart';
import '../utils/util_functions.dart';

class ImageCapture extends StatefulWidget {
  const ImageCapture({super.key});

  @override
  State<ImageCapture> createState() => _ImageCaptureState();
}

bool _isloading = false;
String picLon = "";
String picLat = "";
bool _uploadbtnVisibility = false;
bool _pendingImage = true;

class _ImageCaptureState extends State<ImageCapture> {
  @override
  Widget build(BuildContext context) {
    CameraPosition _myLocation =
        CameraPosition(target: LatLng(6.935056, 79.8464645));

    return Provider.of<HomeProvider>(context).imgVisibility
        ? Consumer<HomeProvider>(builder: (context, providerValue, child) {
            return CustomCardView(
              wigetList: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SelectSearch(
                      text: "Quality Image",
                      displayitems: providerValue.imgList,
                      selectedValue: providerValue.selectedImage.imgname,
                      onTap: (value) {
                        _uploadbtnVisibility = false;
                        if (value != null) {
                          providerValue.showImgToCapture(context,
                              providerValue.imgList.indexOf(value.toString()));
                        } else {
                          providerValue.showImgToCapture(context, -1);
                          picLat = "";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: providerValue.img1Visibility,
                      child: InkWell(
                        onTap: () {
                          if (_pendingImage) {
                            setState(() {
                              _pendingImage = false;
                            });
                            Provider.of<LocationProvider>(context,
                                    listen: false)
                                .returnLoc(context)
                                .then((value) {
                              if (value == null) {
                                setState(() {
                                  _pendingImage = true;
                                });
                                return false;
                              } else {
                                picLon = value.longitude.toString();
                                picLat = value.latitude.toString();
                                // _myLocation = CameraPosition(
                                //   target:
                                //       LatLng(value.latitude, value.longitude),
                                //   zoom: 14.4746,
                                // );
                                UtilFunction.pickImage(
                                        context,
                                        picLon,
                                        picLat,
                                        providerValue.selectedImage.imgname,
                                        providerValue
                                            .qualityImgList[providerValue
                                                .imgList
                                                .indexOf(providerValue
                                                    .selectedImage.imgname)]
                                            .source,
                                        providerValue.newJob.soID!)
                                    .then((value) {
                                  setState(() {
                                    _pendingImage = true;
                                    _uploadbtnVisibility = true;
                                    if (!value.error) {
                                      providerValue.image1 = value.data;

                                      setState(() {});
                                    }
                                  });
                                });
                              }
                            });
                          }
                        },
                        child: providerValue.image1 == null
                            ? Image.asset(
                                _pendingImage
                                    ? 'assets/images/cameraimage.jpg'
                                    : 'assets/images/loading5.gif',
                                // ? 'https://static.vecteezy.com/system/resources/previews/004/511/733/original/camera-icon-on-white-background-vector.jpg'
                                // : 'https://www.perodua.com.my/assets/gif/loading5.gif',
                                height: SizeConfig.w(context) / 1.4,
                                width: SizeConfig.w(context) / 1.5,
                              )
                            : InteractiveViewer(
                                panEnabled: false, // Set it to false
                                boundaryMargin: const EdgeInsets.all(100),
                                minScale: 1,
                                maxScale: 5,
                                child: Image.file(
                                  File(providerValue.image1),
                                  height: SizeConfig.w(context) / 1.4,
                                  width: SizeConfig.w(context) / 1.5,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                      child: Text(providerValue.att.att_cusLat == "" ||
                              picLat == ""
                          ? ''
                          : 'Distance from customer location is ${Geolocator.distanceBetween(double.parse(picLat), double.parse(picLon), double.parse(providerValue.att.att_cusLat!), double.parse(providerValue.att.att_cusLon!)).toStringAsFixed(2)} m'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                      child: CustomButton(
                        isLoading: _isloading,
                        text: 'Upload',
                        btnwidth: SizeConfig.w(context) / 1.2,
                        onTap: () {
                          setState(() {
                            _isloading = true;
                          });
                          providerValue
                              .uploadImgCapture(context, picLat, picLon, false)
                              .then((value) {
                            providerValue.getImageList(context);
                            providerValue.showImgToCapture(context, -1);
                            setState(() {
                              _isloading = false;
                              picLat = "";
                            });
                          });
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                      child: CustomButton(
                        isLoading: _isloading,
                        text: 'Upload & Save',
                        btnwidth: SizeConfig.w(context) / 1.2,
                        onTap: () {
                          setState(() {
                            _isloading = true;
                          });
                          providerValue
                              .uploadImgCapture(context, picLat, picLon, true)
                              .then((value) {
                            providerValue.getImageList(context);
                            providerValue.showImgToCapture(context, -1);
                            setState(() {
                              _isloading = false;
                              picLat = "";
                            });
                          });
                        },
                      ),
                    ),
                    // SizedBox(
                    //   height: SizeConfig.w(context) / 1.4,
                    //   child: GoogleMap(
                    //     initialCameraPosition: _myLocation,
                    //   ),
                    // ),
                  ],
                )
              ],
            );
          })
        : Container();
  }
}
