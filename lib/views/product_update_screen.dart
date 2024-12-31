import 'package:flutter/material.dart';
import 'package:flutter_rest_api/rest_api/rest_client.dart';
import 'package:flutter_rest_api/styles/styles.dart';
import 'package:flutter_rest_api/utils/utils.dart';
import 'package:flutter_rest_api/views/product_screen.dart';

class ProductUpdateScreen extends StatefulWidget {
  final Map<String, dynamic> formSingleData;

  const ProductUpdateScreen({super.key, required this.formSingleData});

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  // created a rest_client object
  RestClient restClient = RestClient();
  late String _id;
  late  Map<String, String> formData;

  @override
  void initState() {
    super.initState();
    _id =  widget.formSingleData['_id'];
    formData = {
      '_id': widget.formSingleData['_id'],
      'Img': widget.formSingleData['Img'],
      'ProductCode': widget.formSingleData['ProductCode'],
      'ProductName': widget.formSingleData['ProductName'],
      'Qty': widget.formSingleData['Qty'],
      'TotalPrice': widget.formSingleData['TotalPrice'],
      'UnitPrice': widget.formSingleData['UnitPrice'],
    };
  }

  bool isLoading = false;

  void inputOnChange(String key, String textValue) {
    setState(() {
      formData.update(key, (value) => textValue);
    });
  }

  void moveToProductScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductScreen())
    );
  }

  void formOnSubmit() async {
    if (formData['ProductName'] == '') {
      AppUtils.errorToast('Product name required');
    } else if (formData['ProductCode'] == '') {
      AppUtils.errorToast('Product code required');
    } else if (formData['Img'] == '') {
      AppUtils.errorToast('Image link required');
    } else if (formData['UnitPrice'] == '') {
      AppUtils.errorToast('Unit price required');
    } else if (formData['TotalPrice'] == '') {
      AppUtils.errorToast('Total price required');
    } else if (formData['Qty'] == '') {
      AppUtils.errorToast('Quantity required');
    } else {
      setState(() {
        isLoading = true;
      });

      // Product update request
      await restClient.productUpdateRequest(formData, _id);

      setState(() {
        isLoading = false;
      });

      AppUtils.successToast('Successfully updated');

      moveToProductScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.colorGreen,
        title: const Text(
          'Update Product',
          style: TextStyle(
            color: AppStyles.colorWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: isLoading ? Center(
              child: CircularProgressIndicator(),
            ) : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      inputOnChange('ProductName', value);
                    },
                    initialValue: formData['ProductName'],
                    decoration: AppStyles.inputDecoration('Product name'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      inputOnChange('ProductCode', value);
                    },
                    initialValue: formData['ProductCode'],
                    decoration: AppStyles.inputDecoration('Product code'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      inputOnChange('Img', value);
                    },
                    initialValue: formData['Img'],
                    decoration: AppStyles.inputDecoration('Product image'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      inputOnChange('UnitPrice', value);
                    },
                    initialValue: formData['UnitPrice'],
                    decoration: AppStyles.inputDecoration('Unit price'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      inputOnChange('TotalPrice', value);
                    },
                    initialValue: formData['TotalPrice'],
                    decoration: AppStyles.inputDecoration('Total price'),
                  ),
                  const SizedBox(height: 20),
                  AppStyles.appDropDownStyle(
                    DropdownButton(
                      value: formData['Qty'],
                      isExpanded: true,
                      underline: Container(),
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 16,
                      ),
                      dropdownColor: Colors.white,
                      items: [
                        DropdownMenuItem(
                          value: '',
                          child: Text('Select Qt'),
                        ),
                        DropdownMenuItem(
                          value: '1 pcs',
                          child: Text('1 pcs'),
                        ),
                        DropdownMenuItem(
                          value: '2 pcs',
                          child: Text('2 pcs'),
                        ),
                        DropdownMenuItem(
                          value: '3 pcs',
                          child: Text('3 pcs'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != 'Select Qt') {
                          inputOnChange("Qty", value!);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        formOnSubmit();
                      },
                      style: AppStyles.appButtonStyle(),
                      child: const Text('Update', style: TextStyle(
                        color: AppStyles.colorWhite,
                        fontWeight: FontWeight.w500,
                      ),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
